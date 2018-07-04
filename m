Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w64DwESZ005966
 for <selinux@tycho.nsa.gov>; Wed, 4 Jul 2018 09:58:14 -0400
From: Paul Moore <pmoore@redhat.com>
To: netdev@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Date: Wed, 04 Jul 2018 09:58:05 -0400
Message-ID: <153071268532.4174.13831205890855497876.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [RFC PATCH v3] ipv6: make ipv6_renew_options() interrupt/kernel safe
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

At present the ipv6_renew_options_kern() function ends up calling into
access_ok() which is problematic if done from inside an interrupt as
access_ok() calls WARN_ON_IN_IRQ() on some (all?) architectures
(x86-64 is affected).  Example warning/backtrace is shown below:

 WARNING: CPU: 1 PID: 3144 at lib/usercopy.c:11 _copy_from_user+0x85/0x90
 ...
 Call Trace:
  <IRQ>
  ipv6_renew_option+0xb2/0xf0
  ipv6_renew_options+0x26a/0x340
  ipv6_renew_options_kern+0x2c/0x40
  calipso_req_setattr+0x72/0xe0
  netlbl_req_setattr+0x126/0x1b0
  selinux_netlbl_inet_conn_request+0x80/0x100
  selinux_inet_conn_request+0x6d/0xb0
  security_inet_conn_request+0x32/0x50
  tcp_conn_request+0x35f/0xe00
  ? __lock_acquire+0x250/0x16c0
  ? selinux_socket_sock_rcv_skb+0x1ae/0x210
  ? tcp_rcv_state_process+0x289/0x106b
  tcp_rcv_state_process+0x289/0x106b
  ? tcp_v6_do_rcv+0x1a7/0x3c0
  tcp_v6_do_rcv+0x1a7/0x3c0
  tcp_v6_rcv+0xc82/0xcf0
  ip6_input_finish+0x10d/0x690
  ip6_input+0x45/0x1e0
  ? ip6_rcv_finish+0x1d0/0x1d0
  ipv6_rcv+0x32b/0x880
  ? ip6_make_skb+0x1e0/0x1e0
  __netif_receive_skb_core+0x6f2/0xdf0
  ? process_backlog+0x85/0x250
  ? process_backlog+0x85/0x250
  ? process_backlog+0xec/0x250
  process_backlog+0xec/0x250
  net_rx_action+0x153/0x480
  __do_softirq+0xd9/0x4f7
  do_softirq_own_stack+0x2a/0x40
  </IRQ>
  ...

While not present in the backtrace, ipv6_renew_option() ends up calling
access_ok() via the following chain:

  access_ok()
  _copy_from_user()
  copy_from_user()
  ipv6_renew_option()

The fix presented in this patch is to perform the userspace copy
earlier in the call chain such that it is only called when the option
data is actually coming from userspace; that place is
do_ipv6_setsockopt().  Not only does this solve the problem seen in
the backtrace above, it also allows us to simplify the code quite a
bit by removing ipv6_renew_options_kern() completely.  We also take
this opportunity to cleanup ipv6_renew_options()/ipv6_renew_option()
a small amount as well.

This patch is heavily based on a rough patch by Al Viro.  I've taken
his original patch, converted a kmemdup() call in do_ipv6_setsockopt()
to a memdup_user() call, made better use of the e_inval jump target in
the same function, and cleaned up the use ipv6_renew_option() by
ipv6_renew_options().

CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul Moore <paul@paul-moore.com>

