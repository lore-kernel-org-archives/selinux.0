Subject: Re: writing zero bytes in bash
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <1109687885.10589.5.camel@moss-spartans.epoch.ncsc.mil>
References: <200502261832.16337.russell@coker.com.au>
	 <1109616468.28470.20.camel@moss-spartans.epoch.ncsc.mil>
	 <200503010721.59865.russell@coker.com.au>
	 <1109686814.10589.0.camel@moss-spartans.epoch.ncsc.mil>
	 <1109687885.10589.5.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 12:04:34 -0500
Message-Id: <1109696674.10589.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-01 at 09:38 -0500, Stephen Smalley wrote:
> BTW, we _could_ modify the kernel code to also accept a string
> containing only a newline as a variant way of expressing "clear
> attribute" for writes to /proc/pid/attr.  But such a change will
> obviously take time to get into an upstream kernel, and I don't even
> want to think about changing libselinux to start doing that (with the
> attendant dependency on the new kernel).

Sample patch below for the kernel, allows you to do:
echo system_u:object_r:etc_t > /proc/self/attr/fscreate;
echo hello > tmpfile;
echo "" > /proc/self/attr/fscreate;
echo hello > tmpfile2;
ls -Z tmpfile tmpfile2
-rw-r--r--  root     root     system_u:object_r:etc_t          tmpfile
-rw-r--r--  root     root     root:object_r:user_home_t        tmpfile2

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.152
diff -u -p -r1.152 hooks.c
--- linux-2.6/security/selinux/hooks.c	23 Feb 2005 20:26:50 -0000	1.152
+++ linux-2.6/security/selinux/hooks.c	1 Mar 2005 16:11:29 -0000
@@ -4094,6 +4094,7 @@ static int selinux_setprocattr(struct ta
 	struct task_security_struct *tsec;
 	u32 sid = 0;
 	int error;
+	char *str = value;
 
 	if (current != p) {
 		/* SELinux only allows a process to change its own
@@ -4118,8 +4119,11 @@ static int selinux_setprocattr(struct ta
 		return error;
 
 	/* Obtain a SID for the context, if one was specified. */
-	if (size) {
-		int error;
+	if (size && str[1] && str[1] != '\n') {
+		if (str[size-1] == '\n') {
+			str[size-1] = 0;
+			size--;
+		}
 		error = security_context_to_sid(value, size, &sid);
 		if (error)
 			return error;


-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
