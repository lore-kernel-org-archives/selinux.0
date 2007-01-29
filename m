From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] sysctl selinux: Don't look at table->de
Date: Tue, 30 Jan 2007 10:28:51 +1100
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
        Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org
References: <200701280106.l0S16CG3019873@shell0.pdx.osdl.net> <m18xflloes.fsf@ebiederm.dsl.xmission.com> <1170096231.8720.102.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1170096231.8720.102.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200701301028.56693.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 30 January 2007 05:43, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> True, but a system that disables proc is likely a system with a custom
> policy anyway,

In practice we have to extensively customise policy long before getting to the 
non-proc stage of optimising for small hardware.  The Familiar distribution 
(used on the iPaQ) has /proc but needs significant policy changes when 
compared to a typical Fedora workstation.  Not only is there the issue that 
embedded distributions have different daemons and path names to workstations, 
but the memory constraints mean that even a modular targeted policy is not as 
small as you desire.

> and dependency on proc is fairly basic to selinux these 
> days (due to reliance on /proc/self/attr for process attribute
> manipulation in place of the old selinux syscalls).  Possibly we should
> just make selinux depend on proc and drop the #ifdef there.

I think that is the correct thing to do.  Someone who is prepared to do all 
the work needed to get a recent SE Linux system operating without /proc will 
have no problem changing the kernel config scripts and everyone else would be 
better off not being confused by being offered sets of options that are not 
viable.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
