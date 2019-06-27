Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F55BC48BD9
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 17:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5930D20659
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 17:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJ3R96W/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfF0RRN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:17:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45983 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfF0RRM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jun 2019 13:17:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so1628984plb.12
        for <selinux@vger.kernel.org>; Thu, 27 Jun 2019 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mVaZRzKM3VBwvxYY5Ib+ui80ZfOWm0zMZvY1c7VWkn0=;
        b=SJ3R96W/TcpRceVoexzDz2zna/G6Rf4LA5OB1VH4nC3qckGsWCVLpJ3gZMxWIxU5jF
         QVuj9oMf6f3wQ2KVfQwjh8JIZCoq3N/mi0d07zezyYbzdrbMuhvmQZIJDnf3tkF+7mKO
         kqYW5C2yNT/Thp26fatblO4yIqXmRh/mNkw2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mVaZRzKM3VBwvxYY5Ib+ui80ZfOWm0zMZvY1c7VWkn0=;
        b=bJQt1n5f92Ltp/qICWjVYIOImgepdTsoFi8tK0233lgqgt3E/EWQcKAaF9ntCYsJq5
         RkNLU5CYpKvPJlVHK1ycjE2Nh2P4HQ4/p044wVhjNKg/nBAM5het8FhBlwbf6Ts6MJBT
         IKaAmHPp3W1zkyyQr6ityduMkaH/OD2Uj7kiXXjcVYuHjXWPa5lmwmLsuaq9O2TsteWK
         Unb70/5n/V7UphIX9norWo0s7iwxiTV9A1OxH9xOkPcMUJykpSxpuyGgMdaI54NM9FLi
         7bCla/uINn6JIA8PlVWhzMxz8UlGL3gl9yydx9H+uJEe0VjJeeV+ITzwbPArUw9uF5Ru
         zpMg==
X-Gm-Message-State: APjAAAWqmfTX0M4BnVfv0/AWGejUI/uwBCWJL5n2ZCetglZK3uWjN/yR
        cTanG9FRnUWToSU6I0dTMA3yKg==
X-Google-Smtp-Source: APXvYqzysYYuki5x4wSusuQfMUe+mMyxaN/ydqH7J+f6NK+3dWKW4TSjWh81wHfzSj1VqVZRy6qxaw==
X-Received: by 2002:a17:902:820c:: with SMTP id x12mr5973153pln.216.1561655832129;
        Thu, 27 Jun 2019 10:17:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b29sm4680585pfr.159.2019.06.27.10.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 10:17:11 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:17:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 17/23] LSM: Use lsmcontext in security_secid_to_secctx
Message-ID: <201906271007.4248A3AE@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-18-casey@schaufler-ca.com>
 <201906262051.59B064019F@keescook>
 <cacf9eda-7486-80d3-f47d-b0dbb6872091@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cacf9eda-7486-80d3-f47d-b0dbb6872091@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 27, 2019 at 09:29:25AM -0700, Casey Schaufler wrote:
