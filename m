Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l05478uD002078
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 23:07:08 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0547reK017463
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 04:07:54 GMT
Date: Thu, 4 Jan 2007 22:01:19 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: James Antill <jantill@redhat.com>, Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd,	and newrole
Message-ID: <20070105040119.GB24315@w-m-p.com>
References: <20070105033311.GA24315@w-m-p.com> <6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jan 04, 2007 at 10:35:45PM -0500, Joshua Brindle wrote:
> > From: Klaus Weidner [mailto:klaus@atsec.com] 
> > Instead of hardcoded types, how about a configurable type or 
> > a /etc/securettytypes file that contains the types instead of 
> > tty names?
> 
> Sure, the securettycontexts might be the way to go. I'm dubious about
> just making this happen for level changes though, you shouldn't be able
> to bypass any part of the security policy using newrole.

The problem isn't actually in newrole, so this is a workaround to
close an information leak in MLS environments without causing problems
for everyone else who wouldn't care about this leak. Newrole has special
privileges (specifically the "mlsprocsetsl" attribute) which make it a
trusted program, and I think it's reasonable to have a trusted program
enforce part of the security policy.

>From what I recall from the previous discussions, there is a lot of
resistance to implementing SELinux hooks in the PTY layer which would be
needed to enforce the restriction at the kernel level.

A permission check at the PTY level would most likely require a fair
amount of policy to avoid TE denials, and even getting just the MLS
constraints to work would be tricky. For example, which of the processes
involved at the ends of the PTY should gain MLS override privileges due
to its type attributes if any?

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
