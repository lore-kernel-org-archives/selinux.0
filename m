Message-ID: <436B71C7.700@cornell.edu>
Date: Fri, 04 Nov 2005 09:35:51 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Jonathan Kim <jkim@TrustedCS.com>, SELinux@tycho.nsa.gov,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [ SEMANAGE] Resync seuser parser
References: <36282A1733C57546BE392885C0618592D975CA@chaos.tcs.tcs-sec.com>	 <1131048615.23420.142.camel@moss-spartans.epoch.ncsc.mil>	 <1131050021.23420.153.camel@moss-spartans.epoch.ncsc.mil>	 <1131050864.23420.165.camel@moss-spartans.epoch.ncsc.mil>	 <436A8156.5090003@cornell.edu> <436B14FD.8010708@cornell.edu>	 <436B188D.4050701@cornell.edu> <1131112032.23420.210.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131112032.23420.210.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040504080807020106090907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040504080807020106090907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> I don't see why it is needed; it seems like one would omit the separator
> as well if no level was being specified.
>   



--------------040504080807020106090907
Content-Type: text/x-patch;
 name="libselinux.missing_colon.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux.missing_colon.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libselinux/src/seusers.c new/libselinux/src/seusers.c
--- old/libselinux/src/seusers.c	2005-11-04 09:33:06.000000000 -0500
+++ new/libselinux/src/seusers.c	2005-11-04 09:31:54.000000000 -0500
@@ -19,6 +19,7 @@ static int process_seusers(const char *b
 	char *newbuf = strdup(buffer);
 	char *luser = NULL, *seuser = NULL, *level = NULL;
 	char *start, *end;
+	int mls_found = 1;
 
 	if (!newbuf)
 		goto err;
@@ -42,8 +43,8 @@ static int process_seusers(const char *b
 	start = end+1;
 	end = strchr(start, ':');
 	if (!end) {
-		if (mls_enabled)
-			goto err; /* no MLS level and MLS is enabled */
+		mls_found = 0;
+
 		/* MLS is disabled, so :level suffix not required. */
 		end = start;
 		while (*end && !isspace(*end))
@@ -55,7 +56,7 @@ static int process_seusers(const char *b
 	if (!seuser)
 		goto err;
 
-	if (!mls_enabled)
+	if (!mls_enabled || !mls_found)
 		goto out; /* skip any MLS level */
 
 	start = ++end;
@@ -63,11 +64,9 @@ static int process_seusers(const char *b
 		end++;
 	*end = 0;
 
-	if (*start && !isspace(*start)) {
-		level = strdup(start);
-		if (!level)
-			goto err;
-	}
+	level = strdup(start);
+	if (!level)
+		goto err;
 
 out:
 	free(newbuf);

--------------040504080807020106090907--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
