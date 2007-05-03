Subject: Re: launching apps at level (MLS) and polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <cadfc0e40705030611l532d490dr2016dbff69a51628@mail.gmail.com>
References: <463243E3.2060602@gmail.com>
	 <1177700491.3357.113.camel@moss-spartans.epoch.ncsc.mil>
	 <1177700749.3357.116.camel@moss-spartans.epoch.ncsc.mil>
	 <463360B0.7020106@gmail.com>
	 <1177934887.16232.7.camel@moss-spartans.epoch.ncsc.mil>
	 <4636002F.5000100@gmail.com>
	 <1177944754.16232.28.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705020849o3f1b90c4l6f7bb5d9dcbc3c23@mail.gmail.com>
	 <1178125027.3443.67.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705030611l532d490dr2016dbff69a51628@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 09:49:08 -0400
Message-Id: <1178200148.3443.166.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-03 at 08:11 -0500, Xavier Toth wrote:
--- policycoreutils-1.33.12/newrole/newrole.c	2007-05-03 08:03:44.000000000 -0500
+++ policycoreutils-1.33.12.new/newrole/newrole.c	2007-05-03 08:03:27.000000000 -0500
@@ -1025,7 +1134,25 @@
 
 	printf(_("Authenticating %s.\n"), pw.pw_name);
 #ifdef USE_PAM
-	pam_status = pam_start(SERVICE_NAME, pw.pw_name, &pam_conversation,
+	/*
+	  Are we being asked to execute a process in a new context?
+	*/
+	if (app_service_names != NULL && optind < argc) {
+	  /*
+	    See if there is a pam configuration specific to the executable.
+	  */
+	  char *cmd = strtok(argv[optind+1], " \t");

Actually, here you don't want to use strtok() since it mutates the argument 
(inserting NUL separator), which will cause any subsequent arguments after
the command to be effectively lost.

Please update the man page as well to show the proper way to execute commands via newrole.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
