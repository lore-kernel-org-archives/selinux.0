Date: Thu, 24 Jul 2008 19:00:01 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: James Morris <jmorris@namei.org>
cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming, part
 3
In-Reply-To: <Xine.LNX.4.64.0807242320060.8246@us.intercode.com.au>
Message-ID: <Pine.LNX.4.64L.0807241800060.14689@ruuvi.it.helsinki.fi>
References: <Pine.LNX.4.64L.0807210220280.8567@ruuvi.it.helsinki.fi>
 <Xine.LNX.4.64.0807242320060.8246@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

On Thu, 24 Jul 2008, James Morris wrote:

> I'm not applying these variable renaming patches, as they peturb the code
> for no established benefit.

That's all right.

> I suggest reading the following carefully on how to submit patches:
> http://www.zipworld.com.au/~akpm/linux/patches/stuff/tpp.txt

Thanks a lot. I try to be more careful. I suppose I have to resend one
patch, as I forgot to CC the kernel list, and the patch was not really
conforming to the rules specified above, either.

> It's also generally best to simply use git to create patches (e.g. via
> git-format-patch).

OK, I have to learn how to use git.

> Something that would be particularly useful at this stage would be to see
> if you can reproduce a long delay in booting the current git tree possibly
> related to SELinux policy loading:
>
> [    6.904650] EXT3-fs: mounted filesystem with ordered data mode.
> [    7.076411] type=1404 audit(1216904882.076:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
> [   59.445985] SELinux: 8192 avtab hash slots, 1815416 rules.
> [   60.812559] SELinux: 8192 avtab hash slots, 1979772 rules.

It boots quite quickly on my Fedora 9, but the boot log shows
significantly less rules than yours. If you really have that much rules, I
guess your hash chains will have to be much longer too...

The 171021 vs 1979772 is strange, ratio being approx. 1:11.

Here is what I have:

EXT3-fs: mounted filesystem with ordered data mode.
type=1404 audit(1216911601.748:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
SELinux: 8192 avtab hash slots, 171021 rules.
SELinux: 8192 avtab hash slots, 171021 rules.


RPM on my F9:

Name        : selinux-policy               Relocations: (not relocatable)
Version     : 3.3.1                             Vendor: Fedora Project
Release     : 78.fc9                        Build Date: Mon Jul 14 23:44:19 2008
Install Date: Mon Jul 21 19:19:09 2008         Build Host: xenbuilder4.fedora.phx.redhat.com
Group       : System Environment/Base       Source RPM: selinux-policy-3.3.1-78.fc9.src.rpm
Size        : 8515318                          License: GPLv2+
Signature   : DSA/SHA1, Thu Jul 17 23:47:20 2008, Key ID b44269d04f2a6fd2
Packager    : Fedora Project
URL         : http://serefpolicy.sourceforge.net
Summary     : SELinux policy configuration
Description :
SELinux Reference Policy - modular.
Based off of reference policy: Checked out revision 2624.

> And if so, track down what's causing it.

After the long boot delay, do the SELinux checks work as expected? Any
other weirdness in the boot or audit logs?

Best regards,
vmk
-- 
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
