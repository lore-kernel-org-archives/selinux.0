Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F2C4361B
	for <selinux@archiver.kernel.org>; Sun, 13 Dec 2020 16:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BBC23380
	for <selinux@archiver.kernel.org>; Sun, 13 Dec 2020 16:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404268AbgLMQay (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 13 Dec 2020 11:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgLMQau (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 13 Dec 2020 11:30:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581A3C0613CF;
        Sun, 13 Dec 2020 08:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QpGd12BxwDvvVIkKTTf0i1nFrqsXOgn1zGbzKOXzb2Q=; b=XOj70mehMbhoTypKf/VZXqTS3L
        BnV1AJHZeix0ufNXHmsJ88TKAN2s8i8NQdhrMauIH2AKGYkiuFGiMNJYWQpNgJ4pXNQSkKP/2aigw
        oyqLBwgFRospnqUdy+alblzoDGhQExV6n1ireTuZ7JMHE+ZwPGVn1BgizDA2EYHww+Dx1vYBRfltp
        DwluvTXNBRIL3yx2qD5geB1+iD3azYOZapI6gvtKscIn4w8LR1Gtrhq3H9UnknR7e6p/nA5NSybqR
        OD4l5r/iQLq4fvAEj4tMyt1e18sJRL4/UdUoWbj6KYXLjFlWMQJRI9nVPXWJKowzkUU5teo8I+QQp
        fkgqKW7A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koUFh-0004AT-3i; Sun, 13 Dec 2020 16:29:41 +0000
Date:   Sun, 13 Dec 2020 16:29:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
Message-ID: <20201213162941.GG2443@casper.infradead.org>
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
 <20201212205522.GF2443@casper.infradead.org>
 <877dpln5uf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dpln5uf.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Dec 13, 2020 at 08:22:32AM -0600, Eric W. Biederman wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
> >> -void pid_update_inode(struct task_struct *task, struct inode *inode)
> >> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
> >> +			       unsigned int flags)
> >
> > I'm really nitpicking here, but this function only _updates_ the inode
> > if flags says it should.  So I was thinking something like this
> > (compile tested only).
> >
> > I'd really appreocate feedback from someone like Casey or Stephen on
> > what they need for their security modules.
> 
> Just so we don't have security module questions confusing things
> can we please make this a 2 patch series?  With the first
> patch removing security_task_to_inode?
> 
> The justification for the removal is that all security_task_to_inode
> appears to care about is the file type bits in inode->i_mode.  Something
> that never changes.  Having this in a separate patch would make that
> logical change easier to verify.

I don't think that's right, which is why I keep asking Stephen & Casey
for their thoughts.  For example,

 * Sets the smack pointer in the inode security blob
 */
static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
{
        struct inode_smack *isp = smack_inode(inode);
        struct smack_known *skp = smk_of_task_struct(p);

        isp->smk_inode = skp;
        isp->smk_flags |= SMK_INODE_INSTANT;
}

That seems to do rather more than checking the file type bits.
