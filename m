Message-ID: <00e601c125a7$70f0f410$020144c0@windows>
From: "Eric Peters" <eric@peters.org>
To: "Stephen Smalley" <sds@tislabs.com>
Cc: <SELinux@tycho.nsa.gov>
References: <Pine.SOL.3.95.1010815080617.24997B-100000@clipper.gw.tislabs.com>
Subject: Re: SE Linux II?
Date: Wed, 15 Aug 2001 09:29:19 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> You could certainly modify or replace the example SELinux security server
> to implement such a policy model.  That is relatively straightforward, and
> does not require any changes to the rest of the kernel to support new
> policy models.  The policy models that we chose to provide in the example
> security server are Type Enforcement and Role-Based Access Control (and,
> optionally, Multi-Level Security).  These policy models group users and
> processes into equivalence classes known as roles and domains, and define
> permissions based on these equivalence classes.  That tends to be much
> easier to manage than a policy based on individual users, although you can
> certainly define a unique role/domain for a particular user if you want.

I've been reading the PDFs for the better part of the morning (they are
definately covering the type of 'ignorant' questions I've been having)  I am
however still in a state of question about the representation of a 'domain'.
My understanding of a class is just aggregated types (read write/etc) which
could fall under the class 'file', yet what is the definition of a domain?

"Domains are treated just as any other type.  Domains are simply types
assigned to processes.  Because of this, types used as domains can also be
used as a type of related object, e.g. the type of its procfs entries.  The
term domain is often still used for convenience even thoug the security
server does not internally distinguish them from types."

As close as I am to starting to understand how the SS is setup I'm still
hung up over the use of 'domain' and what I should be thinking
about/referencing when reading the rest of the PDF and it comes up.  Is a
domain just an aggregation of classes?  The other destinction I suppose I
need to start making is the 'process' spaces, in many ways I've been
thinking of this as a very file oriented approach, yet with the transitions
between roles I guess I could see where there can be a process that would
have a unique set of types available.

Thanks, I really do appreciate your time, I'm currently not a member of
Usenix, however the student rate definately seems reasonable,

Eric


>
> With regard to the hierarchical relationship among users that you
> describe, the example policy models don't really provide implicit support
> for it, although you can explicitly represent such relationships through
> the assignment of permissions.  A more complete Role-Based Access Control
> implementation would directly support such relationships.
>
> For more information, I would recommend reading our papers published in
> the Proceedings of the Freenix track of the 2001 Usenix Annual Technical
> Conference and in the Proceedings of the 2001 Ottawa Linux Symposium.
> Hopefully, they will also be up on the web site soon.  Until then,
> you can find the Usenix paper at the Usenix web site
> (www.usenix.org/publications/library/proceedings/usenix01) if
> you are a member and the Ottawa paper at the LWN web site
> (lwn.net/2001/features/OLS/pdf).
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
