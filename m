Subject: Re: [LTP] Se-Linux Updates for LTP
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jburke@redhat.com
Cc: James Morris <jmorris@redhat.com>, Joy Latten <latten@us.ibm.com>,
        Daniel Walsh <dwalsh@redhat.com>, subrata@linux.vnet.ibm.com,
        ltp-list <ltp-list@lists.sourceforge.net>,
        George Kraft <gk4@us.ibm.com>, klausk@br.ibm.com,
        Robert Williamson <robbiew@us.ibm.com>,
        Michael Reed <mreed10@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Larson <plars@us.ibm.com>
In-Reply-To: <1197917423.17307.87.camel@moss-spartans.epoch.ncsc.mil>
References: <1197044724.4411.17.camel@subratamodak.linux.ibm.com>
	 <1197266491.4482.2.camel@subratamodak.linux.ibm.com>
	 <1197295269.18120.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20071210171503.GA25223@sergelap.austin.ibm.com>
	 <1197382969.9034.29.camel@subratamodak.linux.ibm.com>
	 <20071211155219.GA22416@sergelap.austin.ibm.com>
	 <1197458260.4710.95.camel@subratamodak.linux.ibm.com>
	 <1197477042.1125.83.camel@moss-spartans.epoch.ncsc.mil>
	 <4761CF71.1020101@redhat.com>
	 <1197916993.17307.81.camel@moss-spartans.epoch.ncsc.mil>
	 <1197917423.17307.87.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-5lO96Fu3ZfMzynfwT+5B"
Date: Mon, 17 Dec 2007 14:42:50 -0500
Message-Id: <1197920570.17307.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-5lO96Fu3ZfMzynfwT+5B
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2007-12-17 at 13:50 -0500, Stephen Smalley wrote:
> On Mon, 2007-12-17 at 13:43 -0500, Stephen Smalley wrote:
> > On Thu, 2007-12-13 at 19:33 -0500, Jeff Burke wrote:
> > > Stephen, Joy, Dan and James
> > > 	Using Stephens latest patch. Here are the results for the selinux tests
> > > ltp-full-20071130, RHEL5.1 + selinux-policy-2.4.6-106.el5_1.3:
> > 
> > Reverting the prior patches and applying this one instead, I am able to
> > run all of the test cases successfully on RHEL5.1 with that policy
> > version.
> > 
> > I never did get a failure on SELinux10 though even with the old patch.
> > Looking at your log file, it suggests that you were running the tests
> > without a controlling tty?  That will break that particular test at
> > least (sendsigio_task).
> > 
> > As for the build failure on execshare_parent, I don't know how to fix
> > that on ia64 - is there a portable way to write a call to clone(2) that
> > will work there?  I don't have ia64 hardware readily available to me.
> 
> Ah, from the clone(2) man page, I see that one is supposed to use
> clone2() instead on IA-64.  But someone else will have to do that and
> test it - I don't have an ia64 machine at my disposal.

>From the example of other code in the ltp, it looks like the following
patch should work for ia-64.  This patch for the execshare test program
is in addition to the prior policy patch.



-- 
Stephen Smalley
National Security Agency

--=-5lO96Fu3ZfMzynfwT+5B
Content-Disposition: attachment; filename=execshare.diff
Content-Type: text/x-patch; name=execshare.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c,v
retrieving revision 1.1
diff -u -r1.1 selinux_execshare_parent.c
--- testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c	20 Apr 2005 16:09:08 -0000	1.1
+++ testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c	17 Dec 2007 19:34:16 -0000
@@ -26,11 +26,10 @@
 	return -1;
 }
 
-static long clone_stack_data[2048];
-static long *clone_stack = &clone_stack_data[2048];
-
 int main(int argc, char **argv)
 {
+	int pagesize;
+	void *clone_stack, *page;
 	int pid, rc, len, status, cloneflags;
 	security_context_t context_s;
 	context_t context;
@@ -46,6 +45,14 @@
 		exit(-1);
 	}
 
+	pagesize = getpagesize();
+	page = malloc(pagesize);
+	if (!page) {
+		perror("malloc");
+		exit(-1);
+	}
+	clone_stack = page + pagesize;
+
 	rc = getcon(&context_s);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
@@ -76,8 +83,13 @@
 		fprintf(stderr, "%s:  unable to set exec context to %s\n", argv[0], context_s);
 		exit(-1);
 	}
-
+#if defined(__hppa__)
+	pid = clone(clone_fn, page, cloneflags | SIGCHLD, argv);
+#elif defined(__ia64__)
+	pid = clone2(clone_fn, clone_stack, pagesize, cloneflags | SIGCHLD, argv, NULL, NULL, NULL);
+#else
 	pid = clone(clone_fn, clone_stack, cloneflags | SIGCHLD, argv);
+#endif
 	if (pid < 0) {
 		perror("clone");
 		exit(-1);

--=-5lO96Fu3ZfMzynfwT+5B--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
