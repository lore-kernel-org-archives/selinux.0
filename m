Message-ID: <4F3AD084.5060304@redhat.com>
Date: Tue, 14 Feb 2012 16:22:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Force avc_has_perm to return success if enforcing == 0;
Content-Type: multipart/mixed;
 boundary="------------010209090208070501070001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010209090208070501070001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I would like to patch libselinux to always return 0 on avc_has_perm if
the machine is in permissive mode.

This will allow Userspace Object Managers to work even if the system
is totally mislabeled and processes as running with bad context.
Currently if a program like dbus asks with a bad process label it can
get denials even in permissive mode.

Does anyone see a problem with this?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk860IQACgkQrlYvE4MpobNPFwCfVbE1QGJ0M8byHYZlf2U3XpdE
Ga0An2Z2/wBklr/e6OX+4EYTrFDvL69o
=btOY
-----END PGP SIGNATURE-----

--------------010209090208070501070001
Content-Type: text/x-patch;
 name="avc_has_perm_permissive.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="avc_has_perm_permissive.patch"

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index e7ad31d..2de39b9 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -801,6 +801,7 @@ int avc_has_perm_noaudit(security_id_t ssid,
 
       out:
 	avc_release_lock(avc_lock);
+	if (!avc_enforcing) return 0;
 	return rc;
 }
 

--------------010209090208070501070001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
