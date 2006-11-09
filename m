Subject: Re: [PATCH] libselinux MLS range context contains for PAM/cron
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1162936676.26574.15.camel@code.and.org>
References: <1162936676.26574.15.camel@code.and.org>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 10:37:31 -0500
Message-Id: <1163086651.12241.313.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-07 at 16:57 -0500, James Antill wrote:
>  Here is the libselinux changes needed to do the security context
> contains checks for PAM and cron.

Index: libselinux/include/selinux/av_permissions.h
===================================================================
--- libselinux/include/selinux/av_permissions.h	(revision 2076)
+++ libselinux/include/selinux/av_permissions.h	(working copy)
@@ -896,3 +896,4 @@
 #define KEY__SETATTR                              0x00000020UL
 #define KEY__CREATE                               0x00000040UL
 #define CONTEXT__TRANSLATE                        0x00000001UL
+#define CONTEXT__CONTAINS                         0x00000002UL
Index: libselinux/src/av_perm_to_string.h
===================================================================
--- libselinux/src/av_perm_to_string.h	(revision 2076)
+++ libselinux/src/av_perm_to_string.h	(working copy)
@@ -266,3 +266,4 @@
     S_(SECCLASS_KEY, KEY__SETATTR, "setattr")
     S_(SECCLASS_KEY, KEY__CREATE, "create")
     S_(SECCLASS_CONTEXT, CONTEXT__TRANSLATE, "translate")
+    S_(SECCLASS_CONTEXT, CONTEXT__CONTAINS, "contains")


This patch is obviously fine as long as the corresponding policy patch is accepted.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