--
v3:
- fix typo in ipv6_renew_option() spotted by David Miller
v2:
- handle opt == NULL properly in ipv6_renew_options()
---
 include/net/ipv6.h       |    9 ----
 net/ipv6/calipso.c       |    9 +---
 net/ipv6/exthdrs.c       |  111 ++++++++++++----------------------------------
 net/ipv6/ipv6_sockglue.c |   27 ++++++++---
 4 files changed, 53 insertions(+), 103 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 16475c269749..d02881e4ad1f 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -355,14 +355,7 @@ struct ipv6_txoptions *ipv6_dup_options(struct sock *sk,
 struct ipv6_txoptions *ipv6_renew_options(struct sock *sk,
 					  struct ipv6_txoptions *opt,
 					  int newtype,
-					  struct ipv6_opt_hdr __user *newopt,
-					  int newoptlen);
-struct ipv6_txoptions *
-ipv6_renew_options_kern(struct sock *sk,
-			struct ipv6_txoptions *opt,
-			int newtype,
-			struct ipv6_opt_hdr *newopt,
-			int newoptlen);
+					  struct ipv6_opt_hdr *newopt);
 struct ipv6_txoptions *ipv6_fixup_options(struct ipv6_txoptions *opt_space,
 					  struct ipv6_txoptions *opt);
 
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index 1323b9679cf7..1c0bb9fb76e6 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -799,8 +799,7 @@ static int calipso_opt_update(struct sock *sk, struct ipv6_opt_hdr *hop)
 {
 	struct ipv6_txoptions *old = txopt_get(inet6_sk(sk)), *txopts;
 
-	txopts = ipv6_renew_options_kern(sk, old, IPV6_HOPOPTS,
-					 hop, hop ? ipv6_optlen(hop) : 0);
+	txopts = ipv6_renew_options(sk, old, IPV6_HOPOPTS, hop);
 	txopt_put(old);
 	if (IS_ERR(txopts))
 		return PTR_ERR(txopts);
@@ -1222,8 +1221,7 @@ static int calipso_req_setattr(struct request_sock *req,
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
-	txopts = ipv6_renew_options_kern(sk, req_inet->ipv6_opt, IPV6_HOPOPTS,
-					 new, new ? ipv6_optlen(new) : 0);
+	txopts = ipv6_renew_options(sk, req_inet->ipv6_opt, IPV6_HOPOPTS, new);
 
 	kfree(new);
 
@@ -1260,8 +1258,7 @@ static void calipso_req_delattr(struct request_sock *req)
 	if (calipso_opt_del(req_inet->ipv6_opt->hopopt, &new))
 		return; /* Nothing to do */
 
-	txopts = ipv6_renew_options_kern(sk, req_inet->ipv6_opt, IPV6_HOPOPTS,
-					 new, new ? ipv6_optlen(new) : 0);
+	txopts = ipv6_renew_options(sk, req_inet->ipv6_opt, IPV6_HOPOPTS, new);
 
 	if (!IS_ERR(txopts)) {
 		txopts = xchg(&req_inet->ipv6_opt, txopts);
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 5bc2bf3733ab..20291c2036fc 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -1015,29 +1015,21 @@ ipv6_dup_options(struct sock *sk, struct ipv6_txoptions *opt)
 }
 EXPORT_SYMBOL_GPL(ipv6_dup_options);
 
-static int ipv6_renew_option(void *ohdr,
-			     struct ipv6_opt_hdr __user *newopt, int newoptlen,
-			     int inherit,
-			     struct ipv6_opt_hdr **hdr,
-			     char **p)
+static void ipv6_renew_option(int renewtype,
+			      struct ipv6_opt_hdr **dest,
+			      struct ipv6_opt_hdr *old,
+			      struct ipv6_opt_hdr *new,
+			      int newtype, char **p)
 {
-	if (inherit) {
-		if (ohdr) {
-			memcpy(*p, ohdr, ipv6_optlen((struct ipv6_opt_hdr *)ohdr));
-			*hdr = (struct ipv6_opt_hdr *)*p;
-			*p += CMSG_ALIGN(ipv6_optlen(*hdr));
-		}
-	} else {
-		if (newopt) {
-			if (copy_from_user(*p, newopt, newoptlen))
-				return -EFAULT;
-			*hdr = (struct ipv6_opt_hdr *)*p;
-			if (ipv6_optlen(*hdr) > newoptlen)
-				return -EINVAL;
-			*p += CMSG_ALIGN(newoptlen);
-		}
-	}
-	return 0;
+	struct ipv6_opt_hdr *src;
+
+	src = (renewtype == newtype ? new : old);
+	if (!src)
+		return;
+
+	memcpy(*p, src, ipv6_optlen(src));
+	*dest = (struct ipv6_opt_hdr *)*p;
+	*p += CMSG_ALIGN(ipv6_optlen(*dest));
 }
 
 /**
@@ -1063,13 +1055,11 @@ static int ipv6_renew_option(void *ohdr,
  */
 struct ipv6_txoptions *
 ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
-		   int newtype,
-		   struct ipv6_opt_hdr __user *newopt, int newoptlen)
+		   int newtype, struct ipv6_opt_hdr *newopt)
 {
 	int tot_len = 0;
 	char *p;
 	struct ipv6_txoptions *opt2;
-	int err;
 
 	if (opt) {
 		if (newtype != IPV6_HOPOPTS && opt->hopopt)
@@ -1082,8 +1072,8 @@ ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
 			tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst1opt));
 	}
 
-	if (newopt && newoptlen)
-		tot_len += CMSG_ALIGN(newoptlen);
+	if (newopt)
+		tot_len += CMSG_ALIGN(ipv6_optlen(newopt));
 
 	if (!tot_len)
 		return NULL;
@@ -1098,29 +1088,19 @@ ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
 	opt2->tot_len = tot_len;
 	p = (char *)(opt2 + 1);
 
