From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/2] selinux: loosen DAC perms on reading policy
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Date: Wed, 15 Feb 2012 15:48:44 -0500
Message-ID: <20120215204844.5705.93195.stgit@paris.rdu.redhat.com>
In-Reply-To: <20120215204838.5705.61883.stgit@paris.rdu.redhat.com>
References: <20120215204838.5705.61883.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is no reason the DAC perms on reading the policy file need to be root
only.  There are selinux checks which should control this access.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/selinuxfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 91e29cf..9666f7b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1829,7 +1829,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
-		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUSR},
+		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
