From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: s.m.a.c.k
Date: Sun, 17 Feb 2008 21:15:06 +1100
Cc: Justin Mattock <justinmattock@gmail.com>, selinux@tycho.nsa.gov
References: <dd18b0c30802131822v3a7dd93bkba75363d65c262df@mail.gmail.com> <1202992307.16038.69.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1202992307.16038.69.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802172115.08256.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 14 February 2008 23:31, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> SELinux imposes a performance overhead, but it shouldn't especially
> affect power consumption.  You might be thinking of bugs in certain
> SELinux-related daemons, like setroubleshootd in Fedora, that caused it
> to spin.

There are a couple of cases where SE Linux will increase power use.

One is the case of broken applications that go into an infinite loop when 
confronted with an unexpected EPERM.  If you have a power hungry CPU (P4 or 
P-D) then a single process doing that can cost a significant amount of power.

Another is the issue of auditing.  When SE Linux denies an operation and 
doesn't have a dontaudit rule the event will be logged.  This involves some 
CPU use by the kernel and syslogd or auditd and then some disk IO.  Obviously 
in those cases more power is used than otherwise.

Ideally neither of these situations would ever occur on your machines, and in 
practice they are quite uncommon.

The vast majority of SE Linux access control decisions (on a system without 
Security Enhanced X) will concern system calls.  On most systems the majority 
of power is taken by IO (moving disk heads takes energy) and application 
computation (Firefox on my system has accumulated 24 DAYS of CPU time).  
Neither application computation nor disk IO will be affected by SE Linux 
(except in the cases of looping programs and logging).

On my desktop machine nothing other than Firefox matters for electricity use.  
The servers I run at the moment are mostly idle so the electricity use would 
be pretty close to the minimum for an idle system.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
