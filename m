From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: logging question
Date: Wed, 19 Oct 2005 08:21:34 +1000
Cc: Eric Moore <eemoore@fyndo.com>, SELinux@tycho.nsa.gov
References: <m33bn0az4a.fsf@eemoore.bcluster.njit.edu> <200510180752.34963.russell@coker.com.au> <1129636566.2375.3.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129636566.2375.3.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510190821.42959.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 18 October 2005 21:56, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> They may be concerned about the performance overhead of the audit
> infrastructure, but most of that is from CONFIG_AUDIT_SYSCALL=y, not
> just CONFIG_AUDIT=y, and SELinux only requires the latter to perform
> basic auditing of permission denials (the former can be useful in
> getting more information about the syscalls and is needed by auditd, but
> not strictly by SELinux).
>
> Other option is to make the #undef CONFIG_AUDIT case revert to using
> printks like the original SELinux code.

Of course doing that would either give very poor information on the action 
that caused the AVC message or require some kernel coding work to deliver a 
moderate amount of information (what we used to get before the audit code was 
used), and certainly nothing like the amount of information that we get now 
that SE Linux uses the audit framework.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
