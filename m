Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs,
	sshd,	and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Klaus Weidner <klaus@atsec.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, James Antill <jantill@redhat.com>,
        Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20070105040119.GB24315@w-m-p.com>
References: <20070105033311.GA24315@w-m-p.com>
	 <6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>
	 <20070105040119.GB24315@w-m-p.com>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 10:56:24 -0500
Message-Id: <1168012584.18961.161.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-04 at 22:01 -0600, Klaus Weidner wrote:
> On Thu, Jan 04, 2007 at 10:35:45PM -0500, Joshua Brindle wrote:
> > > From: Klaus Weidner [mailto:klaus@atsec.com] 
> > > Instead of hardcoded types, how about a configurable type or 
> > > a /etc/securettytypes file that contains the types instead of 
> > > tty names?
> > 
> > Sure, the securettycontexts might be the way to go. I'm dubious about
> > just making this happen for level changes though, you shouldn't be able
> > to bypass any part of the security policy using newrole.
> 
> The problem isn't actually in newrole, so this is a workaround to
> close an information leak in MLS environments without causing problems
> for everyone else who wouldn't care about this leak. Newrole has special
> privileges (specifically the "mlsprocsetsl" attribute) which make it a
> trusted program, and I think it's reasonable to have a trusted program
> enforce part of the security policy.
> 
> >From what I recall from the previous discussions, there is a lot of
> resistance to implementing SELinux hooks in the PTY layer which would be
> needed to enforce the restriction at the kernel level.

Not so much resistance as uncertainty as to what form such a check would
take and how effective it would be.

> A permission check at the PTY level would most likely require a fair
> amount of policy to avoid TE denials, and even getting just the MLS
> constraints to work would be tricky. For example, which of the processes
> involved at the ends of the PTY should gain MLS override privileges due
> to its type attributes if any?
> 
> -Klaus
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
