Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2HDMNRb025918
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 08:22:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2HDMM0F019331
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 13:22:22 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i2HDMLgZ019180 for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 13:22:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: newrole failed in enforcing mode
Date: Thu, 18 Mar 2004 00:20:57 +1100
Cc: Carsten Grohmann <carstengrohmann@gmx.de>,
   SELinux Mail List <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
References: <200403101650.07042.carstengrohmann@gmx.de> <200403171227.52632.carstengrohmann@gmx.de> <1079527308.10795.5.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1079527308.10795.5.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200403180020.57582.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Mar 2004 23:41, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Wed, 2004-03-17 at 06:27, Carsten Grohmann wrote:
> > On Dienstag, 16. März 2004 19:13, Stephen Smalley wrote:
> > > To debug the newrole failure in enforcing mode, do a 'make
> > > enableaudit reload' in policy and then try using newrole, and
> >
> > "make enableaudit" was a good hint. The newrole domain needs read
> > access to shadow_t. The attached patch grant this by using the auth
> > attribute.
>
> This should be handled by having pam_unix run the helper program when it
> cannot directly read /etc/shadow, and the helper program should run in a
> domain that can read /etc/shadow.  Do you have the same problem with the

Of course that might not be the problem.  Even when things are working 
perfectly with the correct PAM modules it will still try to 
access /etc/shadow and run unix_chkpwd when direct access fails.

I have found a problem where I can't change role from sysadm_r to staff_r, I 
still haven't got time to debug this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
