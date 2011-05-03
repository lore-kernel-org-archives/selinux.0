Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p43Di0wU020878
	for <selinux@tycho.nsa.gov>; Tue, 3 May 2011 09:44:00 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p43Dhxww014199
	for <selinux@tycho.nsa.gov>; Tue, 3 May 2011 13:43:59 GMT
Message-ID: <4DC0069D.9090208@redhat.com>
Date: Tue, 03 May 2011 09:43:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Steve Lawrence <slawrence@tresys.com>
Subject: This is the current libsepol-patch after the update.
Content-Type: multipart/mixed;
 boundary="------------020604040203090600010100"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020604040203090600010100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I will leave it to Eric to explain the patch.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3ABp0ACgkQrlYvE4MpobMVSACfVM7bandSo7Wgoy/KpTJX7PNQ
EQgAoJ0a8U3sZ6X/EeM1XmfM6DQN26+z
=meWO
-----END PGP SIGNATURE-----

--------------020604040203090600010100
Content-Type: text/plain;
 name="libsepol-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsepol-rhat.patch"

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index b1af365..42bc931 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1181,23 +1181,26 @@ static int copy_role_trans(expand_state_t * state, role_trans_rule_t * rules)
 
 					cur_trans = state->out->role_tr;
 					while (cur_trans) {
+						unsigned int mapped_role;
+
+						mapped_role = state->rolemap[cur->new_role - 1];
+
 						if ((cur_trans->role ==
 								i + 1) &&
 						    (cur_trans->type ==
 								j + 1) &&
 						    (cur_trans->tclass ==
 								k + 1)) {
-							if (cur_trans->
-							    new_role ==
-								cur->new_role) {
+							if (cur_trans->new_role == mapped_role) {
 								break;
 							} else {
 								ERR(state->handle,
-									"Conflicting role trans rule %s %s : %s %s",
+									"Conflicting role trans rule %s %s : %s { %s vs %s }",
 									state->out->p_role_val_to_name[i],
 									state->out->p_type_val_to_name[j],
 									state->out->p_class_val_to_name[k],
-									state->out->p_role_val_to_name[cur->new_role - 1]);
+									state->out->p_role_val_to_name[mapped_role],
+									state->out->p_role_val_to_name[cur_trans->new_role - 1]);
 								return -1;
 							}
 						}
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 6d8ff91..3d8dc80 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2280,6 +2280,7 @@ int filename_trans_read(filename_trans_t **t, struct policy_file *fp)
 			lft->next = ft;
 		else
 			*t = ft;
+		lft = ft;
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
 			return -1;

--------------020604040203090600010100
Content-Type: application/pgp-signature;
 name="libsepol-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libsepol-rhat.patch.sig"

iEYEABECAAYFAk3ABp0ACgkQrlYvE4MpobPJ3ACgkZMuCdWoNsBgVLd/yyF0UBNeAsoAoNWG
5l3pjoI230P8xZRK6hrvrOP3
--------------020604040203090600010100--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
