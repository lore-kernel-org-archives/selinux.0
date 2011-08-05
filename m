Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p758w9LF013121
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2011 04:58:13 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p758wC6f018078
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2011 08:58:12 GMT
From: <rongqing.li@windriver.com>
To: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>
Subject: [PATCH 3/5] Export the udp sock's security context to proc.
Date: Fri, 5 Aug 2011 16:58:04 +0800
Message-ID: <1312534686-4099-4-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1312534686-4099-1-git-send-email-rongqing.li@windriver.com>
References: <1312534686-4099-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Roy.Li <rongqing.li@windriver.com>

Export the udp sock's security context to proc, since it maybe
different from the sock's owner process security context.

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
---
 net/ipv4/udp.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 1b5a193..e64b858 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2089,6 +2089,7 @@ static void udp4_format_sock(struct sock *sp, struct seq_file *f,
 		int bucket, int *len)
 {
 	struct inet_sock *inet = inet_sk(sp);
+	int sclen;
 	__be32 dest = inet->inet_daddr;
 	__be32 src  = inet->inet_rcv_saddr;
 	__u16 destp	  = ntohs(inet->inet_dport);
@@ -2102,21 +2103,29 @@ static void udp4_format_sock(struct sock *sp, struct seq_file *f,
 		0, 0L, 0, sock_i_uid(sp), 0, sock_i_ino(sp),
 		atomic_read(&sp->sk_refcnt), sp,
 		atomic_read(&sp->sk_drops), len);
+
+	sock_write_secctx(sp, f, &sclen);
+	*len += sclen;
 }
 
 int udp4_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == SEQ_START_TOKEN)
-		seq_printf(seq, "%-127s\n",
+	int len;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_printf(seq,
 			   "  sl  local_address rem_address   st tx_queue "
 			   "rx_queue tr tm->when retrnsmt   uid  timeout "
-			   "inode ref pointer drops");
+			   "inode ref pointer drops%n",
+			   &len);
+		seq_printf(seq, "%-*s\n", 150 - len,
+			   (selinux_is_enabled() ? "  scontext" : ""));
+	}
 	else {
 		struct udp_iter_state *state = seq->private;
-		int len;
 
 		udp4_format_sock(v, seq, state->bucket, &len);
-		seq_printf(seq, "%*s\n", 127 - len, "");
+		seq_printf(seq, "%*s\n", 150 - len, "");
 	}
 	return 0;
 }
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
