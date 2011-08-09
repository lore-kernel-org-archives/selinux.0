From: <rongqing.li@windriver.com>
To: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>, <sds@tycho.nsa.gov>
Subject: [PATCH 6/6] Export the tcp sock's security context to proc.
Date: Tue, 9 Aug 2011 15:28:30 +0800
Message-ID: <1312874910-31010-7-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1312874910-31010-1-git-send-email-rongqing.li@windriver.com>
References: <1312874910-31010-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Roy.Li <rongqing.li@windriver.com>

Export the tcp sock's security context to proc, since it maybe
different from the sock's owner process security context.

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
---
 net/ipv4/tcp_ipv4.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 955b8e6..ddac912 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2479,12 +2479,13 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 {
 	struct tcp_iter_state *st;
 	int len;
+	struct sock *s = NULL;
 
 	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq, "%-*s\n", TMPSZ - 1,
 			   "  sl  local_address rem_address   st tx_queue "
 			   "rx_queue tr tm->when retrnsmt   uid  timeout "
-			   "inode");
+			   "inode seclabel");
 		goto out;
 	}
 	st = seq->private;
@@ -2493,15 +2494,20 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 	case TCP_SEQ_STATE_LISTENING:
 	case TCP_SEQ_STATE_ESTABLISHED:
 		get_tcp4_sock(v, seq, st->num, &len);
+		s = v;
 		break;
 	case TCP_SEQ_STATE_OPENREQ:
 		get_openreq4(st->syn_wait_sk, v, seq, st->num, st->uid, &len);
+		s = st->syn_wait_sk;
 		break;
 	case TCP_SEQ_STATE_TIME_WAIT:
 		get_timewait4_sock(v, seq, st->num, &len);
 		break;
 	}
-	seq_printf(seq, "%*s\n", TMPSZ - 1 - len, "");
+
+	len += sock_write_secctx(s, seq);
+	len = TMPSZ - 1 - len;
+	seq_printf(seq, "%*s\n", len > 0 ? len : 0, "");
 out:
 	return 0;
 }
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
