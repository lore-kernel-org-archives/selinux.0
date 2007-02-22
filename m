Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1MFM9al030916
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 10:22:09 -0500
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1MFNRTj016502
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 15:23:28 GMT
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel6.hp.com (Postfix) with ESMTP id 50BDF343DC
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 10:23:27 -0500 (EST)
Message-ID: <45DDB4CD.7040308@hp.com>
Date: Thu, 22 Feb 2007 10:20:45 -0500
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] newrole: fix for newrole hanging on some serial consoles
References: <45DDACEE.20205@hp.com>
In-Reply-To: <45DDACEE.20205@hp.com>
Content-Type: multipart/mixed;
 boundary="------------010904080606030409020809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010904080606030409020809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Reposting to fix a whitespace problem and adjust the patch location.

Signed-off-by: Linda Knippers <linda.knippers@hp.com>

--------------010904080606030409020809
Content-Type: text/plain;
 name="newrole.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newrole.patch"

--- policycoreutils-1.33.12/newrole/newrole.c	2007-02-20 13:32:46.000000000 -0500
+++ policycoreutils-1.33.12.ljk/newrole/newrole.c	2007-02-22 10:20:39.000000000 -0500
@@ -636,11 +636,12 @@ static int relabel_tty(const char *ttyn,
 	}
 
 	/* Re-open TTY descriptor */
-	fd = open(ttyn, O_RDWR);
+	fd = open(ttyn, O_RDWR|O_NONBLOCK);
 	if (fd < 0) {
 		fprintf(stderr, _("Error!  Could not open %s.\n"), ttyn);
 		return fd;
 	}
+	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
 
 	if (fgetfilecon(fd, &tty_con) < 0) {
 		fprintf(stderr, _("%s!  Could not get current context "
@@ -1127,15 +1128,18 @@ int main(int argc, char *argv[])
 		fprintf(stderr, _("Could not close descriptors.\n"));
 		goto err_close_pam;
 	}
-	fd = open(ttyn, O_RDONLY);
+	fd = open(ttyn, O_RDONLY|O_NONBLOCK);
 	if (fd != 0)
 		goto err_close_pam;
-	fd = open(ttyn, O_RDWR);
+	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+	fd = open(ttyn, O_RDWR|O_NONBLOCK);
 	if (fd != 1)
 		goto err_close_pam;
-	fd = open(ttyn, O_RDWR);
+	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+	fd = open(ttyn, O_RDWR|O_NONBLOCK);
 	if (fd != 2)
 		goto err_close_pam;
+	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
 
 	/*
 	 * Step 5:  Execute a new shell with the new context in `new_context'. 

--------------010904080606030409020809--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
