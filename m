From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Matthew R. Singer" <msinger@itac.com>, <SELinux@tycho.nsa.gov>
Subject: Re: Unlabeled files
Date: Fri, 11 Apr 2003 17:03:05 +1000
References: <8A61167D13CED411B3E500B0D079784703AAF1@mailserver.itac.reston>
In-Reply-To: <8A61167D13CED411B3E500B0D079784703AAF1@mailserver.itac.reston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304111703.05285.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Apr 2003 05:32, Matthew R. Singer wrote:
> Apr  8 14:07:11 localhost kernel: avc:  denied  { transition } for
> pid=902 exe=/usr/bin/kdm path=/etc/X11/xdm/Xsession dev=08:02 ino=314289
> scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t
> tclass=process

kdm should not be running in sysadm_t.  It should be started by run_init or 
from init with the patch that Steve suggested for the policy (my next xdm 
policy file which I should have ready to share in a week will have this).

Regardless of this kdm should not get unlabeled_t as the target.  Probably 
there's a bug in the error handling code.  I'm re-writing the patch for kde 
3.1.1 anyway which will solve this.  I should have it released in a few days.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
