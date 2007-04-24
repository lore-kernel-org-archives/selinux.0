Subject: Re: [PATCH -trunk][RFC] libselinux: drop setlocaldefs
	and	preservebools support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <4627B57A.7080507@manicmethod.com>
References: <1177006819.27654.174.camel@moss-spartans.epoch.ncsc.mil>
	 <4627B57A.7080507@manicmethod.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 13:20:19 -0400
Message-Id: <1177435219.24282.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 14:31 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > This an RFC only, not for merging yet.  It naturally depends on the kernel patch
> > for preserving booleans atomically, and it also likely requires a bump in the .so version.
> > But you need it to test the kernel support without interference from libselinux.
> >
> > ---
> >
> > Drop setlocaldefs and preservebools support from the policy loading
> > code in libselinux on the trunk.
> >
> > setlocaldefs (patching local user definitions and boolean settings
> > into the in-memory policy at load time) is obsoleted by libsemanage and
> > managed policy.
> >
> > preservebools (preserving boolean values across a policy reload rather
> > than resetting to the policy defaults) will be handled by the kernel
> > going forward.
> >
> >   
> you should also remove the -b option from load_policy

Yes, thanks - just committed the patch below to do that.
After a bit, we'll remove the b option from the getopt call altogether
(as well as drop the other warnings that already exist for older usage
styles) and turn them all into fatal errors, but for now, we'll warn the
user to catch any lingering uses.

Index: trunk/policycoreutils/load_policy/load_policy.c
===================================================================
--- trunk/policycoreutils/load_policy/load_policy.c	(revision 2357)
+++ trunk/policycoreutils/load_policy/load_policy.c	(working copy)
@@ -19,13 +19,13 @@
 
 void usage(char *progname)
 {
-	fprintf(stderr, _("usage:  %s [-bq]\n"), progname);
+	fprintf(stderr, _("usage:  %s [-q]\n"), progname);
 	exit(1);
 }
 
 int main(int argc, char **argv)
 {
-	int ret, opt, quiet = 0, preservebools = 1, nargs;
+	int ret, opt, quiet = 0, nargs;
 
 #ifdef USE_NLS
 	setlocale(LC_ALL, "");
@@ -36,7 +36,8 @@
 	while ((opt = getopt(argc, argv, "bq")) > 0) {
 		switch (opt) {
 		case 'b':
-			preservebools = 0;
+			fprintf(stderr, "%s:  Warning! The -b option is no longer supported, booleans are always preserved across reloads.  Continuing...\n",
+				argv[0]);
 			break;
 		case 'q':
 			quiet = 1;
@@ -61,7 +62,7 @@
 			argv[0], argv[optind++]);
 	}
 
-	ret = selinux_mkload_policy(preservebools);
+	ret = selinux_mkload_policy(1);
 	if (ret < 0) {
 		fprintf(stderr, _("%s:  Can't load policy:  %s\n"),
 			argv[0], strerror(errno));
Index: trunk/policycoreutils/load_policy/load_policy.8
===================================================================
--- trunk/policycoreutils/load_policy/load_policy.8	(revision 2357)
+++ trunk/policycoreutils/load_policy/load_policy.8	(working copy)
@@ -4,19 +4,17 @@
 
 .SH SYNOPSIS
 .B load_policy 
-[-bq]
+[-q]
 .br
 .SH DESCRIPTION
 .PP
-load_policy is the tool used to load/replace the policy in the kernel.
-By default, load_policy will preserve the current policy boolean values
-when loading the policy.
+load_policy loads the installed policy file into the kernel.
+The existing policy boolean values are automatically preserved
+across policy reloads rather than being reset to the default
+values in the policy file.
 
 .SH "OPTIONS"
 .TP
-.B \-b
-reset the policy boolean values to the saved policy settings.
-.TP
 .B \-q
 suppress warning messages.
 



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
