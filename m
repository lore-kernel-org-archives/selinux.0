Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2HFWURb026924
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 10:32:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2HFUh6Q015022
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 15:30:43 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i2HFUf5t014898
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 15:30:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: newrole failed in enforcing mode
Date: Thu, 18 Mar 2004 02:31:02 +1100
Cc: Carsten Grohmann <carstengrohmann@gmx.de>,
   SELinux Mail List <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
References: <200403101650.07042.carstengrohmann@gmx.de> <200403180020.57582.russell@coker.com.au> <1079531397.10795.69.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1079531397.10795.69.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403180231.02562.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Mar 2004 00:49, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Wed, 2004-03-17 at 08:20, Russell Coker wrote:
> > Of course that might not be the problem.  Even when things are working
> > perfectly with the correct PAM modules it will still try to
> > access /etc/shadow and run unix_chkpwd when direct access fails.
> >
> > I have found a problem where I can't change role from sysadm_r to
> > staff_r, I still haven't got time to debug this.
>
> I just tried that, and it failed for me as well.  After looking into it
> briefly, it appears that the 'role sysadm_r types system_chkpwd_t;' rule
> was dropped at some point, and that prevents correct operation of
> newrole from sysadm_r.  If I add that back (e.g. to
> domains/programs/chkpwd.te), then newrole -r staff_r works again for me
> from root:sysadm_r:sysadm_t.

role sysadm_r types system_chkpwd_t;
in_user_role(system_chkpwd_t)

I've put the above in newrole.te in my tree to solve this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
