Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PLXr0b005343
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 17:33:53 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PLXoe4022769
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 21:33:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <stephen.smalley@gmail.com>
Subject: Re: Policy loading:  initramfs vs. patched /sbin/init
Date: Sat, 26 Jul 2008 07:33:39 +1000
Cc: selinux@tycho.nsa.gov, Caleb Case <ccase@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>
References: <200807231017.30237.russell@coker.com.au> <200807251335.26628.russell@coker.com.au> <1216993113.11948.16.camel@sulphur>
In-Reply-To: <1216993113.11948.16.camel@sulphur>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807260733.43622.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 25 July 2008 23:38, Stephen Smalley <stephen.smalley@gmail.com> 
wrote:
> > > First, to clarify, while Ubuntu and Fedora are initiating the policy
> > > load from the initramfs, they are taking the policy from the real root
> > > filesystem.  Thus, the policy is not being stored on the initramfs
> > > image and updates to policy do not require rebuilding the image.
> >
> > I have been told that an Ubuntu initramfs generated for a non-SE system
> > will not have the scripts in question installed.  So there is a need to
> > regenerate the initramfs when converting to SE Linux.
>
> True, but that's a one-time regeneration vs. per-policy-update.

Any time you regenerate an initramfs there is a risk that it will result in a 
non-bootable system.

The way Debian currently works is that existing initramfs images are replaced 
when there is an upgrade to the tools related to generating them.  I believe 
that this is a mistake, an initramfs that has been used to successfully boot 
the system is good by definition and should not be touched.

The Ubuntu changes in this regard have merely extended the scope of this 
mistake.

> > > On the positive side, the initramfs-based approach does mean
> > > that /sbin/init from the real root automatically transitions into the
> > > right domain since policy is already loaded.
> >
> > Saving one exec system call.
>
> Requiring init to re-exec itself was always a hack; this is cleaner and
> closer to the original model where the kernel loaded policy before init
> ever ran.

For a long time (as long as I remember - more than 10 years) SysV Init has had 
the ability to re-exec itself (while preserving state) for an upgrade.  To 
re-exec while preserving state across an upgrade while in the middle of 
operation is not a trivial task.  To exec before actually doing anything when 
there is no real state to be saved is however trivial.

> > > So I'm not fundamentally opposed to having the support in /sbin/init as
> > > well if that's feasible, but you'll need it to detect whether policy
> > > has already been loaded and skip it if so or it will end up loading
> > > policy twice on systems that are using the initramfs-based approach.
> >
> > Caleb has suggested having the already patched SysV init for systems that
> > can't use initramfs.  That means such detection would be required in that
> > case.
>
> Yes.  Detecting it likely requires mounting /proc and then calling
> is_selinux_enabled(), since our current test for whether policy has been
> loaded is based on /proc/self/attr/current value ("kernel" or not).

So it seems that having the initramfs load policy for upstart gives you the 
union of all possible disadvantages.  You have to support SysV Init loading 
it (for non-initramfs systems), you need to have SysV Init deal with the case 
where an initramfs has already loaded the policy, and you need to maintain 
two vastly different methods of loading policy (initramfs and Init - which is 
more work than maintaining two patched Init systems).

Not to mention that the options of including chroot in initramfs or mounting 
all the filesystems there are both hacks and both have disadvantages.

If the Fedora people want to support only one Init system and only machines 
that use initramfs then it works OK (as they have demonstrated with Fedora 
9).  But if you want to support multiple Init systems (in Debian we always 
like to offer users a choice), support hardware which can't use initramfs 
(Debian supports a huge range of hardware - many people have machines more 
than 10 years old), and support people who just don't want to use initramfs 
(choice again) then it's not such a good option.

I'm not sure how much choice the Ubuntu people are planning to offer their 
users.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
