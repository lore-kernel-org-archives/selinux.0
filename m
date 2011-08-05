Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p758w9LJ013121
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2011 04:58:16 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p758wF6f018089
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2011 08:58:15 GMT
From: <rongqing.li@windriver.com>
To: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>
Subject: [PATCH 5/5] Export the tcp sock's security context to proc.
Date: Fri, 5 Aug 2011 16:58:06 +0800
Message-ID: <1312534686-4099-6-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1312534686-4099-1-git-send-email-rongqing.li@windriver.com>
References: <1312534686-4099-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Roy.Li <rongqing.li@windriver.com>

Export the tcp sock's security context to proc, since it maybe
different from the sock's owner process security context.

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
---
 net/ipv4/tcp_ipv4.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 955b8e6..98a85d6 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2478,13 +2478,16 @@ static void get_timewait4_sock(struct inet_timewait_sock *tw,
 static int tcp4_seq_show(struct seq_file *seq, void *v)
 {
 	struct tcp_iter_state *st;
-	int len;
+	int len, sclen;
+	struct sock *s = NULL;
 
 	if (v == SEQ_START_TOKEN) {
-		seq_printf(seq, "%-*s\n", TMPSZ - 1,
+		seq_printf(seq,
 			   "  sl  local_address rem_address   st tx_queue "
 			   "rx_queue tr tm->when retrnsmt   uid  timeout "
-			   "inode");
+			   "inode %n", &len);
+		seq_printf(seq, "%-*s\n", TMPSZ - len - 1,
+			   (selinux_is_enabled() ? "  scontext" : ""));
 		goto out;
 	}
 	st = seq->private;
@@ -2493,15 +2496,19 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
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
+	sock_write_secctx(s, seq, &sclen);
+	seq_printf(seq, "%*s\n", TMPSZ + sclen - 1 - len, "");
 out:
 	return 0;
 }
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
