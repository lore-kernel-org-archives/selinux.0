From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Out of curiosity looking for suid apps without special context on FC3
Date: Fri, 1 Oct 2004 06:32:43 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <415C4E36.3020303@redhat.com>
In-Reply-To: <415C4E36.3020303@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410010632.43256.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Oct 2004 04:19, Daniel J Walsh <dwalsh@redhat.com> wrote:
> These are the files that do not have special context associated with
> them but are suid on FC3.
>
> /sbin/pwdb_chkpwd->system_u:object_r:sbin_t

I suspect that should have type chkpwd_exec_t, but would have to do some tests 
and code inspection.  I expect that it won't work without PAM code changes 
anyway.

> # Asks for suid but seems to work.
> /usr/bin/newgrp->system_u:object_r:bin_t

Only in targeted policy or as sysadm_t.  In strict policy as a regular user it 
fails.  I guess I have to create user_newgrp_t etc domains, and policy for 
gpasswd.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
