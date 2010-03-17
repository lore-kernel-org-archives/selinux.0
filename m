Subject: Re: working linux and busybox versions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manvendra Pratap Singh <manav.emb@gmail.com>
Cc: selinux@tycho.nsa.gov, Kaigai Kohei <kaigai@ak.jp.nec.com>
In-Reply-To: <1268834330.3899.6.camel@moss-pluto.epoch.ncsc.mil>
References: <482a0d8c1003100413w4b2d060fy493a72f6a76b976e@mail.gmail.com>
	 <1268235831.3678.31.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003100914j2709ab7epad0956ca4aa75081@mail.gmail.com>
	 <1268243344.3678.38.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003110208g9843309s83e41c6319ff8271@mail.gmail.com>
	 <482a0d8c1003162122y50c4f6adq3d1e4ab7a9d481ed@mail.gmail.com>
	 <1268834330.3899.6.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 17 Mar 2010 10:18:12 -0400
Message-Id: <1268835492.5354.1.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-03-17 at 09:58 -0400, Stephen Smalley wrote:
> On Wed, 2010-03-17 at 09:52 +0530, Manvendra Pratap Singh wrote:
> > Can anyone suggest me good guide for SELinux on omap3 (beagleboard). I
> > tried it myself but I am not able to login after booting. On loging in
> > root I get a msg "Cann't get SID for root". Please help me on this
> > issue.  Here take a look at boot-log.
> > 
> > 
> > [    0.000000] Security Framework initialized
> > [    0.000000] SELinux:  Initializing.
> > 
> > 
> > beagleboard login: root
> > login: can't get SID for root
> 
> I suspect you haven't loaded a policy into the kernel.  

...because I'd expect to see further SELinux: messages in your boot log,
e.g.:
SELinux:  Starting in permissive mode
SELinux:  Registering netfilter hooks
SELinux: 8192 avtab hash slots, 135229 rules.
SELinux: 8192 avtab hash slots, 135229 rules.
SELinux:  8 users, 12 roles, 2944 types, 130 bools, 1 sens, 1024 cats
SELinux:  74 classes, 135229 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext4), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
