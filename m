Date: Wed, 10 Oct 2001 08:26:09 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Security policy analysis
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIAEMOJPAA.mayerf@tresys.com>
Message-ID: <Pine.GSO.4.33.0110100814260.25153-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 9 Oct 2001, Frank Mayer wrote:

> We also find ourselves incrementally building tools to analyze policy.conf
> files (e.g., show all types with a given attribute, show all rules that
> involve a given type/attribute).  Essentially to help reverse engineer and
> analyze the intent of a given policy.  We have some capabilities built, and
> are writing additional ones as time and need allow (essentially by borrowing
> the lex/yacc source from checkpolicy, and building our own policy database
> and analysis logic).  Is anyone else building similar tools?  We'd be happy
> to share our source incrementally with members of the list as we build new
> capabilities if anyone is interested.

Some people at MITRE have been working on similar policy analysis tools.
Originally, they were creating these tools separately from checkpolicy
but drawing from the checkpolicy sources. However, I recommended that they
instead look into merging the support for new kinds of queries directly
into the existing checkpolicy debugging facility (the -d option) and
possibly replacing the checkpolicy debugging interface with an
interactive query interface.  I'm not sure how far along they are,
but you should certainly coordinate.

We're interested in the capabilities that you've developed.  Can we
acquire a copy?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
