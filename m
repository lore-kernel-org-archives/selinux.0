Subject: Re: TE for networked resources
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shahbaz khan <shazalive@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7b740b700708161147q1ce955d4ha64320547ac81663@mail.gmail.com>
References: <7b740b700708161147q1ce955d4ha64320547ac81663@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 15:06:28 -0400
Message-Id: <1187291188.909.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-16 at 23:47 +0500, shahbaz khan wrote:
> I was curious while reading Brindle et al paper on enhancing selinux
> policy for network domain that do we really need TE for these remote
> resources. Can't we just do with IBAC and RBAC? We can let the local
> subjects handle the TE with their own types with respect to the IBAC
> and RBAC of remote subject. This might be what they call equivalence
> mechanism. The problems associated with TE are too tough for selinux
> and current network controls to handle. The solutions will cost too
> much.

User identity and role doesn't convey enough information - you lose the
binding to the actual program/code.  Which matters.  You want to be able
to allow a given component to interact with another component
specifically, not any arbitrary process running with a given user
identity or role.

> Is there any progress on this work. Let me know because I have also
> working on this and might be able to assist.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
