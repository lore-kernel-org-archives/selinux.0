Message-ID: <43BC4A17.5000203@cornell.edu>
Date: Wed, 04 Jan 2006 17:20:07 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] semanage_fcontext_get_by_idx
Content-Type: multipart/mixed;
 boundary="------------070703010405090009090504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070703010405090009090504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Funny thing... without this none of the swig wrappers are generated for 
policy file_contexts.


--------------070703010405090009090504
Content-Type: text/x-patch;
 name="libsemanage.fcontext_swig.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fcontext_swig.diff"

diff -Naurp --exclude man --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2006-01-04 14:18:49.000000000 -0500
+++ new/libsemanage/src/semanageswig.i	2006-01-04 17:11:00.000000000 -0500
@@ -61,6 +61,9 @@
 	semanage_bool_t *semanage_bool_by_idx(semanage_bool_t **list, int n) {
 		return list[n];
 	}
+	semanage_fcontext_t *semanage_fcontext_by_idx(semanage_fcontext_t **list, int n) {
+		return list[n];
+	}
 	char *char_by_idx(char **list, int n) {
 		return list[n];
 	}

--------------070703010405090009090504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
