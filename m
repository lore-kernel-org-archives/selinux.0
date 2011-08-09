From: <rongqing.li@windriver.com>
To: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>, <sds@tycho.nsa.gov>
Subject: [PATCH 5/6] Export the unix sock's security context to proc.
Date: Tue, 9 Aug 2011 15:28:29 +0800
Message-ID: <1312874910-31010-6-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1312874910-31010-1-git-send-email-rongqing.li@windriver.com>
References: <1312874910-31010-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Roy.Li <rongqing.li@windriver.com>

Export the unix sock's security context to proc, since it maybe
different from the sock's owner process security context.

Output '-' on Path column if the addr of unix_sock is NULL, rather 
than nothing.

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
---
 net/unix/af_unix.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ec68e1c..9021f9b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2239,12 +2239,14 @@ static void unix_seq_stop(struct seq_file *seq, void *v)
 	spin_unlock(&unix_table_lock);
 }
 
+#define OFFSET_PATH_START	40
 static int unix_seq_show(struct seq_file *seq, void *v)
 {
+	int len, offset = OFFSET_PATH_START;
 
 	if (v == SEQ_START_TOKEN)
 		seq_puts(seq, "Num       RefCount Protocol Flags    Type St "
-			 "Inode Path\n");
+			 "Inode Path  SecLabel\n");
 	else {
 		struct sock *s = v;
 		struct unix_sock *u = unix_sk(s);
@@ -2261,9 +2263,9 @@ static int unix_seq_show(struct seq_file *seq, void *v)
 			(s->sk_state == TCP_ESTABLISHED ? SS_CONNECTING : SS_DISCONNECTING),
 			sock_i_ino(s));
 
+		seq_putc(seq, ' ');
 		if (u->addr) {
-			int i, len;
-			seq_putc(seq, ' ');
+			int i;
 
 			i = 0;
 			len = u->addr->len - sizeof(short);
@@ -2275,7 +2277,17 @@ static int unix_seq_show(struct seq_file *seq, void *v)
 			}
 			for ( ; i < len; i++)
 				seq_putc(seq, u->addr->name->sun_path[i]);
-		}
+		} else
+			seq_printf(seq, " %s%n", "-", &len);
+
+		if (offset > len)
+			offset -= (len + 1);
+		else
+			offset = 0;
+
+		seq_printf(seq, "%*s", offset, " ");
+		sock_write_secctx(s, seq);
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
