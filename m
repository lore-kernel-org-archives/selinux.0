Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6DFrGsC031186
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2010 11:53:16 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6DFq2Bh002355
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2010 15:52:02 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o6DFquO7007010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2010 11:52:56 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o6DFqu2N009545
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2010 11:52:56 -0400
Message-ID: <4C3C8BD7.2020901@redhat.com>
Date: Tue, 13 Jul 2010 11:52:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: We need this patch for setools to allow it to build on F14.
Content-Type: multipart/mixed;
 boundary="------------060602080504080706040307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060602080504080706040307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Also

sesearch --all

Is broken right now because we do not retrieve NEVERALLOW rules.

This patch makes this error a warning so sesearch --all will return all
other rules.

--------------060602080504080706040307
Content-Type: text/plain;
 name="setools-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setools-rhat.patch"

diff -up setools-3.3.7/m4/ac_pkg_swig.m4~ setools-3.3.7/m4/ac_pkg_swig.m4
--- setools-3.3.7/m4/ac_pkg_swig.m4~	2007-02-09 12:32:41.000000000 -0500
+++ setools-3.3.7/m4/ac_pkg_swig.m4	2010-07-13 11:16:11.000000000 -0400
@@ -106,10 +106,13 @@ AC_DEFUN([AC_PROG_SWIG],[
                         if test -z "$available_patch" ; then
                                 [available_patch=0]
                         fi
-                        if test $available_major -ne $required_major \
-                                -o $available_minor -ne $required_minor \
-                                -o $available_patch -lt $required_patch ; then
-                                AC_MSG_WARN([SWIG version >= $1 is required.  You have $swig_version.  You should look at http://www.swig.org])
+			if test $available_major -lt $required_major \
+			    -o \( $available_major -eq $required_major \
+			        -a $available_minor -lt $required_minor \) \
+			    -o \( $available_major -eq $required_major \
+			        -a $available_minor -eq $required_minor \
+			        -a $available_patch -lt $required_patch \) ; then
+                                AC_MSG_WARN([SWIG version >= $1 is required. You have $swig_version.  You should look at http://www.swig.org])
                                 SWIG='echo "Error: SWIG version >= $1 is required.  You have '"$swig_version"'.  You should look at http://www.swig.org" ; false'
                         else
                                 AC_MSG_NOTICE([SWIG executable is '$SWIG'])
diff -up setools-3.3.7/libqpol/src/avrule_query.c~ setools-3.3.7/libqpol/src/avrule_query.c
--- setools-3.3.7/libqpol/src/avrule_query.c~	2010-04-23 12:22:08.000000000 -0400
+++ setools-3.3.7/libqpol/src/avrule_query.c	2010-07-13 11:40:16.000000000 -0400
@@ -57,8 +57,6 @@ int qpol_policy_get_avrule_iter(const qp
 
 	if ((rule_type_mask & QPOL_RULE_NEVERALLOW) && !qpol_policy_has_capability(policy, QPOL_CAP_NEVERALLOW)) {
 		ERR(policy, "%s", "Cannot get avrules: Neverallow rules requested but not available");
-		errno = ENOTSUP;
-		return STATUS_ERR;
 	}
 
 	db = &policy->p->p;

--------------060602080504080706040307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
