Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8FJc2rT020130
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 15:38:02 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8FJb5HF008504
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 19:37:06 GMT
Date: Wed, 15 Sep 2004 20:49:04 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@redhat.com>
Cc: James Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, rcoker@redhat.com
Subject: Re: [patch] don't relabel sub-subdirectories of /mnt, /media by default
Message-ID: <20040915194904.GA8296@lkcl.net>
References: <1094828936.7061.20.camel@nexus.verbum.private> <1095106896.2161.21.camel@moss-lions.epoch.ncsc.mil> <20040913232841.GB30524@lkcl.net> <1095272723.4231.38.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1095272723.4231.38.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 15, 2004 at 02:25:23PM -0400, Colin Walters wrote:
> On Tue, 2004-09-14 at 00:28 +0100, Luke Kenneth Casson Leighton wrote:
> However, this doesn't give an easy solution for someone who does want to
> use the contexts on removable media, because then you get into the very
> thorny issue of identifying removable media.  One idea John suggested
> during the discussion was for the removable media to have an identifying
> cryptographic key on it, 

 unless you actually digitally sign the content of the drive in some
 way, or tie it somehow to the actual hardware, a cryptographic key
 is of absolutely no use to you: it can be copied.

 if the drive and its contents are copied, verbatim (including selinux
 attributes): fine, great.
 
 [you're not trying to stop people _copying_ the data, you're trying
  to stop them _modifying_ it.]

 
 your simple options are:
 
 * for those that don't care, use as you suggest removable_content_t:
   you don't care what's on it, users just have access to it.

   [for now i am using mount -ocontext={theuser}:object_r:user_home_t
    but of course that means that i must add allow rules to vfat,
    msdos and all other potential types of mountable/removable
    filesystems - it's a bit yuk. ]

 * for the ultra-paranoid, place an encrypted (or even just
   digitally signed - if that's possible) filesystem on the
   removable media.

   this could be done "on top of" the filesystem which is
   mounted as removable_content_t.

 the more complex option is:

 - digitally sign the contents of the entire drive - every file,
   every directory, every extented attribute - everything.

 - keep a copy of that digital signature securely on the host.
   what you MUST NOT allow is people to arbitrarily modify that
   signature.

 - if you put the media in another machine, and modify it, then
   put the media back into the original machine, you will need
   to "update" the digital signatures in some secure fashion.



 
> Luke: I'm not sure how this would fit in your usbmount+autofs setup.

 fairly easy.

 it's a pretty straightforward shell script run from autofs
 (like the knoppix live cd does) to cover /media, and a hacked-up
 entry in /etc/hotplug/usb.agent to run a script (usbmount) that
 creates an icon on the desktop which links to /media/sda1 (or
 whatever hotplug says the new device is).

> But if you figure out which component is mounting the device, you can
> modify that in the same way we'll modify HAL.  Then you could simply
> modify your policy to allow users access to removable_content_t.
 
  ack!

  and at some point i will investigate HAL and use it
  [if it's entirely gnome-free and gnome-session-free as well].

  ta colin,

  l.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
