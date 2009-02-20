Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1KLWxW3002798
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 16:32:59 -0500
Received: from g4t0017.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1KLTZsO013013
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 21:29:35 GMT
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id A156E380DE
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 21:32:58 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/2] cipso: Fix documentation comment
To: selinux@tycho.nsa.gov
Date: Fri, 20 Feb 2009 16:32:55 -0500
Message-ID: <20090220213255.17416.17126.stgit@flek.lan>
In-Reply-To: <20090220212900.17416.14061.stgit@flek.lan>
References: <20090220212900.17416.14061.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The CIPSO protocol engine incorrectly stated that the FIPS-188 specification
could be found in the kernel's Documentation directory.  This patch corrects
that by removing the comment and directing users to the FIPS-188 documented
hosted online.  For the sake of completeness I've also included a link to the
CIPSO draft specification on the NetLabel website.

Thanks to Randy Dunlap for spotting the error and letting me know.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 net/ipv4/cipso_ipv4.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 6bb2635..7bc9929 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -3,11 +3,16 @@
  *
  * This is an implementation of the CIPSO 2.2 protocol as specified in
  * draft-ietf-cipso-ipsecurity-01.txt with additional tag types as found in
- * FIPS-188, copies of both documents can be found in the Documentation
- * directory.  While CIPSO never became a full IETF RFC standard many vendors
+ * FIPS-188.  While CIPSO never became a full IETF RFC standard many vendors
  * have chosen to adopt the protocol and over the years it has become a
  * de-facto standard for labeled networking.
  *
+ * The CIPSO draft specification can be found in the kernel's Documentation
+ * directory as well as the following URL:
+ *   http://netlabel.sourceforge.net/files/draft-ietf-cipso-ipsecurity-01.txt
+ * The FIPS-188 specification can be found at the following URL:
+ *   http://www.itl.nist.gov/fipspubs/fip188.htm
+ *
  * Author: Paul Moore <paul.moore@hp.com>
  *
  */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
