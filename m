Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VFuerT013407
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 11:56:41 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VFud5m000101
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 15:56:40 GMT
Date: Tue, 31 Aug 2004 17:07:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040831160750.GM11456@lkcl.net>
References: <20040830173744.GD10151@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040830173744.GD10151@lbsd.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 30, 2004 at 07:37:44PM +0200, Nigel Kukard wrote:
> Just an idea, but why not have udev set the context on its root path?
> 
> I have a simplistic patch for this if its a good idea.

 ah ha.  very funny.

 now i have re-read what you've said, now that i have enough
 background based on your further explanations in this thread,
 _now_ i have enough context to understand your question.

 okay.

 let me reiterate what i believe you have said.

 you have patched the program udev (0.030-10?)

 [and yes, i would highly recommend sending it to the list(s)
 to make it clear what you mean].

 this patch will run, when it starts up, a call to setfilecon()
 on /dev (or /udev, or whatever the mount point of the devfs is).

 and _just_ on "/dev".

 yes?

 and it's done BEFORE any inodes are EVER created in the new
 /dev, yes?


 assuming yes, then it kinda-solves the need for doing that hacked-up
 relaxed-constraints-patch-to-hooks.c fscontext= option.

 why? because you can mount -t tmpfs /dev blah blah and you don't 
 care what the context is because udev will set the correct one
 when it runs.


 that is - of course - assuming that file_contexts/file_contexts
 _contains_ the correct file context for /dev.


 it might make (i dunno) for a simpler policy.

 what i mean is, have you had to add in the modifications to the
 selinux policy that i sent to the lists last week?

 e.g. these:

	 allow udev_tbl_t device_t:filesystem { associate };
	 allow initctl_t device_t:filesystem { associate };

 and these:

	 +# needed for udev-mounted (/dev) tmpfs
	 +allow $1_tty_device_t device_t:filesystem { associate };
	 +
	 +# to allow users to run df on udev-mounted (/dev) tmpfs
	 +allow $1_t device_t:filesystem { getattr };
	 +   #EXE=/bin/df  NAME=/   :  getattr
	 +

 these are all there for reasons i cannot entirely fathom but
 it starts, in types/file.te, with this:

 	allow { device_type } device_t:filesystem associate;

 which is all because of this:
 
 	mount tmpfs -o fscontext=system_u:object_r:device_t /dev

 
 anyway what i am saying is that if you HAVE NOT got all these patches
 in your selinux policy files, then your approach has distinct
 advantages: less mods to the policy files and less differences between
 a persistent and non-persistent udev filesystem.


 other than that, my intuition is saying "i don't like it" and what that
 means is that in about two or three weeks i will be able to articulate
 clearly and precisely why i don't think it's a good idea.

 it'll likely be something to do with your solution being a two-step
 operation whereas the hacked-up-relaxed-fscontext-hooks.c things is
 a one-step (atomic?)  operation.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
