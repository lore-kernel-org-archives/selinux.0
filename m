Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09097C4332F
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 21:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjKNV5e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 16:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjKNV5b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 16:57:31 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A0B114;
        Tue, 14 Nov 2023 13:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=pnFA1ftTCLqo/Al693oDHXbFuOCwAIyULahEa0sRMus=; b=PwRAaMjPAUBWnwGJIQ8enPcf0G
        oEW4MS0EVUs9ZI6b8hA0vKIqOJ/KKki3VQDer8oQwOG5s5+VlmizUFJwVuyVFTUJDBY9W0D/45eWE
        vyDGN028skNK0I/u6gXb/gyaZDCPJzSNCNVQyPLT7H0tgNwhl8Xhch41Qmp5jPDui4DsVzScD7VnU
        9ssAvwdZmkYYwFIx9ERsJIhV18CECcjz9uneZg59JQ8XBfqywcDBgEULBxD06boUDlcCwLU2w19O3
        dSRKuwHlaPysZJ0jJv2vDYC3yQkX8c9lmcypIDjttg0O8bYkUwKtBz/0WkUq+bU8Nk5v7Ykexvyk7
        YsxoVYeg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r31PQ-00FqeT-2n;
        Tue, 14 Nov 2023 21:57:24 +0000
Date:   Tue, 14 Nov 2023 21:57:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Christian Brauner <brauner@kernel.org>,
        selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
Message-ID: <20231114215724.GV1957730@ZenIV>
References: <20231016220835.GH800259@ZenIV>
 <CAHC9VhTzEiKixwpKuit0CBq3S5F-CX3bT1raWdK8UPuN3xS-Bw@mail.gmail.com>
 <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com>
 <20231114215341.GU1957730@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114215341.GU1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 14, 2023 at 09:53:41PM +0000, Al Viro wrote:
> On Tue, Nov 14, 2023 at 03:57:35PM -0500, Stephen Smalley wrote:
> > On Mon, Nov 13, 2023 at 11:19 AM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Mon, Oct 16, 2023 at 6:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > [
> > > > That thing sits in viro/vfs.git#work.selinuxfs; I have
> > > > lock_rename()-related followups in another branch, so a pull would be more
> > > > convenient for me than cherry-pick.  NOTE: testing and comments would
> > > > be very welcome - as it is, the patch is pretty much untested beyond
> > > > "it builds".
> > > > ]
> > >
> > > Hi Al,
> > >
> > > I will admit to glossing over the comment above when I merged this
> > > into the selinux/dev branch last night.  As it's been a few weeks, I'm
> > > not sure if the comment above still applies, but if it does let me
> > > know and I can yank/revert the patch in favor of a larger pull.  Let
> > > me know what you'd like to do.
> > 
> > Seeing this during testsuite runs:
> 
> Interesting...  i_nlink decrement hitting an inode already with zero
> nlink...
> 
> <pokes around>
> 
> Could you add
>         inc_nlink(sb->s_root->d_inode);
> in sel_make_swapover_dir() right before
>         inode_unlock(sb->s_root->d_inode);
> 
> and check if that fixes the problem?

See git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #for-selinux
