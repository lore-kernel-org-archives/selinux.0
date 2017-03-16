Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2GMRNpT011174
 for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2017 18:27:23 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so25160723pfx.2
 for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2017 15:27:19 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
 David Howells <dhowells@redhat.com>,
 Grant Grundler <grundler@chromium.org>,
 Michael Davidson <md@google.com>, Greg Hackmann <ghackmann@google.com>,
 Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] selinux: Remove unnecessary check of array base in
 selinux_set_mapping()
Date: Thu, 16 Mar 2017 15:26:52 -0700
Message-Id: <20170316222652.125702-1-mka@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

'perms' will never be NULL since it isn't a plain pointer but an array
of u32 values.

This fixes the following warning when building with clang:

security/selinux/ss/services.c:158:16: error: address of array
'p_in->perms' will always evaluate to 'true'
[-Werror,-Wpointer-bool-conversion]
                while (p_in->perms && p_in->perms[k]) {

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 security/selinux/ss/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 082b20c78363..2f20b5f974f4 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -155,7 +155,7 @@ static int selinux_set_mapping(struct policydb *pol,
 		}
 
 		k = 0;
-		while (p_in->perms && p_in->perms[k]) {
+		while (p_in->perms[k]) {
 			/* An empty permission string skips ahead */
 			if (!*p_in->perms[k]) {
 				k++;
-- 
2.12.0.367.g23dc2f6d3c-goog
