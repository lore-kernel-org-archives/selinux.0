Subject: [patch] libselinux:  handle conflicting file contexts as a fatal
	error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1216406083.17602.352.camel@moss-spartans.epoch.ncsc.mil>
References: <4880CFD1.1040102@redhat.com>
	 <1216402063.17602.322.camel@moss-spartans.epoch.ncsc.mil>
	 <4880D585.9000405@redhat.com>
	 <1216403646.17602.339.camel@moss-spartans.epoch.ncsc.mil>
	 <1216406083.17602.352.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 15:01:12 -0400
Message-Id: <1216407672.17602.366.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ensure that conflicting file context errors are propagated to the
caller.  This causes setfiles -c to exit with an error status, which in
turn causes libsemanage to roll back the transaction and prevents such
entries from being added by semanage.

Duplicate same entries are left as warnings-only since they don't create
any ambiguity for file labeling.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

Index: trunk/libselinux/src/label_file.c
===================================================================
--- trunk/libselinux/src/label_file.c	(revision 2927)
+++ trunk/libselinux/src/label_file.c	(working copy)
@@ -146,8 +146,9 @@
 /*
  * Warn about duplicate specifications.
  */
-static void nodups_specs(struct saved_data *data, const char *path)
+static int nodups_specs(struct saved_data *data, const char *path)
 {
+	int rc = 0;
 	unsigned int ii, jj;
 	struct spec *curr_spec, *spec_arr = data->spec_arr;
 
@@ -161,8 +162,10 @@
 				if (strcmp
 				    (spec_arr[jj].lr.ctx_raw,
 				     curr_spec->lr.ctx_raw)) {
+					rc = -1;
+					errno = EINVAL;
 					COMPAT_LOG
-						(SELINUX_WARNING,
+						(SELINUX_ERROR,
 						 "%s: Multiple different specifications for %s  (%s and %s).\n",
 						 path, curr_spec->regex_str,
 						 spec_arr[jj].lr.ctx_raw,
@@ -176,6 +179,7 @@
 			}
 		}
 	}
+	return rc;
 }
 
 /* Determine if the regular expression specification has any meta characters. */
@@ -503,6 +507,10 @@
 	}
 	free(line_buf);
 
+	status = nodups_specs(data, path);
+	if (status)
+		goto finish;
+
 	/* Move exact pathname specifications to the end. */
 	spec_copy = malloc(sizeof(spec_t) * data->nspec);
 	if (!spec_copy)
@@ -519,8 +527,6 @@
 	free(data->spec_arr);
 	data->spec_arr = spec_copy;
 
-	nodups_specs(data, path);
-
 	status = 0;
 finish:
 	fclose(fp);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
