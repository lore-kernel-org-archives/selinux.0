Date: Wed, 11 Jun 2003 09:30:16 +0200
From: Tom <tom@lemuria.org>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Policy transport, management, application installation, etc
Message-ID: <20030611093016.C12287@lemuria.org>
References: <see628a5.002@atlas.snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <see628a5.002@atlas.snu.edu>; from JBrindle@snu.edu on Tue, Jun 10, 2003 at 06:50:54PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 10, 2003 at 06:50:54PM -0500, Joshua Brindle wrote:
> Policy management:
>   How should the package manager deal with policies.

Not at all.

The policy is definitely NOT part of the user-space program, and it has
no business messing with it. The policy is set by the system (or
security) administrator, and may well be very different on different
systems for the same program.

Also, remember that SE tries to be transparent to most software.


>   This seems bad, playing with the users policy can't be a good thing,
>   but installing files with incorrect labels can't either. 
> 
>   Without doing this the user would be installing apps that either
> don't 
>   have the proper labels to enforce proper use, or apps that just 
>   plain don't work

I am convinced that there is no solution but a secondary infrastructure
for policy management. On all accounts, this does make sense. Think
seperation of function and control.

Setting up the policy is the responsibility of - well, whoever is
responsible for the security of the system in question. I would go so
far to say that the package manager should be considered an untrusted
piece of software. On a regular Unix, the package management tool can
essentially own you. On SE, we can prevent this, maintaining system
integrity provided we are willing to leave the core tools untouchable
by the package manager (or only touchable if run from a specific role).

(Yes, I still have that dream of a "core system" that is small and can
be shown to be secure, and an outer layer that doesn't necessarily have
to be trustworthy. A "ring 0" equivalent, if you want.)

Anyway, we can help the starting-out admins by providing examples and
default policies, though we definitely have to set up a better
management process for that, see my earlier mail.



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
