Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A4DC43461
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B51D20759
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 10:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgIHKqp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:46:45 -0400
Received: from correo.us.es ([193.147.175.20]:34122 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729645AbgIHKq1 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Sep 2020 06:46:27 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0BDEB191912
        for <selinux@vger.kernel.org>; Tue,  8 Sep 2020 12:46:25 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F271ADA78A
        for <selinux@vger.kernel.org>; Tue,  8 Sep 2020 12:46:24 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D7507DA852; Tue,  8 Sep 2020 12:46:24 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7AA62DA78C;
        Tue,  8 Sep 2020 12:46:22 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 08 Sep 2020 12:46:22 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 40AB14301DE1;
        Tue,  8 Sep 2020 12:46:22 +0200 (CEST)
Date:   Tue, 8 Sep 2020 12:46:21 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, netdev@vger.kernel.org
Subject: Re: [PATCH v20 17/23] LSM: security_secid_to_secctx in netlink
 netfilter
Message-ID: <20200908104621.GB4838@salvia>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-18-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826145247.10029-18-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 07:52:41AM -0700, Casey Schaufler wrote:
> Change netlink netfilter interfaces to use lsmcontext
> pointers, and remove scaffolding.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org
> ---
>  net/netfilter/nfnetlink_queue.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
[...]
>  static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
> @@ -401,8 +399,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	enum ip_conntrack_info ctinfo;
>  	struct nfnl_ct_hook *nfnl_ct;
>  	bool csum_verify;
> -	struct lsmcontext scaff; /* scaffolding */
> -	char *secdata = NULL;
> +	struct lsmcontext context = { };
>  	u32 seclen = 0;

While at it, please introduce reverse xmas tree in variable
definitions incrementally:

	struct lsmcontext context = { };
  	enum ip_conntrack_info ctinfo;
  	struct nfnl_ct_hook *nfnl_ct;
  	bool csum_verify;
 	u32 seclen = 0;

And Cc: netfilter-devel@vger.kernel.org for patches that update the
Netfilter codebase.

Thanks.
