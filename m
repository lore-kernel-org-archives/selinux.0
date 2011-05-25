From: Harry Ciao <qingtao.cao@windriver.com>
To: <sds@tycho.nsa.gov>, <jmorris@namei.org>, <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: [PATCH 1/1] Fix arguments when expanding user_datum_t.roles
Date: Wed, 25 May 2011 17:26:09 +0800
Message-ID: <1306315569-5432-2-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1306315569-5432-1-git-send-email-qingtao.cao@windriver.com>
References: <1306315569-5432-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When expanding user_datum_t.roles role_set_t, the policydb_t of
the out module should be passed rather than that of the base module!

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/expand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index da084ec..3308c3f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -977,7 +977,7 @@ static int user_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	ebitmap_init(&tmp_union);
 
 	/* get global roles for this user */
-	if (role_set_expand(&user->roles, &tmp_union, state->base, state->rolemap)) {
+	if (role_set_expand(&user->roles, &tmp_union, state->out, state->rolemap)) {
 		ERR(state->handle, "Out of memory!");
 		ebitmap_destroy(&tmp_union);
 		return -1;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
