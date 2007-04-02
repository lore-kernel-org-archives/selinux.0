Message-ID: <46115A84.1090205@tycho.nsa.gov>
Date: Mon, 02 Apr 2007 15:33:24 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: handle null SID's in sidput (revised)
References: <461154EB.5080804@tycho.nsa.gov>
In-Reply-To: <461154EB.5080804@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch makes it possible to sidput a userspace AVC SID in cleanup code
when the SID may never have been initialized.

This version drops the check in sidget and avoids taking the AVC lock on a
null SID (and fixes a null-pointer dereference).

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 avc.c |    2 ++
 1 file changed, 2 insertions(+)

Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2318)
+++ libselinux/src/avc.c	(working copy)
@@ -272,6 +272,8 @@
 int sidput(security_id_t sid)
 {
 	int rc;
+	if (!sid)
+	    return 0;
 	avc_get_lock(avc_lock);
 	rc = sid_dec_refcnt(sid);
 	avc_release_lock(avc_lock);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
