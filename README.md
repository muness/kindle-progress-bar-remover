# Progress Bar remover for eInk Kindles

Last year, I decided to get an Kindle Keyboard 3G, and I loved it.  The eInk display was much clearer than my previous LCD devices, I could read outside and the battery life was amazing.  However, I was surprised that there was no way to disable the progress bar.  Not having a progress bar on every page was something I got used to on my previous eReader, a [NookColor running CyanogenMod](http://forum.xda-developers.com/showpost.php?p=11452450&postcount=19).

From various articles I had read over the years, I had a vague notion that Kindles were Linux machines as well, and was therefore sure that there was a way to hack the progress bar away.  After some googling, I [found what I was looking for](http://www.mobileread.com/forums/showthread.php?t=142848).

It turned out that some geek had found a way to reduce the number of full page refreshes on the Kindle (like the [Nook did](http://techcrunch.com/2010/10/18/nook-gets-faster-page-turning-sync-across-devices-with-1-5-firmware-update-next-month/)).  Someone else [adapted that hack to hide the progress bar](http://www.mobileread.com/forums/showpost.php?p=1674783&postcount=35).  The algorithm they used, in a nutshell:
* Watch for page turns
* If the Kindle is currently displaying a book, right out empty spaces over the area where the progress bar is displayed.

This does mean that if you look closely as you're flipping pages, you'll see the progress bar get drawn then hidden away.  Also, if you turn pages too quickly, the magic doesn't work.  

Despite these shortcomings, I was happy: I could continue to use my Kindle without suffering the annoying progress bar.  I wrapped the script with [launchpad](http://www.mobileread.com/forums/showthread.php?t=97636) so I could easily turn it on and off as I needed to.

The installation was far from straightfoward so I figured I'd document it.  While I was at it, I packaged up the hack and made a couple of minor tweaks.  Enjoy!

## Credit

All I did was document what some other smart folks had done.  Credit goes to them:
* [fbdev for fbout](http://www.mobileread.com/forums/showthread.php?t=147488)
* [khmann for the original page refresh speedup hack](http://www.mobileread.com/forums/showpost.php?p=1658305&postcount=1)
* [mobad for the progress bar remover](http://www.mobileread.com/forums/showpost.php?p=1674783&postcount=35)
* [all the devs who jailbroke the kindle](http://www.mobileread.com/forums/showthread.php?t=88004)
* [h1uke for launchpad](http://www.mobileread.com/forums/showthread.php?t=97636)

## Usage

* Install
* While your Kindle is on:
  * To remove the progress bar press `shift` then `p` then `r`. (launchpad lead-progressbar-remove)
  * To enable the progress bar back press `shift` then `p` then `e`. (launchpad lead-progressbar-enable)

## Installation

These instructions are for a Kindle Keyboard w/ 3G.  If you are using a different variant, you'll need to copy the appropriate file in steps 1 and 2 as follows (http://yifan.lu/p/kindle-jailbreak/):
* k2 = Kindle 2 US
* k2i = Kindle 2 International
* dx = Kindle DX US
* dxi = Kindle DX International
* dxg = Kindle DX Graphite
* k3 = Kindle 3 Wifi + 3G (US & Canada)
* k3g = Kindle 3 Wifi + 3G (Elsewhere)
* k3w = Kindle 3 Wifi

1. [Jailbreak your Kindle](http://www.mobileread.com/forums/showthread.php?t=88004)
  * Download http://www.mobileread.com/forums/attachment.php?attachmentid=83332&d=1330740963
  * Connect your Kindle to your computer via USB
  * Open the zip file and copy update_jailbreak_0.10.N_k3g-3.2.1_install.bin to your Kindle
  * Disconnect the Kindle from your computer
  * On the Kindle, Go to Home, press Menu, Select Settings, Press Menu, Select Update Your Kindle
  
  If all went well, you'll see that the update was applied successfully and that there is a linkjail directory in the directory listing when you connect your Kindle to your computer.

2. [Install launchpad](http://www.mobileread.com/forums/showthread.php?t=97636)
  * Download http://www.mobileread.com/forums/attachment.php?attachmentid=65929&d=1296663715
  * Connect your Kindle to your computer via USB
  * Open up the zip file and copy the update_launchpad_0.0.1c_k3g_install.bin
  * Disconnect the Kindle from your computer
  * On the Kindle, Go to Home, press Menu, Select Settings, Press Menu, Select Update Your Kindle
  
  If all went well, you'll see that the update was applied successfully and that there is a launchpad directory in the directory listing  when you connect your Kindle to your computer.

3. Install the progress remover hack (http://www.mobileread.com/forums/showpost.php?p=1674783&postcount=35)
  * Download my packaged version of the progress remover from https://github.com/muness/kindle-progress-bar-remover/zipball/master
  * Connect your Kindle to your computer via USB
  * Open up the zip file and copy both launchpad and progRem folders to your Kindle
  * Disconnect the Kindle from your computer
  * While your kindle is on, press `shift` then then `shift` then `space`. (launchpad's command to re-read configuration)
