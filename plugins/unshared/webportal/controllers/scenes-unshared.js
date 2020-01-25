import Controller from '@ember/controller';
import { set, computed } from '@ember/object';
import { inject as service } from '@ember/service';
import AuthenticatedController from 'ares-webportal/mixins/authenticated-controller';

export default Controller.extend(AuthenticatedController, {
    confirmDeleteScene: false,
    gameApi: service(),
    flashMessages: service(),
    gameSocket: service(),
    session: service(),

    refresh() {
      this.set('newActivity', false);
      this.send('reloadModel');
    },

    actions: { 

      deleteScene(id) {
        let api = this.gameApi;
        this.set('confirmDeleteScene', false);

        api.requestOne('deleteScene', { id: id })
        .then( (response) => {
            if (response.error) {
                return;
            }
            this.flashMessages.success('Scene' + id + ' has been deleted.');
            this.refresh(); 
        });
      },
      
      shareScene(id) {
        let api = this.gameApi;
        this.gameSocket.removeCallback('new_scene_activity');
          
        api.requestOne('changeSceneStatus', { id: id,
            status: 'share' }, null)
        .then( (response) => {
            if (response.error) {
                return;
            }
            this.flashMessages.success('Scene ' + id + ' has been shared.');
            this.refresh(); 
        });
      },

    }
});
