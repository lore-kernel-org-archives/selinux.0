Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5NMLJsA011589
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 18:21:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID09.oob.disa.mil (Postfix) with SMTP id 41Cqf51m1RzFlX5
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 22:21:17 +0000 (UTC)
Received: from USFB3CPA06_EEMSG_MP28.eemsg.mil (unknown [192.168.16.23])
 by USFBF3ID09.oob.disa.mil (Postfix) with ESMTP id 41Cqf46p66zFlWn
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 22:21:16 +0000 (UTC)
Date: Sat, 23 Jun 2018 23:21:07 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: pmoore@redhat.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Message-ID: <20180623222106.GE30522@ZenIV.linux.org.uk>
References: <152970230022.7734.15824980755229329454.stgit@chester>
 <20180623.105706.385733107379565893.davem@davemloft.net>
 <20180623212626.GD30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180623212626.GD30522@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] ipv6: avoid copy_from_user() via ipv6_renew_options_kern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Jun 23, 2018 at 10:26:27PM +0100, Al Viro wrote:
> On Sat, Jun 23, 2018 at 10:57:06AM +0900, David Miller wrote:
> > From: Paul Moore <pmoore@redhat.com>
> > Date: Fri, 22 Jun 2018 17:18:20 -0400
> > 
> > > -	const mm_segment_t old_fs = get_fs();
> > > -
> > > -	set_fs(KERNEL_DS);
> > > -	ret_val = ipv6_renew_options(sk, opt, newtype,
> > > -				     (struct ipv6_opt_hdr __user *)newopt,
> > > -				     newoptlen);
> > > -	set_fs(old_fs);
> > 
> > So is it really the case that the traditional construct:
> > 
> > 	set_fs(KERNEL_DS);
> > 	... copy_{from,to}_user(...);
> > 	set_fs(old_fs);
> > 
> > is no longer allowed?
> 
> s/no longer allowed/best avoided/, but IMO in this case the replacement is
> too ugly to live ;-/

BTW, I wonder if the life would be simpler with do_ipv6_setsockopt() doing
the copy-in and verifying ipv6_optlen(*hdr) <= newoptlen; that would've
simplified ipv6_renew_option{,s}() quite a bit and completely eliminated
ipv6_renew_options_kern()...

Incidentally, is copying the entire value in case newoptlen > ipv6_optlen(...)
the right thing?  After all, the next update in any of those options will
quietly lose everything past ipv6_optlen(...), wouldn't it?

IOW, how about the following (completely untested):

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
index 5bc2bf3733ab..4b6915eedfc3 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -1015,29 +1015,15 @@ ipv6_dup_options(struct sock *sk, struct ipv6_txoptions *opt)
 }
 EXPORT_SYMBOL_GPL(ipv6_dup_options);
 
-static int ipv6_renew_option(void *ohdr,
-			     struct ipv6_opt_hdr __user *newopt, int newoptlen,
-			     int inherit,
+static void ipv6_renew_option(struct ipv6_opt_hdr *opt,
 			     struct ipv6_opt_hdr **hdr,
 			     char **p)
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
+	if (opt) {
+		memcpy(*p, opt, ipv6_optlen(opt));
+		*hdr = (struct ipv6_opt_hdr *)*p;
+		*p += CMSG_ALIGN(ipv6_optlen(*hdr));
 	}
-	return 0;
 }
 
 /**
@@ -1063,13 +1049,11 @@ static int ipv6_renew_option(void *ohdr,
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
@@ -1082,8 +1066,8 @@ ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
 			tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst1opt));
 	}
 
-	if (newopt && newoptlen)
-		tot_len += CMSG_ALIGN(newoptlen);
+	if (newopt)
+		tot_len += CMSG_ALIGN(ipv6_optlen(newopt));
 
 	if (!tot_len)
 		return NULL;
@@ -1098,67 +1082,25 @@ ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
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
-
+	ipv6_renew_option(newtype == IPV6_HOPOPTS ? newopt :
+				opt ? opt->hopopt : NULL,
+			  &opt2->hopopt, &p);
+
+	ipv6_renew_option(newtype == IPV6_RTHDRDSTOPTS ? newopt :
+				opt ? opt->dst0opt : NULL,
+			&opt2->dst0opt, &p);
+	ipv6_renew_option(newtype == IPV6_RTHDR ? newopt :
+				opt ? (struct ipv6_opt_hdr *)opt->srcrt : NULL,
+			(struct ipv6_opt_hdr **)&opt2->srcrt, &p);
+	ipv6_renew_option(newtype == IPV6_DSTOPTS ? newopt :
+				opt ? opt->dst1opt : NULL,
+			&opt2->dst1opt, &p);
 	opt2->opt_nflen = (opt2->hopopt ? ipv6_optlen(opt2->hopopt) : 0) +
 			  (opt2->dst0opt ? ipv6_optlen(opt2->dst0opt) : 0) +
 			  (opt2->srcrt ? ipv6_optlen(opt2->srcrt) : 0);
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
index 4d780c7f0130..b69ba18e0138 100644
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
@@ -409,17 +415,23 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		else if (optlen < sizeof(struct ipv6_opt_hdr) ||
 			 optlen & 0x7 || optlen > 8 * 255)
 			goto e_inval;
-
-		/* hop-by-hop / destination options are privileged option */
-		retv = -EPERM;
-		if (optname != IPV6_RTHDR && !ns_capable(net->user_ns, CAP_NET_RAW))
-			break;
+		else {
+			new = kmemdup(optval, optlen, GFP_USER);
+			if (IS_ERR(new)) {
+				retv = PTR_ERR(new);
+				break;
+			}
+			if (unlikely(ipv6_optlen(new) > optlen)) {
+				kfree(new);
+				retv = -EINVAL;
+				break;
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