-	err = ipv6_renew_option(opt ? opt->hopopt : NULL, newopt, newoptlen,
-				newtype != IPV6_HOPOPTS,
-				&opt2->hopopt, &p);
-	if (err)
-		goto out;
-
-	err = ipv6_renew_option(opt ? opt->dst0opt : NULL, newopt, newoptlen,
-				newtype != IPV6_RTHDRDSTOPTS,
-				&opt2->dst0opt, &p);
-	if (err)
-		goto out;
-
-	err = ipv6_renew_option(opt ? opt->srcrt : NULL, newopt, newoptlen,
-				newtype != IPV6_RTHDR,
-				(struct ipv6_opt_hdr **)&opt2->srcrt, &p);
-	if (err)
-		goto out;
-
-	err = ipv6_renew_option(opt ? opt->dst1opt : NULL, newopt, newoptlen,
-				newtype != IPV6_DSTOPTS,
-				&opt2->dst1opt, &p);
-	if (err)
-		goto out;
+	ipv6_renew_option(IPV6_HOPOPTS, &opt2->hopopt,
+			  (opt ? opt->hopopt : NULL),
+			  newopt, newtype, &p);
+	ipv6_renew_option(IPV6_RTHDRDSTOPTS, &opt2->dst0opt,
+			  (opt ? opt->dst0opt : NULL),
+			  newopt, newtype, &p);
+	ipv6_renew_option(IPV6_RTHDR,
+			  (struct ipv6_opt_hdr **)&opt2->srcrt,
+			  (opt ? (struct ipv6_opt_hdr *)opt->srcrt : NULL),
+			  newopt, newtype, &p);
+	ipv6_renew_option(IPV6_DSTOPTS, &opt2->dst1opt,
+			  (opt ? opt->dst1opt : NULL),
+			  newopt, newtype, &p);
 
 	opt2->opt_nflen = (opt2->hopopt ? ipv6_optlen(opt2->hopopt) : 0) +
 			  (opt2->dst0opt ? ipv6_optlen(opt2->dst0opt) : 0) +
@@ -1128,37 +1108,6 @@ ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
 	opt2->opt_flen = (opt2->dst1opt ? ipv6_optlen(opt2->dst1opt) : 0);
 
 	return opt2;
-out:
-	sock_kfree_s(sk, opt2, opt2->tot_len);
-	return ERR_PTR(err);
-}
-
-/**
- * ipv6_renew_options_kern - replace a specific ext hdr with a new one.
- *
- * @sk: sock from which to allocate memory
- * @opt: original options
- * @newtype: option type to replace in @opt
- * @newopt: new option of type @newtype to replace (kernel-mem)
- * @newoptlen: length of @newopt
- *
- * See ipv6_renew_options().  The difference is that @newopt is
- * kernel memory, rather than user memory.
- */
-struct ipv6_txoptions *
-ipv6_renew_options_kern(struct sock *sk, struct ipv6_txoptions *opt,
-			int newtype, struct ipv6_opt_hdr *newopt,
-			int newoptlen)
-{
-	struct ipv6_txoptions *ret_val;
-	const mm_segment_t old_fs = get_fs();
-
-	set_fs(KERNEL_DS);
-	ret_val = ipv6_renew_options(sk, opt, newtype,
-				     (struct ipv6_opt_hdr __user *)newopt,
-				     newoptlen);
-	set_fs(old_fs);
-	return ret_val;
 }
 
 struct ipv6_txoptions *ipv6_fixup_options(struct ipv6_txoptions *opt_space,
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4d780c7f0130..c95c3486d904 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -398,6 +398,12 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 	case IPV6_DSTOPTS:
 	{
 		struct ipv6_txoptions *opt;
+		struct ipv6_opt_hdr *new = NULL;
+
+		/* hop-by-hop / destination options are privileged option */
+		retv = -EPERM;
+		if (optname != IPV6_RTHDR && !ns_capable(net->user_ns, CAP_NET_RAW))
+			break;
 
 		/* remove any sticky options header with a zero option
 		 * length, per RFC3542.
@@ -409,17 +415,22 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		else if (optlen < sizeof(struct ipv6_opt_hdr) ||
 			 optlen & 0x7 || optlen > 8 * 255)
 			goto e_inval;
-
-		/* hop-by-hop / destination options are privileged option */
-		retv = -EPERM;
-		if (optname != IPV6_RTHDR && !ns_capable(net->user_ns, CAP_NET_RAW))
-			break;
+		else {
+			new = memdup_user(optval, optlen);
+			if (IS_ERR(new)) {
+				retv = PTR_ERR(new);
+				break;
+			}
+			if (unlikely(ipv6_optlen(new) > optlen)) {
+				kfree(new);
+				goto e_inval;
+			}
+		}
 
 		opt = rcu_dereference_protected(np->opt,
 						lockdep_sock_is_held(sk));
-		opt = ipv6_renew_options(sk, opt, optname,
-					 (struct ipv6_opt_hdr __user *)optval,
-					 optlen);
+		opt = ipv6_renew_options(sk, opt, optname, new);
+		kfree(new);
 		if (IS_ERR(opt)) {
 			retv = PTR_ERR(opt);
 			break;
