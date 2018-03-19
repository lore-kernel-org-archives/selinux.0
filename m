Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2JHXo4w017564
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 13:33:50 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Mon, 19 Mar 2018 17:33:36 +0000
Message-Id: <20180319173336.24730-1-richard_c_haines@btinternet.com>
Subject: [PATCH] selinux: Update SELinux SCTP documentation
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Update SELinux-sctp.rst "SCTP Peer Labeling" section to reflect
how the association permission is validated.

Reported-by: Dominick Grift <dac.override@gmail.com>
Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 Documentation/security/SELinux-sctp.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/security/SELinux-sctp.rst b/Documentation/security/SELinux-sctp.rst
index 2f66bf3..a332cb1 100644
--- a/Documentation/security/SELinux-sctp.rst
+++ b/Documentation/security/SELinux-sctp.rst
@@ -116,11 +116,12 @@ statement as shown in the following example::
 SCTP Peer Labeling
 ===================
 An SCTP socket will only have one peer label assigned to it. This will be
-assigned during the establishment of the first association. Once the peer
-label has been assigned, any new associations will have the ``association``
-permission validated by checking the socket peer sid against the received
-packets peer sid to determine whether the association should be allowed or
-denied.
+assigned during the establishment of the first association. Any further
+associations on this socket will have their packet peer label compared to
+the sockets peer label, and only if they are different will the
+``association`` permission be validated. This is validated by checking the
+socket peer sid against the received packets peer sid to determine whether
+the association should be allowed or denied.
 
 NOTES:
    1) If peer labeling is not enabled, then the peer context will always be
-- 
2.14.3