> On 6/26/2019 8:53 PM, Kees Cook wrote:
> > On Wed, Jun 26, 2019 at 12:22:28PM -0700, Casey Schaufler wrote:
> >> Replace the (secctx,seclen) pointer pair with a single
> >> lsmcontext pointer to allow return of the LSM identifier
> >> along with the context and context length. This allows
> >> security_release_secctx() to know how to release the
> >> context. Callers have been modified to use or save the
> >> returned data from the new structure.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  drivers/android/binder.c                | 24 ++++++---------
> >>  include/linux/security.h                |  4 +--
> >>  include/net/scm.h                       |  9 ++----
> >>  kernel/audit.c                          | 29 +++++++-----------
> >>  kernel/auditsc.c                        | 31 +++++++------------
> >>  net/ipv4/ip_sockglue.c                  |  7 ++---
> >>  net/netfilter/nf_conntrack_netlink.c    | 14 +++++----
> >>  net/netfilter/nf_conntrack_standalone.c |  7 ++---
> >>  net/netfilter/nfnetlink_queue.c         |  5 +++-
> >>  net/netlabel/netlabel_unlabeled.c       | 40 ++++++++-----------------
> >>  net/netlabel/netlabel_user.c            |  7 ++---
> >>  security/security.c                     |  9 ++++--
> >>  12 files changed, 72 insertions(+), 114 deletions(-)
> >>
> >> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> >> index 89e574be34cc..5d417a7b9bb3 100644
> >> --- a/drivers/android/binder.c
> >> +++ b/drivers/android/binder.c
> >> @@ -2874,9 +2874,7 @@ static void binder_transaction(struct binder_proc *proc,
> >>  	binder_size_t last_fixup_min_off = 0;
> >>  	struct binder_context *context = proc->context;
> >>  	int t_debug_id = atomic_inc_return(&binder_last_id);
> >> -	char *secctx = NULL;
> >> -	u32 secctx_sz = 0;
> >> -	struct lsmcontext scaff; /* scaffolding */
> >> +	struct lsmcontext lsmctx;
> > As James found, this needs to be zero initialized:
> >
> > struct lsmcontext lsmctx = { };
> 
> Thanks! I'll incorporate this in v5. It's great to
> have y'all checking it out.

I looked through other removed NULL assignments, and I think I see some
other issues...

                binder_alloc_copy_to_buffer(&target_proc->alloc,
                                            t->buffer, buf_offset,
-                                           secctx, secctx_sz);
-               security_release_secctx(secctx, secctx_sz);
-               secctx = NULL;
+                                           lsmctx.context, lsmctx.len);
+               security_release_secctx(&lsmctx);

The new security_release_secctx() performs the zeroing if there is a
slot match... should it be unconditional? (And should the no-op version
also zero?)

@@ -2420,8 +2420,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct
svc_fh *fhp,
        __be32 status;
        int err;
        struct nfs4_acl *acl = NULL;
-       void *context = NULL;
-       int contextlen;
+       struct lsmcontext context;

This needs the same = { } to retain the same meaning.

And here:

@@ -1191,8 +1191,8 @@ static int audit_receive_msg(struct sk_buff *skb,
struct nlmsghdr *nlh)
        struct audit_buffer     *ab;
        u16                     msg_type = nlh->nlmsg_type;
        struct audit_sig_info   *sig_data;
-       char                    *ctx = NULL;
        u32                     len;
+       struct lsmcontext       context;

And here:

@@ -2069,24 +2070,23 @@ void audit_log_key(struct audit_buffer *ab, char
*key)
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
-       char *ctx = NULL;
-       unsigned len;
        int error;
-       u32 sid;
+       struct lsmblob le;
+       struct lsmcontext context;

and here:

 static int audit_log_pid_context(struct audit_context *context, pid_t
pid,
-                                kuid_t auid, kuid_t uid, unsigned int
                                 sessionid,
-                                u32 sid, char *comm)
+                                kuid_t auid, kuid_t uid,
+                                unsigned int sessionid,
+                                struct lsmblob *l, char *comm)
 {
        struct audit_buffer *ab;
-       char *ctx = NULL;
-       u32 len;
+       struct lsmcontext lsmctx;

Maybe here?

-               if (osid) {
-                       char *ctx = NULL;
-                       u32 len;
-                       if (security_secid_to_secctx(osid, &ctx, &len))
                        {
-                               audit_log_format(ab, " osid=%u", osid);
+               if (lsmblob_is_set(olsm)) {
+                       struct lsmcontext lsmcxt;
+                       if (security_secid_to_secctx(olsm, &lsmcxt))
                                *call_panic = 1;

and:

-       if (n->osid != 0) {
-               char *ctx = NULL;
-               u32 len;
+       if (lsmblob_is_set(&n->olsm)) {
+               struct lsmcontext lsmctx;
 

and:

@@ -395,7 +401,7 @@ nfqnl_build_packet_message(struct net *net, struct
nfqnl_instance *queue,
        enum ip_conntrack_info uninitialized_var(ctinfo);
        struct nfnl_ct_hook *nfnl_ct;
        bool csum_verify;
-       char *secdata = NULL;
+       struct lsmcontext context;

and:

@@ -387,8 +387,7 @@ int netlbl_unlhsh_add(struct net *net,
        struct net_device *dev;
        struct netlbl_unlhsh_iface *iface;
        struct audit_buffer *audit_buf = NULL;
-       char *secctx = NULL;
-       u32 secctx_len;
+       struct lsmcontext context;


Sorry I forgot to check those the first time through!

-- 
Kees Cook
