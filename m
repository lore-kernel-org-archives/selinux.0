Subject: Re: Manual Page for audit2allow
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87ekggubi5.fsf@glaurung.internal.golden-gryphon.com>
References: <87ekggubi5.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: multipart/mixed; boundary="=-4UF3oLGUD0aZ5/Yq56bf"
Message-Id: <1106245558.26753.190.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 Jan 2005 13:25:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-4UF3oLGUD0aZ5/Yq56bf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-01-19 at 20:37, Manoj Srivastava wrote:
>         While packaging policycoreutils for Debian, I've come across a
>  couple of utilities without manual pages (which is against d4ebian
>  technical policy), so I'm writing up pages as I go along. Here is a
>  manual page for audit2allow; perhaps it can be incorporated upstream.

Thanks, I am merging this with the modifications below.
> 
> ______________________________________________________________________
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

--=-4UF3oLGUD0aZ5/Yq56bf
Content-Disposition: attachment; filename=audit2allow.diff
Content-Type: text/x-patch; name=audit2allow.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/audit2allow/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/audit2allow/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- policycoreutils/audit2allow/Makefile	17 Oct 2003 17:38:02 -0000	1.1
+++ policycoreutils/audit2allow/Makefile	20 Jan 2005 18:16:36 -0000
@@ -1,6 +1,7 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
 BINDIR ?= $(PREFIX)/bin
+MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
 TARGETS=audit2allow
@@ -10,6 +11,8 @@
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 $(TARGETS) $(BINDIR)
+	-mkdir -p $(MANDIR)/man1
+	install -m 644 audit2allow.1 $(MANDIR)/man1/
 
 clean:
 
Index: policycoreutils/audit2allow/audit2allow.1
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/audit2allow/audit2allow.1,v
retrieving revision 1.1
diff -u -r1.1 audit2allow.1
--- policycoreutils/audit2allow/audit2allow.1	20 Jan 2005 18:17:11 -0000	1.1
+++ policycoreutils/audit2allow/audit2allow.1	20 Jan 2005 18:25:10 -0000
@@ -41,8 +41,7 @@
 Turn on verbose output
 .TP
 .B "\-l"
-read input only after last 
-.BI \"load_policy\"
+read input only after last policy reload
 .TP
 .B "\-i <inputfile>"
 read input from 
@@ -55,15 +54,22 @@
 .PP
 This utility scans the logs for messages logged when the system denied
 permission for operations, and generates a snippet of policy rules
-which, if loaded into policy, would ahve allowed those operations to
-succeed. 
+which, if loaded into policy, might have allowed those operations to
+succeed. However, this utility only generates Type Enforcement (TE) allow 
+rules.  Certain permission denials may require other kinds of policy changes,
+e.g. adding an attribute to a type declaration to satisfy an existing
+constraint, adding a role allow rule, or modifying a constraint.
 .PP
-Care must be exercised while acting on the outpu of this utility to
-ensure that the operations being permitted do not pose a secureity
-threat. Often it is better to define new domains, or make other
+Care must be exercised while acting on the output of this utility to
+ensure that the operations being permitted do not pose a security
+threat. Often it is better to define new domains and/or types, or make other
 structural changes to narrowly allow an optimal set of operations to
 succeed, as opposed to blindly implementing the sometimes broad
-changes recommended by this utility.
+changes recommended by this utility.   Certain permission denials are 
+not fatal to the application, in which case it may be preferable to
+simply suppress logging of the denial via a 'dontaudit' rule rather than
+an 'allow' rule.
+.PP
 .SH AUTHOR
 This manual page was written by 
 .I Manoj Srivastava <srivasta@debian.org>,

--=-4UF3oLGUD0aZ5/Yq56bf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
