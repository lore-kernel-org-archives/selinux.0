Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7MGCVrT013611
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 12:12:31 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7MGCTV1008951
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 16:12:30 GMT
Date: Sun, 22 Aug 2004 17:23:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
Message-ID: <20040822162347.GC13842@lkcl.net>
References: <200408222125.38169.russell@coker.com.au> <20040822144016.GA13842@lkcl.net> <4128BBE6.6050207@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4128BBE6.6050207@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 22, 2004 at 11:29:42AM -0400, Joshua Brindle wrote:
> None of this restorecon voodoo nor mount context is necessary when udev 
> is implemented correctly.
 
  i would be delighted to have avoided the problems i encountered and
  the floundering solutions i attempted.


> When we were experimenting with udev it only took ramfs xattr support, 
> add ramfs to fs_use as an xattr filesystem and set up udev with selinux 
> support. When it runs it creates the nodes and then labels them via the 
> libselinux api which reads file_contexts. Aside from the problems I've 
> already mentioned there should be no problems running udev.
> 
> If the tmpfs context support is something different from this then it 
> should not be used (I have not looked at tmpfs support at all but have 
> personal experience that ramfs xattr works as expected).

 tmpfs is a little different because it is also shmfs and it is not
 possible to distinguish between the two in some way that i cannot at
 present recall: a potential solution was to add that patch to selinux
 hooks.c and over-ride the purpose of fscontext= in order to specify the
 correct context.


 i believe i am correct in saying that it is inappropriate to change the
 types for shmfs and/or tmpfs in fs_use:

	 fs_use_trans tmpfs system_u:object_r:tmpfs_t;
	 fs_use_trans shm system_u:object_r:tmpfs_t;

 the reason why it i believe it to be inappropriate is because
 the policy files make assumptions about the use of tmpfs and
 shm filesystems and these assumptions are that "it's tmpfs_t"
 as above.

 that is why i understand mount -o fscontext=somethingelse_t to have
 been invented, to make it possible to over-ride this "default"
 context.

 however, the ramfs is only in a SLIGHTLY different situation: namely
 that it has NOT been used for any purpose in SE/Linux, on account
 of noone having done the xattrs patch before now.

 therefore, the work that you did, joshua, namely to add
 ramfs to fs_use as an xattr filesystem, happened to be a suitable
 solution because nobody happened to have ever used ramfs in
 SE/Linux before now.

 IN THE FUTURE, however, that will change.

 therefore, it will also be necessary to be able to have both a default
 context (as listed in fs_use) and also to over-ride that default
 (by using a mount -o (???)context=somethingelse_t option).


 still with me so far? :)

 now.  okay.

 the way that fscontext= works is that it ONLY works on filesystems
 that are NOT xattr-enabled.

 [there is another option, context=, which does something else, it was
  inappropriate for use, can't remember why.]

 so, as i said, the whole reason why a _new_ ??context= option
 (or a patched fscontext= option) will be needed is because
 for xattr-enabled non-persistent filesystems you NEED to be
 able to over-ride the initial filecontext given to the root
 of the mounted filesystem.

 and the selinux/hooks.c patch that i attached simply removes the
 check "is this filesystem a non-xattr-enabled one, because if it's
 an xattr-enabled one then we don't want people to use fscontext="

 
 so, irrespective of whether shmfs, tmpfs or ramfs is used,
 i believe that it WILL be necessary to have this enhanced
 fscontext= capability or to have some new option ??context=

 
 also, i asked stephen smalley's advice about the use of
 mount -t tmpfs -o fscontext=system_u:object_r:device_t and he
 said yep, device_t is as good a choice as any.

 so, consequently, i started to go through the policy files
 adding in extra device_t-related stuff that broke during the
 boot-up sequence.

 e.g:

	 allow init_t device_t:file { ioctl read write }
 
 to allow /sbin/init to access /dev/null prior to when udev
 has been run!

	 allow device_t self:filesystem { associate };

 for udev to do something to /dev/null and /dev/snd (don't know
 what, don't care what)

 	allow udev_tbl_t device_t:filesystem { associate };

 because /dev/.udev.tdb is now on a shmfs and it's non-persistent.


 	allow mount_t tmpfs_t:filesystem { relabelfrom };

 i _really_ don't know what this one's for.

 
 	allow initrc_t device_t:dir { create setattr}

 this is for /etc/init.d/udev to create /dev/pts and for it to do a
 touch on /

 	allow initrc_t device_t:lnk_file { create }

 this is to allow /dev/fd to be created.

 the list continues with a few more entries.


 also i think i had to add something to types/file.te errr i forget what.

 y'know, it would make a _lot_ of sense i believe to have a
 separate domain for /etc/init.d/udev.



 if anyone knows of a better way to do - or to have done - this,
 i would REALLY like to know, because it will save me some
 maintenance headaches later.




 btw as you might have noticed, after i heard a few months back
 that someone thought that everything i say and do is gospel,
 i decided to qualify and quantify and prefix everything that i
 write with very unambigous and clear "this is what i tried, it
 worked mostly" words such as "i believe" and "it works for me".

 whilst this is as boring for me to have to do as it most likely
 is for you to have to repeatedly read, there isn't anything
 i can do about it: i am endeavouring to get a debian selinux
 system and running as quickly as possible, and am having to
 learn on-the-fly and avoid things like "it would be nice if".

 l.



 


> Joshua
> 
> Luke Kenneth Casson Leighton wrote:
> 
> >On Sun, Aug 22, 2004 at 09:25:38PM +1000, Russell Coker wrote:
> > 
> >
> >>It seems that udev is now virtually mandatory as of the latest rawhide 
> >>update.
> >>
> >>udev uses ramfs for /tmp, ramfs (as of the latest Fedora kernel 
> >>2.6.8-1.525) has no support for file labelling and breaks everything.
> >>
> >>Can we get ramfs labelling working in the next few days or do we have to 
> >>change things to not depend on udev?
> >>   
> >>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
