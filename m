Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2BMxhP4020718
	for <selinux@tycho.nsa.gov>; Sun, 11 Mar 2012 18:59:43 -0400
Received: from [192.168.1.38] (unknown [86.67.70.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id C91FC22E253
	for <selinux@tycho.nsa.gov>; Sun, 11 Mar 2012 18:59:41 -0400 (EDT)
Date: Sun, 11 Mar 2012 22:59:08 +0000
From: Martin Orr <martin@martinorr.name>
To: selinux@tycho.nsa.gov
Subject: policycoreutils: setfiles: Fix process_glob error handling
Message-ID: <20120311225908.GA10705@claudius.martinorr.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

process_one_realpath returns 1 if it changed the context of the file but
process_glob treats all non-zero values as errors.  This results in
setfiles exiting with non-zero status even though it was successful.

Fix process_glob to only treat negative return values of
process_one_realpath as errors.

cf. http://bugs.debian.org/662990

Signed-off-by: Martin Orr <martin@martinorr.name>

---

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 9a7d315..9176790 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -341,7 +341,9 @@ int process_glob(char *name, int recurse) {
 			continue;
 		if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
 			continue;
-		errors |= process_one_realpath(globbuf.gl_pathv[i], recurse);
+		int rc = process_one_realpath(globbuf.gl_pathv[i], recurse);
+		if (rc < 0)
+			errors = rc;
 	}
 	globfree(&globbuf);
 	return errors;
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index fa0cd6a..8d2eadf 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -409,7 +409,7 @@ int main(int argc, char **argv)
 			buf[len - 1] = 0;
 			if (!strcmp(buf, "/"))
 				mass_relabel = 1;
-			errors |= process_glob(buf, recurse);
+			errors |= process_glob(buf, recurse) < 0;
 		}
 		if (strcmp(input_filename, "-") != 0)
 			fclose(f);
@@ -418,7 +418,7 @@ int main(int argc, char **argv)
 			if (!strcmp(argv[i], "/"))
 				mass_relabel = 1;
 
-			errors |= process_glob(argv[i], recurse);
+			errors |= process_glob(argv[i], recurse) < 0;
 		}
 	}
 	

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
