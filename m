Return-Path: <SRS0=kO0s=ZM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3243CC432C0
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 13:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0658C2251D
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 13:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574255589;
	bh=4QxDfTWhfYIfShUTFJUNL5e7kwntUpyWkEOl1iCfVwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AJkyJpMrNvmZJ9umvGoVFlpL99+xZaNRbocKq+zofcnkAwi2wG8bjgvyfIZlE603i
	 OyF08abVHGllC9hrmI951mJK3MEtWFvuCTJjOwzq4bk9P2quRZlcHBPauk41JtJFEu
	 ShvXLM8KWAWmwe/0WP5wOoz5irMm1LKVRVUHJ6WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfKTNNI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfKTNNI (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 20 Nov 2019 08:13:08 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D761022519;
        Wed, 20 Nov 2019 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574255587;
        bh=4QxDfTWhfYIfShUTFJUNL5e7kwntUpyWkEOl1iCfVwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBFRoJ/WF6PtVpkvzfpadq7Q21oE83R3/+0YLWppJ5Uprf8ZyM+FNehc8utKG01rp
         G330xEHF3fP5srBsNurWZd61K0s/9/s1MDQ93RQCq7zPwqpOLRdVBhs7n7dBvlzdVA
         d4ssQ5uDToxXvzRzpRF3zbQMlL/Z6DLsaduA8o2A=
Date:   Wed, 20 Nov 2019 13:13:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] selinux: Propagate RCU walk status from
 'security_inode_follow_link()'
Message-ID: <20191120131303.GB21500@willie-the-truck>
References: <20191119184057.14961-1-will@kernel.org>
 <20191119184057.14961-3-will@kernel.org>
 <d1b03e3f-2906-d022-3578-e443a5ebb1a0@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b03e3f-2906-d022-3578-e443a5ebb1a0@tycho.nsa.gov>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Stephen,

Thanks for the quick review.

On Tue, Nov 19, 2019 at 01:46:37PM -0500, Stephen Smalley wrote:
> On 11/19/19 1:40 PM, Will Deacon wrote:
> > 'selinux_inode_follow_link()' can be called as part of an RCU path walk,
> > and is passed a 'bool rcu' parameter to indicate whether or not it is
> > being called from within an RCU read-side critical section.
> > 
> > Unfortunately, this knowledge is not propagated further and, instead,
> > 'avc_has_perm()' unconditionally passes a flags argument of '0' to both
> > 'avc_has_perm_noaudit()' and 'avc_audit()' which may block.
> > 
> > Introduce 'avc_has_perm_flags()' which can be used safely from within an
> > RCU read-side critical section.
> 
> Please see e46e01eebbbcf2ff6d28ee7cae9f117e9d1572c8 ("selinux: stop passing
> MAY_NOT_BLOCK to the AVC upon follow_link").

Ha, not sure how I missed that -- my patch is almost a direct revert,
including the name 'avs_has_perm_flags()'! My only concern is that the
commit message for e46e01eebbbc asserts that the only use of MAY_NOT_BLOCK
is in slow_avc_audit(), but AVC_NONBLOCKING is used more widely than that.

For example:

	selinux_inode_follow_link()
	  -> avc_has_perm()
	    -> avc_has_perm_noaudit()
	      -> avc_denied()
	        -> avc_update_node()

where we return early if AVC_NONBLOCKING is set, except flags are always
zero on this path.

Will
