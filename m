Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VJ6xrT015046
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 15:06:59 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VJ69Gh019624
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 19:06:10 GMT
Date: Tue, 31 Aug 2004 20:18:10 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040831191809.GC4375@lkcl.net>
References: <20040830173744.GD10151@lbsd.net> <20040831160750.GM11456@lkcl.net> <20040831164635.GK10151@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040831164635.GK10151@lbsd.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 31, 2004 at 06:46:35PM +0200, Nigel Kukard wrote:

> >  assuming yes, then it kinda-solves the need for doing that hacked-up
> >  relaxed-constraints-patch-to-hooks.c fscontext= option.
> > 
> 
> aha, u correct!!!!
> 
> >  why? because you can mount -t tmpfs /dev blah blah and you don't 
> >  care what the context is because udev will set the correct one
> >  when it runs.
> > 
> > 
> 
> perfect!!!!, so that solves the need for the hooks patch, which is in
> actual fact wrong.
 
 oh, is it?  uhm, why?

> >  that is - of course - assuming that file_contexts/file_contexts
> >  _contains_ the correct file context for /dev.
> > 
> > 
> 
> *nod*
> 
> >  it might make (i dunno) for a simpler policy.
> > 
> 
> yep
 
  i _say_ might ... but then you mention that you've done exactly
  the same policy mods that i had to...

> >  what i mean is, have you had to add in the modifications to the
> >  selinux policy that i sent to the lists last week?
> > 
> >  e.g. these:
> > 
> > 	 allow udev_tbl_t device_t:filesystem { associate };
> > 	 allow initctl_t device_t:filesystem { associate };
> > 
> >  and these:
> > 
> > 	 +# needed for udev-mounted (/dev) tmpfs
> > 	 +allow $1_tty_device_t device_t:filesystem { associate };
> > 	 +
> > 	 +# to allow users to run df on udev-mounted (/dev) tmpfs
> > 	 +allow $1_t device_t:filesystem { getattr };
> > 	 +   #EXE=/bin/df  NAME=/   :  getattr
> > 	 +
> > 
> 
> had to add quite a couple more, but i'm still working on that to make it
> "correct"
 
 i think we need the input of more experienced people than us to
 say why these associate things are needed.

> >  these are all there for reasons i cannot entirely fathom but
> >  it starts, in types/file.te, with this:
> > 
> >  	allow { device_type } device_t:filesystem associate;
> > 
> 
> i need this aswell.... which is very interesting, so my "way of doing
> it" doesn't solve this problem. i'll keep looking for the solution
> 
> >  which is all because of this:
> >  
> >  	mount tmpfs -o fscontext=system_u:object_r:device_t /dev
> > 
> 
> this doesn't cause the problem, its something else
> 
> >  
> >  anyway what i am saying is that if you HAVE NOT got all these patches
> >  in your selinux policy files, then your approach has distinct
> >  advantages: less mods to the policy files and less differences between
> >  a persistent and non-persistent udev filesystem.
> > 
> 
> correct, i'm still working on it though and it HAS TO BE COMPLETED
> SOON!!!!

 ah, the joys of the "ItWorksForMe(tm)" approach...

> > 
> >  other than that, my intuition is saying "i don't like it" and what that
> >  means is that in about two or three weeks i will be able to articulate
> >  clearly and precisely why i don't think it's a good idea.
> >
> 
> *shrug*, just a different outlook, patching userspace instead of kernel
> space
>

> >  it'll likely be something to do with your solution being a two-step
> >  operation whereas the hacked-up-relaxed-fscontext-hooks.c things is
> >  a one-step (atomic?)  operation.
> > 
> 
> kernel developers will very much not like to get patches unless for a
> very good reason... 

 a correct implementation of the
 hacked-together-relaxed-fscontext-hooks.c-patch results in an atomic
 operation (mount with a new context which would otherwise need to be
 achieved with two commands: mount followed by restorecon)
 
 in my books, that's a good reason!

> *shrug*... guess i have the totally oposite outlook
> than you, i've had quite a number of my patches go mainstream though
 
 dude, the entire selinux thing is disliked by stacks of debian
 maintainers because of the knock-on implications it has.

 imagine what chaos would ensue if up until now, linux only had
 a FAT filesystem and someone said "hey, there's this _great_ concept
 it's called file ownership and file permissions, i've invented
 something called an ext2 filesystem".

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
