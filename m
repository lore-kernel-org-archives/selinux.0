From: "John Scroggins" <dataefx@earthlink.net>
To: <mayerf@tresys.com>, <SELinux@tycho.nsa.gov>
Subject: RE: Security policy analysis
Date: Tue, 9 Oct 2001 16:32:38 -0700
Message-ID: <LOBBKHHMGNHFHNPEJJLBGEHECAAA.dataefx@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIAEMOJPAA.mayerf@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We're looking at SE Linux as a building block upon which we can build
protected applications of various types.  One of the issues we are working
through include identifying a core "baseline" Linux configuration and
associated SE Linux policy for that baseline.  One means of doing this is to
examine sample policies (like the one distributed with the source).  If
anyone else is doing similar things, we'd like to like to hear more.  Also,
is anyone else working on alternative sample policies, especially for a core
Linux configuration?

I am not sure if anyone is doing so at the present time, but the direction
you are heading is interesting..  As it would help to broaden the use of the
kernel in general by supplying those "sample policies". I think one of the
hindrances in a large deployment scenario is understanding the policy
structure(s) and how they apply to processes (that require protection). A
more extensive set of elements which would help guide the potential
user,(admin or engineer) in defining environment specific variables, may be
a welcome addition.

We also find ourselves incrementally building tools to analyze policy.conf
files (e.g., show all types with a given attribute, show all rules that
involve a given type/attribute).  Essentially to help reverse engineer and
analyze the intent of a given policy.  We have some capabilities built, and
are writing additional ones as time and need allow (essentially by borrowing
the lex/yacc source from checkpolicy, and building our own policy database
and analysis logic).

I see this as potentially valuable. I too, would also like to see an
extended discussion regarding this resource.

Is anyone else building similar tools?  We'd be happy
to share our source incrementally with members of the list as we build new
capabilities if anyone is interested.

Integrating this into a kernel-building utility sounds interesting. :)

PS- Please reply to the mail list; we'd like to start open discussions of
policy analysis and development.

Regards,
Frank Mayer
mayerf@tresys.com
Tresys Technology



--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
