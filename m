To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
Subject: GNU Coding Standards (was: Setools 1.0.1 released)
References: <1067890582.1269.32.camel@colossus.columbia.tresys.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 14 Nov 2003 10:04:13 -0500
In-Reply-To: <1067890582.1269.32.camel@colossus.columbia.tresys.com>
Message-ID: <ogtn0az2dqq.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan <kmacmillan@tresys.com> writes:

> We have just released version 1.0.1 of setools.

...

> The next release, sometime in early December, will include improved
> information flow analysis, the ability to save and load complex
> queries in apol, the removal of Tcl/TK and X dependencies from the
> command-line tools, and a log file analysis tool that leverages
> libapol to help a policy developer or system administrator
> understand the audit message from SELinux.

Karl,

It would also be very helpful if the setools distribution adhered to
GNU Coding Standards.  The standards have been developed over a long
period of time, and compliant distributions fit into the Linux
framework well.  Furthermore, tools are available that automate most
of the work needed to meet the standards.  The lastest generation of
autoconf, automake, libtool, and autoheader, make managing releases a
no-brainer.

If you're not an Emacs user, you can read about the GNU Coding
Standards with the command "info standards".

You can see an example of a distribution that meets the standards in
the selinux-usr/slat directory of the nsa module in the selinux
project's CVS repository on SourceForge.  I just finished tuning it.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
