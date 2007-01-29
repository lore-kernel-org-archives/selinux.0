Subject: Re: [PATCH] sysctl selinux: Don't look at table->de
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
        Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <493253.19989.qm@web36606.mail.mud.yahoo.com>
References: <493253.19989.qm@web36606.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 15:07:33 -0500
Message-Id: <1170101253.3294.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-01-29 at 11:08 -0800, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > True, but a system that disables proc is likely a
> > system with a custom
> > policy anyway, and dependency on proc is fairly
> > basic to selinux these
> > days (due to reliance on /proc/self/attr for process
> > attribute
> > manipulation in place of the old selinux syscalls). 
> > Possibly we should
> > just make selinux depend on proc and drop the #ifdef
> > there.
> 
> Alternativly you could move the SELinux specific
> bits out of /proc/self/attr into an equivalent
> /selinux/self/attr and avoid that /proc dependency.

We could, but I don't see any compelling reason to do so.  We were
specifically told to use proc for the selinux process attributes when we
refactored the selinux api for 2.6 inclusion, as they are per-process
state and fit naturally into proc.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
