From: "Frank Mayer" <mayerf@tresys.com>
To: <SELinux@tycho.nsa.gov>
Subject: New release of setools
Date: Mon, 22 Sep 2003 17:08:52 -0400
Message-ID: <000b01c3814d$bac82690$8100a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We've just posted a new release of setools (officially 1.0) on
www.tresys.com/selinux.  We will separately send Steve a patch to get this
release back into the main selinux distribution.  As always, you can see change
logs, screen shots, and summaries of the tools in the package on our site.  In
addition to a source tar file, we also now have a RPM package posted.

The most significant enhancements are in apol (the analysis tool), where we
spent a lot of time implementing a pair of partial information flow analysis
capabilities, and extending the domain transition analysis.  We also included
some new help files describing these analyses.  This help remains brief; we're
working on some more scholarly papers about policy analysis.  There were also a
lot of bug fixes, and changes to add compatibility with new policy changes.  See
the change log for a summary of major changes.  Feel free to provide comments
and bug reports; we're already thinking about other tools that are on our list
to do.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
