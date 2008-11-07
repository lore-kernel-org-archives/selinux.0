Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA7EdYF8009997
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:39:34 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA7EdXYp016248
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 14:39:34 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EdXtb003628
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:39:33 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mA7EdWdK031809
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:39:33 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EdW9O015158
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:39:32 -0500
Message-ID: <49145324.3040808@redhat.com>
Date: Fri, 07 Nov 2008 09:39:32 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: chcat patch.
Content-Type: multipart/mixed;
 boundary="------------080203050209080802080901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080203050209080802080901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Prevent chcat from expanding number of categories above max size of
command line.  Arbitrarily picked 25.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkUUyQACgkQrlYvE4MpobMDDwCg0DMLERlnHZyVmORa9de9f5tf
fQsAoJZpO646H5CFuXZuW6htHpPfHz/z
=4OcI
-----END PGP SIGNATURE-----

--------------080203050209080802080901
Content-Type: text/plain;
 name="chcat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chcat.patch"

--- nsapolicycoreutils/scripts/chcat	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.57/scripts/chcat	2008-11-04 19:09:01.000000000 -0500
@@ -291,6 +291,8 @@
             for i in c.split(","):
                 if i not in newcats:
                     newcats.append(i)
+    if len(newcats) > 25:
+        return cats
     return newcats
 
 def translate(cats):

--------------080203050209080802080901
Content-Type: application/octet-stream;
 name="chcat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="chcat.patch.sig"

iEYEABECAAYFAkkUUyQACgkQrlYvE4MpobOoZACgiqHJdzBNFudj6QKU4tlbGbNKaZgAn32H
ce6fBAEilmsD7HawTtrR+usO
--------------080203050209080802080901--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
