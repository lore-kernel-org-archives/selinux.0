Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m124ZrXn007333
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2008 23:35:53 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m124ZqEp007681
	for <selinux@tycho.nsa.gov>; Sat, 2 Feb 2008 04:35:53 GMT
Message-ID: <47A3F327.8000202@redhat.com>
Date: Fri, 01 Feb 2008 23:35:51 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: setools is still broken in rawhide.
Content-Type: multipart/mixed;
 boundary="------------070800080406010600000806"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070800080406010600000806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch fixes two functions in libqpol/util.c

is_binpol_valid should return true if the policy version is greater than
or equal to the policy installed in the kernel.

search_binary_policy_file

Should return 0 on success, meaning it found a policy.

And return 1 if the return code is < 0;



Making these changes allows seinfo and sesearch to find policy.22 on a
machine running policy.21
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkej8yYACgkQrlYvE4MpobOeJQCfSLBDBI51Y/cpBqlauoN1GuOd
3EAAoMBfpuMexQ6XIXgJMYILwzYwMsXv
=Ggke
-----END PGP SIGNATURE-----

--------------070800080406010600000806
Content-Type: text/plain;
 name="setools-3.3.2-validpol.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setools-3.3.2-validpol.patch"

diff -up setools-3.3.2/libqpol/src/util.c.validpol setools-3.3.2/libqpol/src/util.c
--- setools-3.3.2/libqpol/src/util.c.validpol	2008-02-01 23:28:54.000000000 -0500
+++ setools-3.3.2/libqpol/src/util.c	2008-02-01 23:28:58.000000000 -0500
@@ -74,7 +74,7 @@ static int is_binpol_valid(const char *p
 	}
 	ret_version = qpol_binpol_version(policy_fp);
 	fclose(policy_fp);
-	return (ret_version == version);
+	return (ret_version >= version);
 }
 
 static int search_for_policyfile_with_ver(const char *binary_path, const int version, char **path)
@@ -198,7 +198,7 @@ static int search_binary_policy_file(cha
 	}
 	free(*path);
 	if ((rt = search_for_policyfile_with_ver(bin_path, current_version, path)) != 0) {
-		return rt;
+		return rt < 0;
 	}
 #endif
 

--------------070800080406010600000806
Content-Type: application/octet-stream;
 name="setools-3.3.2-validpol.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="setools-3.3.2-validpol.patch.sig"

iEYEABECAAYFAkej8yYACgkQrlYvE4MpobNv3wCfaJIHMUwAwm6DUyiQxcIOjPNctdMAnj44
QAQOUjfYTMUoLvpaUcA41Xig
--------------070800080406010600000806--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
