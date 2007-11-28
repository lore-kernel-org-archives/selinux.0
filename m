Date: Wed, 28 Nov 2007 08:54:22 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Crispin Cowan <crispin@crispincowan.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>,
        Mark Nelson <markn@au1.ibm.com>, containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        menage@google.com, James Morris <jmorris@namei.org>
Subject: Re: [PATCH 2/2] hijack: update task_alloc_security
Message-ID: <20071128145422.GC3820@sergelap.austin.ibm.com>
References: <474B78CB.5070607@au1.ibm.com> <474B7A51.3080300@au1.ibm.com> <474BB095.8080302@manicmethod.com> <1196174188.3925.32.camel@moss-spartans.epoch.ncsc.mil> <20071127154356.GA32362@sergelap.austin.ibm.com> <474D0188.2040600@crispincowan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <474D0188.2040600@crispincowan.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Crispin Cowan (crispin@crispincowan.com):
> Serge E. Hallyn wrote:
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> >   
> >> I agree with this part - we don't want people to have to choose between
> >> using containers and using selinux, so if hijack is going to be a
> >> requirement for effective use of containers, then we need to make them
> >> work together.
> >>     
> > Absolutely, we just need to decide how to properly make it work with
> > selinux.  Maybe we check for
> >
> > 	allow (current_domain):(hijacked_process_domain) hijack
> > 	type_transition hijacked_process_domain \
> > 		vserver_enter_binary_t:process vserver1_hijack_admin_t;
> >   
> Is there to be an LSM hook, so that modules can decide on an arbitrary
> decision of whether to allow a hijack? So that this "do the right
> SELinux" thing can be generalized for all LSMs to do the right thing.

Currently:

	1. the permission is granted through ptrace
	2. the lsm knows a hijack is going in security_task_alloc()
		when task != current

so the lsm has all the information it needs.  But I have no objection
to a separate security_task_hijack() hook if you find the ptrace hook
insufficient.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
