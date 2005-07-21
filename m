To: gyurdiev@redhat.com
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [ libsepol 6/6] Summary
References: <1121968509.9844.47.camel@celtics.boston.redhat.com>
	<42DFE71F.40602@tresys.com>
From: ramsdell@linus.mitre.org (John D. Ramsdell)
Date: 21 Jul 2005 16:28:18 -0400
In-Reply-To: <42DFE71F.40602@tresys.com>
Message-ID: <ogt8xzzq4yl.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle <jbrindle@tresys.com> writes:

> >- Hopefully internal data structures can
> >eventually be removed from headers, and
> >we can rely on external data structures.
> >
> >
> probably not, there isn't really a need to add a layer of abstraction
> between checkpolicy and libsepol as checkpolicy is very tied to the
> policydb structure.

Slat is tied to it too.  As with checkpolicy, it uses the static
version of the library, and follows lots of pointers.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
