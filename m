Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB4MF2Wc017664
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2013 17:15:02 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB418DmI014584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2013 20:08:45 -0500
Subject: [PATCH selinux-testsuite] capable_net: check for ifconfig in
 different locations
To: selinux@tycho.nsa.gov, serge@hallyn.com
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 03 Dec 2013 18:02:41 -0500
Message-ID: <20131203230241.14494.8083.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Pardon my C-like Perl, but in current Fedora Rawhide releases we need
to check for ifconfig in /usr/bin and not just /sbin.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 tests/capable_net/test |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/capable_net/test b/tests/capable_net/test
index 378bf92..24261c3 100755
--- a/tests/capable_net/test
+++ b/tests/capable_net/test
@@ -8,11 +8,20 @@ BEGIN { plan tests => 5 }
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
+# Find a usable ifconfig
+if (-x "/sbin/ifconfig") {
+	$ifconfig = "/sbin/ifconfig";
+} elsif (-x "/usr/bin/ifconfig") {
+	$ifconfig = "/usr/bin/ifconfig";
+} else {
+	BAIL_OUT("can not find a copy of ifconfig");
+}
+
 #
 # Tests for the good domain.
 #
 # CAP_NET_ADMIN
-$result = system "runcon -t test_ncap_t -- /sbin/ifconfig lo -promisc 2>&1";
+$result = system "runcon -t test_ncap_t -- $ifconfig lo -promisc 2>&1";
 ok($result, 0); 
 
 # CAP_NET_BIND_SERVICE
@@ -30,7 +39,7 @@ ok($result, 0);
 #
 
 # CAP_NET_ADMIN
-$result = system "runcon -t test_resncap_t -- /sbin/ifconfig lo -promisc 2>&1";
+$result = system "runcon -t test_resncap_t -- $ifconfig lo -promisc 2>&1";
 ok($result); 
 
 # CAP_NET_BIND_SERVICE; included in can_network by fedora policy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
