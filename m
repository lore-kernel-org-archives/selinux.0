Message-ID: <1345829597.21071.25.camel@moss-pluto.epoch.ncsc.mil>
Subject: [PATCH] libselinux: Only call regfree if regcomp was previously
 called on the regex
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>
Date: Fri, 24 Aug 2012 13:33:17 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Only call regfree if regcomp was previously called on the regex.

We discovered this bug in SE Android when bionic switched to the current
NetBSD regex implementation, which triggers an assertion on an attempt
to call regfree() on a regex that was not initialized via regcomp().
Apparently the prior bionic regex implementation and the glibc one are
more forgiving, but this seems to be a legitimate bug in libselinux that
should be fixed in general.

---
 libselinux/src/label_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 7bc46cc..8bf9bc4 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -575,7 +575,8 @@ static void closef(struct selabel_handle *rec)
 		free(spec->type_str);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
-		regfree(&spec->regex);
+		if (spec->regcomp)
+			regfree(&spec->regex);
 	}
 
 	for (i = 0; i < (unsigned int)data->num_stems; i++) {
-- 
1.7.11.2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
