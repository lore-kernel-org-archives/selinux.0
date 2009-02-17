Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1HGa0ac010581
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:36:00 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1HGZwZD024771
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 16:35:59 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n1HGZt08020358
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:35:55 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n1HGZt1d004552
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:35:56 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n1HGZsaE014390
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:35:54 -0500
Message-ID: <499AE76A.1010301@redhat.com>
Date: Tue, 17 Feb 2009 11:35:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Remove bogus audit2allow option
Content-Type: multipart/mixed;
 boundary="------------070404080703020800090604"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070404080703020800090604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------070404080703020800090604
Content-Type: text/plain;
 name="nsapolicycoreutils_audit2allow_audit2allow.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_audit2allow_audit2allow.1.patch"

--- nsapolicycoreutils/audit2allow/audit2allow.1	2009-01-13 08:45:35.000000000 -0500
+++ policycoreutils-2.0.61/audit2allow/audit2allow.1	2009-01-20 09:49:03.000000000 -0500
@@ -75,9 +75,6 @@
 Generate reference policy using installed macros.
 This attempts to match denials against interfaces and may be inaccurate.
 .TP
-.B "\-t "  | "\-\-tefile"
-Indicates input file is a te (type enforcement) file.  This can be used to translate old te format to new policy format.
-.TP
 .B "\-w" | "\-\-why"
 Translates SELinux audit messages into a description of why the access was denied
 

--------------070404080703020800090604
Content-Type: application/pgp-signature;
 name="nsapolicycoreutils_audit2allow_audit2allow.1.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename*0="nsapolicycoreutils_audit2allow_audit2allow.1.patch.sig"

iEYEABECAAYFAkma52kACgkQrlYvE4MpobO4kACfeI03j2s3XbmwJQUW/i8vIr593e0An0lq
2AEnqCWLhha5zW1js5OcFKFv
--------------070404080703020800090604--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
