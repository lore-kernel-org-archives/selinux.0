Message-Id: <200302241842.NAA14593@moss-shockers.ncsc.mil>
Date: Mon, 24 Feb 2003 13:42:41 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Errors While Installing On Redhat 8.0
To: spatel@elp.rr.com, SELinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Troop_of_Antelope_335_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Troop_of_Antelope_335_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: 2TuK5x/HGupu7JcBwh5jaw==


Russell Coker wrote:
> That looks like a bug in policy/Makefile in selinux-small.  The mv line in 
> question should probably be prefixed with '-' to tell make to ignore such 
> errors.
> 
> BTW In such situations it's usually best to just send the relevant messages 
> and some context, the previous pages of successful operations is not needed.

Yes, someone previously mentioned this on the list.  Patch attached.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--Troop_of_Antelope_335_000
Content-Type: TEXT/x-sun-Makefile; name="Makefile.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: Makefile.patch
Content-MD5: B0FSTtPGJhxfu8m1MRo0rg==

Index: selinux/policy/Makefile
===================================================================
RCS file: /home/pal/CVS/selinux/policy/Makefile,v
retrieving revision 1.24
retrieving revision 1.25
diff -u -r1.24 -r1.25
--- selinux/policy/Makefile	10 Jan 2003 19:32:11 -0000	1.24
+++ selinux/policy/Makefile	24 Feb 2003 18:30:31 -0000	1.25
@@ -67,7 +67,7 @@
 
 install-src: 
 	rm -rf $(SRCINSTALLDIR)/policy.old
-	mv $(SRCINSTALLDIR)/policy $(SRCINSTALLDIR)/policy.old
+	-mv $(SRCINSTALLDIR)/policy $(SRCINSTALLDIR)/policy.old
 	mkdir -p $(SRCINSTALLDIR)/policy
 	cp -R . $(SRCINSTALLDIR)/policy
 

--Troop_of_Antelope_335_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
