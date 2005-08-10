Date: Wed, 10 Aug 2005 16:36:21 -0500
From: serue@us.ibm.com
To: SELinux@tycho.nsa.gov
Subject: [PATCH] Don't free n[i] when n is NULL
Message-ID: <20050810213621.GC7826@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a bug found in booleans.c by Coverity:

	When the malloc for n fails, we jump to 'bad:', where we
	proceed to try to free n[i] even though n is NULL.

Index: src/booleans.c
===================================================================
--- src.orig/booleans.c
+++ src/booleans.c
@@ -70,7 +70,7 @@ int security_get_boolean_names(char ***n
 				     * (namelist[i]->d_reclen + 1));
 		if (!n[i]) {
 			rc = -1;
-			goto bad;
+			goto bad_freen;
 		}
 		strncpy(n[i], namelist[i]->d_name, namelist[i]->d_reclen + 1);
 	}
@@ -82,12 +82,13 @@ out:
 	}
 	free(namelist);
 	return rc;
-bad:
+bad_freen:
 	for (i = 0; i < *len; i++) {
 		if (n[i])
 			free(n[i]);
 	}
 	free(n);
+bad:
 	goto out;
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
