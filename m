Message-ID: <47DAD18F.5000309@tycho.nsa.gov>
Date: Fri, 14 Mar 2008 15:27:11 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux/matchpathcon has a memory leak
References: <47D9B0DB.90308@redhat.com> <47D9B8BB.2080402@redhat.com>	 <47D9BBEE.5090105@redhat.com> <1205501760.22912.38.camel@moss-spartans.epoch.ncsc.mil> <47DA9A3C.3080802@redhat.com>
In-Reply-To: <47DA9A3C.3080802@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is a new version of the patch.

The clearing out of the data instead of freeing it is a leftover from 
when that was a global variable.  That was the cause of the leak I 
thought was the result of a missing matchpathcon_fini().

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

Index: src/label_file.c
===================================================================
--- src/label_file.c	(revision 2848)
+++ src/label_file.c	(working copy)
@@ -562,7 +562,7 @@
 	if (data->stem_arr)
 		free(data->stem_arr);
 	
-	memset(data, 0, sizeof(*data));
+	free(data);
 }
 
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
Index: src/label.c
===================================================================
--- src/label.c	(revision 2848)
+++ src/label.c	(working copy)
@@ -95,7 +95,7 @@
 	if (compat_validate(rec, lr, "file_contexts", 0))
 		return NULL;
 
-	if (translating &&
+	if (translating && !lr->ctx_trans &&
 	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
 		return NULL;
 




-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
