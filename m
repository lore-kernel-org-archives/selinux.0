Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72J9HrT015396
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 15:09:17 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72J8iXV012511
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 19:08:45 GMT
Subject: RE: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux-dev@tresys.com
In-Reply-To: <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-lSEuTP+vLvH4iwj6YiIS"
Message-Id: <1091473703.23449.260.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 15:08:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-lSEuTP+vLvH4iwj6YiIS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-08-02 at 14:53, Stephen Smalley wrote:
> I wanted to re-open this thread of discussion regarding whether some of
> the current policy compile-time tunables should be converted to runtime
> policy booleans.  The policy tunables were originally introduced prior
> to the merging of the conditional policy support, but conditional
> support has been available in the mainline kernel since Linux 2.6.5.  I
> have created some experimental policy patches converting many of the
> base tunables from tunable.{tun,te} to booleans; these are presently
> available in the sourceforge CVS tree and I'll include one small patch
> below for reference as an example.  

BTW, if you want to experiment with these changes, you'll need the
latest checkpolicy from the sourceforge CVS tree (or apply the attached
patch to it), as there was a bug in the conditional code in checkpolicy
that was just fixed by the Tresys team.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-lSEuTP+vLvH4iwj6YiIS
Content-Disposition: attachment; filename=cond-self-bug-7-30-2004.patch
Content-Type: text/x-patch; name=cond-self-bug-7-30-2004.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/30 17:42:37-04:00 kmacmillan@pham.(none) 
#   Fix for self handling bug.
# 
# checkpolicy/policy_parse.y
#   2004/07/30 17:42:28-04:00 kmacmillan@pham.(none) +34 -14
#   Fix for self handling bug.
# 
diff -Nru a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
--- a/checkpolicy/policy_parse.y	Fri Jul 30 17:43:50 2004
+++ b/checkpolicy/policy_parse.y	Fri Jul 30 17:43:50 2004
@@ -2505,7 +2505,7 @@
 static cond_av_list_t *define_cond_te_avtab(int which)
 {
 	char *id;
-	cond_av_list_t *sub_list, *self_list, *n;
+	cond_av_list_t *sub_list, *final_list, *tail;
 	class_datum_t *cladatum;
 	perm_datum_t *perdatum;
 	ebitmap_t stypes, ttypes, tclasses, negset;
@@ -2623,27 +2623,47 @@
 		free(id);
 	}
 
-	sub_list = (cond_av_list_t *) 0;
-	self_list = (cond_av_list_t *) 0;
+	sub_list = NULL;
+	tail = NULL;
+	final_list = NULL;
+
+	if (self) {
+		for (i = ebitmap_startbit(&stypes); i < ebitmap_length(&stypes); i++) {
+			if (!ebitmap_get_bit(&stypes, i)) 
+				continue;
+			if (self) {
+				if ((sub_list = cond_te_avtab_helper(which, i, i, &tclasses, avp )) == COND_ERR)
+					return COND_ERR;
+				if (final_list) {
+					tail->next = sub_list;
+					while (tail->next != NULL)
+						tail = tail->next;
+				} else {
+					final_list = sub_list;
+					tail = final_list;
+					while (tail->next != NULL)
+						tail = tail->next;
+				}
+			}
+		}
+	}
 	for (i = ebitmap_startbit(&stypes); i < ebitmap_length(&stypes); i++) {
 		if (!ebitmap_get_bit(&stypes, i)) 
 			continue;
-		if (self) {
-			if ((self_list = cond_te_avtab_helper(which, i, i, &tclasses, avp )) == COND_ERR)
-				return COND_ERR;
-		}
 		for (j = ebitmap_startbit(&ttypes); j < ebitmap_length(&ttypes); j++) {
 			if (!ebitmap_get_bit(&ttypes, j)) 
 				continue;
 			if ((sub_list = cond_te_avtab_helper(which, i, j, &tclasses, avp)) == COND_ERR)
 				return COND_ERR;
-			/* add the self_list, if any, and the sub_list */
-			if (self_list) {
-				n = self_list;
-				while (n->next != (cond_av_list_t *)0) n = n->next;
-				n->next = sub_list;
+			if (final_list) {
+				tail->next = sub_list;
+				while (tail->next != NULL)
+					tail = tail->next;
 			} else {
-				self_list = sub_list;
+				final_list = sub_list;
+				tail = final_list;
+				while (tail->next != NULL)
+					tail = tail->next;
 			}
 		}
 	}
@@ -2653,7 +2673,7 @@
 	ebitmap_destroy(&tclasses);
 	free(avp);
 	
-	return self_list;
+	return final_list;
  bad:
 	return COND_ERR;
 }

--=-lSEuTP+vLvH4iwj6YiIS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
