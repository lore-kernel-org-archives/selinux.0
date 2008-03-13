Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2DNPRFM009611
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 19:25:27 -0400
Message-ID: <47D9B7AB.4040701@tycho.nsa.gov>
Date: Thu, 13 Mar 2008 19:24:27 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: libselinux/matchpathcon has a memory leak
References: <47D9B0DB.90308@redhat.com>
In-Reply-To: <47D9B0DB.90308@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Looks like the selabel stuff is leaking.
>   

Try this patch please:

Index: libselinux/src/label_file.c
===================================================================
--- libselinux/src/label_file.c	(revision 2848)
+++ libselinux/src/label_file.c	(working copy)
@@ -490,9 +490,8 @@
 				goto finish;
 			}
 			if (NULL == (data->spec_arr =
-				     malloc(sizeof(spec_t) * data->nspec)))
+				     calloc(data->nspec, sizeof(spec_t))))
 				goto finish;
-			memset(data->spec_arr, 0, sizeof(spec_t)*data->nspec);
 			maxnspec = data->nspec;
 			rewind(fp);
 			if (homedirfp)
@@ -504,7 +503,7 @@
 	free(line_buf);
 
 	/* Move exact pathname specifications to the end. */
-	spec_copy = malloc(sizeof(spec_t) * data->nspec);
+	spec_copy = calloc(data->nspec, sizeof(spec_t));
 	if (!spec_copy)
 		goto finish;
 	j = 0;
Index: libselinux/src/matchpathcon.c
===================================================================
--- libselinux/src/matchpathcon.c	(revision 2848)
+++ libselinux/src/matchpathcon.c	(working copy)
@@ -284,6 +284,8 @@
 
 int matchpathcon_init_prefix(const char *path, const char *subset)
 {
+	matchpathcon_fini();
+
 	if (!mycanoncon)
 		mycanoncon = default_canoncon;
 
Index: libselinux/src/label.c
===================================================================
--- libselinux/src/label.c	(revision 2848)
+++ libselinux/src/label.c	(working copy)
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
