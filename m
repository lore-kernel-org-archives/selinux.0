From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, "Fleischman, Eric" <eric.w.fleischman@boeing.com>
Subject: Re: Security Officer and System Administrator Separation of Duties
Date: Fri, 3 Oct 2003 16:55:06 +1000
Cc: SELinux@tycho.nsa.gov
References: <5B58696DB20B9140AD20E0685C573A6402992E48@xch-nw-09.nw.nos.boeing.com> <20031003025553.C28424@lemuria.org>
In-Reply-To: <20031003025553.C28424@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310031655.06049.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 3 Oct 2003 10:55, Tom wrote:
> This should be possible, in theory. In a practical implementation,
> there are possibly a lot of holes that might be used to elevate
> priviledges.
>
> The most obvious example is, of course, that if the security officer
> can modify the policy, he can grant himself additional rights.

What we need are some utilities with domain_auto_trans() rules to modify the 
policy, they would restrict themselves to modifying the users file.

> What you certainly can do is create a sysadm_r that is limited in the
> respect you wish, i.e. can not add/edit users or modify the policy.

To so that we need to have the package management system check package 
signatures and only install files in types such as fsadm_exec_t if they are 
from signed packages from the distribution (not local packages).  Then we 
need to make sure that the administrator does not get write access to any 
such files (if they can replace fsck then they can get direct file system 
access and modify /etc/shadow etc).

Of course if the machine gets damaged in some way such that it can't boot then 
someone will have to fix it, and neither of the two described roles will have 
the necessary privs.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
