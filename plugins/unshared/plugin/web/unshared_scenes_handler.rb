module AresMUSH
  module Scenes
    class UnsharedScenesRequestHandler
      def handle(request)
        enactor = request.enactor
        
        error = Website.check_login(request, true)
        return error if error

        if (enactor)                 
          unshared = enactor.unshared_scenes.sort_by { |s| s.id.to_i }.map { |s| {
                  id: s.id,
                  title: s.title,
                  summary: Website.format_markdown_for_html(s.summary),
                  content_warning: s.content_warning,
                  limit: s.limit,
                  location: s.location,
                  icdate: s.icdate,
                  date_completed: s.date_completed,
                  time_left: time_left(s),
                  can_view: enactor && Scenes.can_read_scene?(enactor, s),
                  is_private: s.private_scene,
                  participants: Scenes.participants_and_room_chars(s)
                      .select { |p| !p.who_hidden }
                      .sort_by { |p| p.name }
                      .map { |p| { 
                         name: p.name, 
                         id: p.id, 
                         icon: Website.icon_for_char(p), 
                         status: Website.activity_status(p),
                         online: Login.is_online?(p),
                         last_posed: s.last_posed == p }},
                  scene_type: s.scene_type ? s.scene_type.titlecase : 'Unknown'
                }}
        else 
          unshared = nil
        end

        {
          unshared: unshared,
          unshared_deletion_on: Global.read_config('scenes', 'delete_unshared_scenes'),
          unshared_deletion_days: Global.read_config('scenes', 'unshared_scene_deletion_days'),
          unshared_warning_days: Global.read_config('scenes', 'unshared_scene_deletion_days') - Global.read_config('scenes', 'unshared_scene_warning_days')
        }

      end  

      def time_left(s)
          delete_days = Global.read_config('scenes', 'unshared_scene_deletion_days')

          if (Global.read_config("scenes", "delete_unshared_scenes"))
              elapsed_days = (Time.now - s.date_completed) / 86400
              remaining_days = delete_days - elapsed_days.round
          end
      end

    end
  end
end
