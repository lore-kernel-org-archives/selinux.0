Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2HDoRRb026103
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 08:50:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2HDmf6Q006380
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 13:48:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i2HDmf5t006377
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 13:48:41 GMT
Subject: Re: newrole failed in enforcing mode
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Carsten Grohmann <carstengrohmann@gmx.de>,
   SELinux Mail List <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200403180020.57582.russell@coker.com.au>
References: <200403101650.07042.carstengrohmann@gmx.de>
	 <200403171227.52632.carstengrohmann@gmx.de>
	 <1079527308.10795.5.camel@moss-spartans.epoch.ncsc.mil>
	 <200403180020.57582.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1079531397.10795.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 17 Mar 2004 08:49:57 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-03-17 at 08:20, Russell Coker wrote:
> Of course that might not be the problem.  Even when things are working 
> perfectly with the correct PAM modules it will still try to 
> access /etc/shadow and run unix_chkpwd when direct access fails.
> 
> I have found a problem where I can't change role from sysadm_r to staff_r, I 
> still haven't got time to debug this.

I just tried that, and it failed for me as well.  After looking into it
briefly, it appears that the 'role sysadm_r types system_chkpwd_t;' rule
was dropped at some point, and that prevents correct operation of
newrole from sysadm_r.  If I add that back (e.g. to
domains/programs/chkpwd.te), then newrole -r staff_r works again for me
from root:sysadm_r:sysadm_t.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
