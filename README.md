# Zim-Tiddlywiki-converter

I was a fan of [Zim wiki](http://zim-wiki.org/) and don't get me wrong I'm still a big fan of it but Its lack of support for MacOs made me sick.
 So I searched and found [tiddlywiki](http://tiddlywiki.com/) and yes, I loved it! but there was a problem which is the "Formatting difference".
 
 
I wrote this Script to Convert Zim-wiki formatting to Tiddlywiki's.



## Requirements
* *nix.


## Usage
**Step 1:**

clone or download the [repo](https://github.com/MoHD20/Zim-Tiddlywiki-converter)

**Step 2:**

Run it.

```
$bash Zim-tid-converter.sh /Zim/wiki/folder
```

this will produce `tids` directory in the script dir.

**Step 3:**

Install tiddlywiki on Node.js

follow [their wiki](https://github.com/Jermolene/TiddlyWiki5#installing-tiddlywiki-on-nodejs) to do this step.

**Step 4:**
move your tids to tiddlers directory in your new wiki. Restart.


## TO-DO:

Unfortunately, Currently the script can't do more than 2 layers (sub pages and directories). So by default it will process all Home* - Second* just fine, but if you have the third or more you would have to write the loops & conditions manually for now.


![screen shot 2017-09-07 at 2 36 49 am](https://user-images.githubusercontent.com/12420351/30139260-71e94f5e-9375-11e7-8ef3-335153da7b0b.png)

- [ ] Support infinite Sub pages.  


 I'm still not sure how to make that happens, So it may take sometime.
