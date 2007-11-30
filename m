Date: Fri, 30 Nov 2007 08:50:51 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Menage <menage@google.com>
Cc: Mark Nelson <markn@au1.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Crispin Cowan <crispin@crispincowan.com>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] namespaces: introduce sys_hijack (v10)
Message-ID: <20071130145051.GF6250@sergelap.austin.ibm.com>
References: <474B78CB.5070607@au1.ibm.com> <474BC017.6060801@crispincowan.com> <20071127161132.GD32362@sergelap.austin.ibm.com> <1196186964.3925.129.camel@moss-spartans.epoch.ncsc.mil> <20071127223829.GA21753@sergelap.austin.ibm.com> <1196262054.13820.23.camel@moss-spartans.epoch.ncsc.mil> <20071128152359.GA4756@sergelap.austin.ibm.com> <474F70B3.5020006@au1.ibm.com> <6599ad830711291810m463833ack452c375b552c627e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6599ad830711291810m463833ack452c375b552c627e@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Paul Menage (menage@google.com):
> On Nov 29, 2007 6:08 PM, Mark Nelson <markn@au1.ibm.com> wrote:
> > Hi Paul and Eric,
> >
> > Do you guys have any objections to dropping the hijack_pid() and
> > hijack_cgroup() parts of sys_hijack, leaving just hijack_ns() (see
> > below for discussion)?
> >
> 
> hijack_ns() is the main bit that I care about anyway, so that's fine
> by me. Are we planning on adding the other modes again later?

Don't think we are planning on it, but of course if people want it it
can always be revisited.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
