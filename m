From: ebiederm@xmission.com (Eric W. Biederman)
To: Mark Nelson <markn@au1.ibm.com>
Cc: menage@google.com, "Serge E. Hallyn" <serue@us.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Crispin Cowan <crispin@crispincowan.com>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] namespaces: introduce sys_hijack (v10)
References: <474B78CB.5070607@au1.ibm.com> <474BC017.6060801@crispincowan.com>
	<20071127161132.GD32362@sergelap.austin.ibm.com>
	<1196186964.3925.129.camel@moss-spartans.epoch.ncsc.mil>
	<20071127223829.GA21753@sergelap.austin.ibm.com>
	<1196262054.13820.23.camel@moss-spartans.epoch.ncsc.mil>
	<20071128152359.GA4756@sergelap.austin.ibm.com>
	<474F70B3.5020006@au1.ibm.com>
Date: Thu, 29 Nov 2007 19:37:07 -0700
In-Reply-To: <474F70B3.5020006@au1.ibm.com> (Mark Nelson's message of "Fri, 30
	Nov 2007 13:08:51 +1100")
Message-ID: <m1wss0a27g.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mark Nelson <markn@au1.ibm.com> writes:

> Hi Paul and Eric,
>
> Do you guys have any objections to dropping the hijack_pid() and
> hijack_cgroup() parts of sys_hijack, leaving just hijack_ns() (see
> below for discussion)?

I need to step back and study what is being proposed.

My gut feeling is that you are proposing something that does not
support forking me a process inside a container so I can have a
shell without having to run a login program.

There is a reason I proposed ptrace as an initial prototype.

All of the other uses of enter in a namespace context I feel confident
we can support by just having proper virtual filesystems available
to processes outside of the container.  For monitoring and control.

Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
