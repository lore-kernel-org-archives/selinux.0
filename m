Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAAE4k2L015751
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 09:04:47 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAAE4gbr025826
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 14:04:46 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mAAE4dvG003148
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 09:04:39 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mAAE4cxI014806
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 09:04:38 -0500
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mAAE4bjM005003
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 09:04:37 -0500
Message-ID: <49183F77.90504@redhat.com>
Date: Mon, 10 Nov 2008 09:04:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Latest policycoreutils package has a minor problem
Content-Type: multipart/mixed;
 boundary="------------040405050900020703060503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040405050900020703060503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Checking _local twice.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkYP3cACgkQrlYvE4MpobMnWgCeL/bznrLXw4zKYcyRsbIo8phW
mSEAmwYg9qNWdCkkDVaF/wAXgoGIFFam
=2aSt
-----END PGP SIGNATURE-----

--------------040405050900020703060503
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.13 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.58/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2008-11-10 08:53:49.000000000 -0500
+++ policycoreutils-2.0.58/semanage/seobject.py	2008-11-10 08:59:16.000000000 -0500
@@ -1430,7 +1430,7 @@
 		if rc < 0:
 			raise ValueError(_("Could not create key for %s") % target)
 
-		(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
+		(rc,exists) = semanage_fcontext_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if file context for %s is defined") % target)
 

--------------040405050900020703060503
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkkYP3cACgkQrlYvE4MpobPrQACgiiNBIp2/UJEhoReElSEpTtE83qoAnjV4
v9K9pjtT+yQ3JM9XQahzbXnw
--------------040405050900020703060503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
