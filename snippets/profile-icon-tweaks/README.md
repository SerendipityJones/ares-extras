# Profile Icon Tweaks

## Current Information

### Small Icon Shaping

If you would prefer your small and tiny icons to be **squares with rounded corners**:

![Small icons as rounded squares](small-icon-rounded-square.jpg)

    /* small and tiny icons as round-cornered squares */
    .small-profile-icon,
    .tiny-profile-icon {
        border-radius: 4px;
    }
    
...or if you'd like them to be **squares with sharp corners**:

![Small icons as sharp squares](small-icon-square.jpg)

    /* small and tiny icons as sharp-cornered squares */
    .small-profile-icon,
    .tiny-profile-icon {
        border-radius: 0px;
    }


## Legacy Information 

### Cropping and Positioning

By default, prior to version .72, if an image used as a Profile Icon was not exactly square, it was squished to a 1:1 ration where it was displayed as 'small' (Active Scenes list, marking a pose in a live scene, etc.) or tiny (e.g., the character-choice dropdown in a live scene). On the Characters directory page, tall images were cropped, but wide ones were squished into the space. The following CSS was offered for changing it, but is currently built-in, so you don't need to add it. However, this more or less still explains how it works!

#### Defaults:

![The default positioning/ratio as of Jan 2020](log-icon-default.jpg)
![Same for the small icons](small-icon-default.jpg)

Notice how Cecilia's image is vertically squished in the small icon, and Maximillian's is squished horizontally in both large and small icons. The CSS can be adjusted to always preserve the aspect ratio, but there is a trade-off here: portions that don't fit in the square will be cropped off. 

#### Cropped Only:

![The above with only object-fit applied](log-icon-cropped.jpg)
![Same for the small icons](small-icon-cropped.jpg)

Note how none of the images are squished now, but that Cecilia is a bit high in the frame; on a really tall and thin image, her head might be cut off entirely. However, adding 'object-position', which determines where the image is anchored, can minimize that as an issue. Without it, the image window will be centered on the center of the image; as written in this CSS, the picture will be anchored at the center horizontally, and vertically, it will begin 10% into the image from the top. This seems to be about the sweet spot for a low incidence of any really odd croppings.

#### Cropped and positioned at center & 10%:

![The above also positioned with object-position](log-icon-positioned.jpg)
![Same for the small icons](small-icon-positioned.jpg)

This creates a relatively pleasing arrangement for all the images. If someone's face is very low down on a tall, thin image, that probably won't look ideal, but it'll at least be almost identical to how it already looks in the default arrangement! 

(And remember: any player can always upload a version of their Profile Icon cropped exactly the way they want it, while still using whatever they like for the main Profile Image on their wiki page. See `/help/profile_tutorial#profile-image-and-icon` on your game's web portal for instructions.)

To set up cropping-and-positioning, this CSS could be copied and pasted into 'Custom CSS Style' (a.k.a custom_style.scss) under 'Website' in 'Admin > Setup', but this is no longer necessary as it's now the default arrangement.

    /* crop and position icons */
    log-icon,
    .relationship-icon,
    .small-profile-icon,
    .tiny-profile-icon {
        object-fit: cover;
        object-position: center 10%;
    }
    .log-icon {
        height: 150px;
        width: 150px;
    }
    .relationship-icon {
        height: 100px;
        width: 100px;
    }

&mdash; Contributed by [Ren](https://arescentral.aresmush.com/handle/Ren)
