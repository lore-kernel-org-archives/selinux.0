From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: logging question
Date: Tue, 18 Oct 2005 07:52:25 +1000
Cc: Eric Moore <eemoore@fyndo.com>, SELinux@tycho.nsa.gov
References: <m33bn0az4a.fsf@eemoore.bcluster.njit.edu> <1129567150.26309.154.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129567150.26309.154.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510180752.34963.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 18 October 2005 02:39, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > (In or out of enforcing mode).  What's the best way for me to get
> > the kernel to log the appropriate messages somewhere?
>
> In 2.6, SELinux was converted over to using the native kernel audit
> subsystem for logging its denials.  So:
> - Does your kernel have auditing enabled (CONFIG_AUDIT=y)?  If not, time
> to rebuild your kernel.

The Debian kernel binary packages are built with SE Linux enabled but auditing 
disabled.  I have sent several messages to the relevant people about this 
matter and had no positive response.  Several 2.6.x kernels have been 
released in this state.

> - Are you running auditd?  If so, look in /var/log/audit/audit.log or
> wherever /etc/auditd.conf directs audit messages.  If not, look
> in /var/log/messages or wherever /etc/syslog.conf directs kern.warn
> messages.

auditd is not yet packaged for Debian.  The first person to volunteer gave up 
because it was too difficult.  I gave it a go but found that the kernel 
headers packaged with Debian did not support the interfaces needed by auditd 
(this was my impression at the time and I'm going from memory - this 
statement may not be entirely correct).  When I get back from AUUG2005 I'll 
give it another go.

Incidentally being able to build from the standard headers is a requirement 
for Debian.  All Debian packages get automatically built for architectures 
other than the one used for the initial build, so the headers in question 
need to be installed in all build machines.  I could hack the compile process 
for i386 but not for all the rest (I tried it before in the old-selinux days 
and it wasn't fun).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
