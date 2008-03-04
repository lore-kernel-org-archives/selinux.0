Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24Jhtkm032199
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 14:43:56 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m24Jho2k004016
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 19:43:50 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [DSE-Dev] refpolicy: patch for ldconfig from glibc2.7,	new	patch
Date: Tue, 4 Mar 2008 14:39:44 -0500
Message-ID: <1204659584.14217.21.camel@gorn>
In-Reply-To: <47C96E41.7020602@martinorr.name>
References: <20080222152703.GA4163@bobek.pm.i.cz> <1203703539.32061.22.camel@gorn> <20080229072116.GA13364@bobek.pm.i.cz> <1204292761.32061.230.camel@gorn>  <47C824BE.5040001@martinorr.name> <1204302749.32061.241.camel@gorn>  <47C96E41.7020602@martinorr.name>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Martin Orr" <martin@martinorr.name>
Cc: <selinux@tycho.nsa.gov>, <selinux-devel@lists.alioth.debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-03-01 at 14:54 +0000, Martin Orr wrote:
> On 29/02/08 16:32, Christopher J. PeBenito wrote:
> > On Fri, 2008-02-29 at 15:29 +0000, Martin Orr wrote:
> >> The attached patch is what I am using to deal with this.  (I'm not sure if
> >> it should be apt_dontaudit_use_fds(ldconfig_t) or apt_use_fds(ldconfig_t)
> >> but dontaudit is what the Debian policy package uses.)
> > 
> > You probably want to allow it otherwise ldconfig won't inherit the fds
> > that point to the apt pty.  By denying the inheritance on an enforcing
> > system, fd 0,1,2 will be closed and reopened to /dev/null, so you lose
> > any ldconfig output.
> 
> Here's an updated patch, with apt_use_fds(ldconfig_t).  This also lets
> dpkg_t and dpkg_script_t use initrc ptys, so that se_dpkg works.

Merged.

> @@ -1,5 +1,5 @@
>  
> -policy_module(apt,1.3.0)
> +policy_module(apt,1.3.1)
>  

In the future please don't submit patches with module version changes.
It may change between the time you make the patch, and the time I apply
it, which may cause patches not to apply.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
