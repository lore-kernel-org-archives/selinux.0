Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p758w9LG013121
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2011 04:58:15 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p758wE6f018083
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2011 08:58:14 GMT
From: <rongqing.li@windriver.com>
To: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>
Subject: [PATCH 4/5] Export the unix sock's security context to proc.
Date: Fri, 5 Aug 2011 16:58:05 +0800
Message-ID: <1312534686-4099-5-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1312534686-4099-1-git-send-email-rongqing.li@windriver.com>
References: <1312534686-4099-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Roy.Li <rongqing.li@windriver.com>

Export the unix sock's security context to proc, since it maybe
different from the sock's owner process security context.

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
---
 net/unix/af_unix.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ec68e1c..338fa0a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2239,12 +2239,15 @@ static void unix_seq_stop(struct seq_file *seq, void *v)
 	spin_unlock(&unix_table_lock);
 }
 
+#define OFFSET_PATH_START	40
 static int unix_seq_show(struct seq_file *seq, void *v)
 {
+	int seqlen, offset = OFFSET_PATH_START;
 
 	if (v == SEQ_START_TOKEN)
-		seq_puts(seq, "Num       RefCount Protocol Flags    Type St "
-			 "Inode Path\n");
+		seq_printf(seq, "Num       RefCount Protocol Flags    Type St "
+			 "Inode Path    %s",
+			 (selinux_is_enabled() ? "  scontext\n" : "\n"));
 	else {
 		struct sock *s = v;
 		struct unix_sock *u = unix_sk(s);
@@ -2275,7 +2278,15 @@ static int unix_seq_show(struct seq_file *seq, void *v)
 			}
 			for ( ; i < len; i++)
 				seq_putc(seq, u->addr->name->sun_path[i]);
+			if (offset > len)
+				offset -= (len + 1);
+			else
+				offset = 0;
 		}
+
+		seq_printf(seq, "%*c", offset, '\b');
+		sock_write_secctx(s, seq, &seqlen);
+
 		unix_state_unlock(s);
 		seq_putc(seq, '\n');
 	}
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
