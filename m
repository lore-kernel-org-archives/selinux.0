Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: <SELinux@tycho.nsa.gov>
Subject: Security policy analysis
Date: Tue, 9 Oct 2001 15:49:31 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIAEMOJPAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

We also find ourselves incrementally building tools to analyze policy.conf
files (e.g., show all types with a given attribute, show all rules that
involve a given type/attribute).  Essentially to help reverse engineer and
analyze the intent of a given policy.  We have some capabilities built, and
are writing additional ones as time and need allow (essentially by borrowing
the lex/yacc source from checkpolicy, and building our own policy database
and analysis logic).  Is anyone else building similar tools?  We'd be happy
to share our source incrementally with members of the list as we build new
capabilities if anyone is interested.

PS- Please reply to the mail list; we'd like to start open discussions of
policy analysis and development.

Regards,
Frank Mayer
mayerf@tresys.com
Tresys Technology



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
