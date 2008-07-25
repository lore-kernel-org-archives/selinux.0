Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PDeS4x021122
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 09:40:28 -0400
Received: from py-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PDeRn9020863
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 13:40:27 GMT
Received: by py-out-1112.google.com with SMTP id a78so8900429pyh.32
        for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 06:40:27 -0700 (PDT)
Subject: Re: Policy loading:  initramfs vs. patched /sbin/init
From: Stephen Smalley <stephen.smalley@gmail.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov, Caleb Case <ccase@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <200807251335.26628.russell@coker.com.au>
References: <200807231017.30237.russell@coker.com.au>
	 <200807231242.51484.russell@coker.com.au>
	 <1216951692.5185.36.camel@sulphur>
	 <200807251335.26628.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 09:38:19 -0400
Message-Id: <1216993113.11948.16.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-07-25 at 13:35 +1000, Russell Coker wrote:
> http://etbe.coker.com.au/2008/07/24/se-linux-policy-loading/
> 
> Firstly above is the URL for the blog post in question, for the benefit of 
> people who don't normally read Planet SE Linux.
> 
> On Friday 25 July 2008 12:08, Stephen Smalley <stephen.smalley@gmail.com> 
> wrote:
> > I saw your blog entry about policy loading on planet selinux - you ought
> > to bring issues like that up on selinux list for discussion rather than
> > just blogging about them.
> 
> If I had realised what was going on before the release of Fedora 9 I would 
> have.  But it seems that the Red Hat people have made their decision, so the 
> decisions about what to do for Debian and Ubuntu have to be made separately.

I still think it merits upstream discussion so that we are all aware of
what decisions are being made and why.  Admittedly, that ought to have
been done in the Fedora case as well.

> > First, to clarify, while Ubuntu and Fedora are initiating the policy
> > load from the initramfs, they are taking the policy from the real root
> > filesystem.  Thus, the policy is not being stored on the initramfs image
> > and updates to policy do not require rebuilding the image.
> 
> I have been told that an Ubuntu initramfs generated for a non-SE system will 
> not have the scripts in question installed.  So there is a need to regenerate 
> the initramfs when converting to SE Linux.

True, but that's a one-time regeneration vs. per-policy-update.

> > On the positive side, the initramfs-based approach does mean
> > that /sbin/init from the real root automatically transitions into the
> > right domain since policy is already loaded.
> 
> Saving one exec system call.

Requiring init to re-exec itself was always a hack; this is cleaner and
closer to the original model where the kernel loaded policy before init
ever ran.

> > And policy gets loaded no 
> > matter what init is used or even if the user specifies an alternate
> > init= program on the kernel command line.
> 
> As I noted in my blog post there are not many init programs.  Only two are 
> commonly used, and one of them has the patch well supported for a long time.  
> Deciding to patch two vastly different initramfs systems instead of one init 
> system (which is very similar the other one) was never going to reduce pain.
> 
> > As you note, performing the load from initramfs can be problematic for
> > systems that cannot or choose not to use an initramfs,
> 
> Not problematic, a major show-stopper!

For such systems, yes.

> > So I'm not fundamentally opposed to having the support in /sbin/init as
> > well if that's feasible, but you'll need it to detect whether policy has
> > already been loaded and skip it if so or it will end up loading policy
> > twice on systems that are using the initramfs-based approach.
> 
> Caleb has suggested having the already patched SysV init for systems that 
> can't use initramfs.  That means such detection would be required in that 
> case.

Yes.  Detecting it likely requires mounting /proc and then calling
is_selinux_enabled(), since our current test for whether policy has been
loaded is based on /proc/self/attr/current value ("kernel" or not).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
