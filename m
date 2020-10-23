Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA86C388F9
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 00:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC6724631
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 00:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="INwr97+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369274AbgJWArK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Oct 2020 20:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369263AbgJWArK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Oct 2020 20:47:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD6AC0613CF
        for <selinux@vger.kernel.org>; Thu, 22 Oct 2020 17:47:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ce10so5034732ejc.5
        for <selinux@vger.kernel.org>; Thu, 22 Oct 2020 17:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1fKv4uIFw00jGTFevCKZ2EUtvU5bvfHONMclCNXS0g=;
        b=INwr97+4ebmw4zMtRmFnFz7YRPoYX7r8pZ9kiBBrF1ljXHhvOlMeQd/QH5/KUevV4I
         yAZWPf1Hr0YD9NUIi4hptrBfwvXwj+cHBq+sSedcAFYkFeFsZSRfiRXrFDkMpSMUpUGG
         v0HIHqE07ynn+18J1ZCzEus/Qc+mvOlFnJL/PpJTz34QuTAGje4p+ewVRHaze3i0Zdu0
         +OPhRbDVzWUIFLF6+H76P/2o5HNE+2FjQwoRETq72MmNkvnAuxkpOvm1vCMfkpFDY9B3
         y3v6YEU4kHf7ZRdFavxufN3RQFNoGbny2PAPW39Vx4zo1kp+NCqSg1wVuBJUC12Yn5Tb
         mvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1fKv4uIFw00jGTFevCKZ2EUtvU5bvfHONMclCNXS0g=;
        b=i7O+Bx7u2PvbfGU+LIq9KAwp0NXRI7iLtDJjDcP0xdN1wum3fLZa9DH+zS55kX13bm
         +bAu94MdAWJ2lOwM2KDSxst2WVFR2Qx02dH5eAPKkxb1+z584toZOS6RO6TGCz1grtem
         QPf+H8xYSfRBACbKlMwyBrFuEjfYmQa9HKVHK8H3xJ3ncr88AqZBU5MPIo7zx74h2Z3u
         2mu6rRWvodbSV4kYQGIz1OubhYZVKGF320gJx1rdqgN+I8Z3hKQcuLKuCMCt2FEisc2T
         39TFcejof4qW05eVigDgxWoCjOTO0xEGdIIl9SO9y2UTC+6NOt+GXAOVsXd9d8T+WdRi
         FFtA==
X-Gm-Message-State: AOAM530SrqORQmZvH+AYhd76DaDSa8QO/mGWbsIktoogWwbmqlEf57FU
        DAOhuS0wKoO8ErbAjUxAviwJ+Ddb+4He+iI6QlxP
X-Google-Smtp-Source: ABdhPJyCbWQwG6rJ6tXOYTck4ENVi87u45X4HoUd/41upX3LNVKE6gy6QZaZ/OFp/yZvHeqMP9g78zkH2Y2z2MsE/uM=
X-Received: by 2002:a17:906:33c7:: with SMTP id w7mr4591813eja.398.1603414028542;
 Thu, 22 Oct 2020 17:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201020191732.4049987-1-salyzyn@android.com> <20201020191732.4049987-2-salyzyn@android.com>
 <CAHC9VhTZitGFRCnRgLJLNUnFEhM0kp7E_51No1aam3CRf-WCpg@mail.gmail.com> <ba6516a2-0d7a-3733-f974-943d296a1c15@android.com>
In-Reply-To: <ba6516a2-0d7a-3733-f974-943d296a1c15@android.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Oct 2020 20:46:57 -0400
Message-ID: <CAHC9VhRYf4gU=wmQ2o40zt9SSPHqRBst4So4P6SwwJ7KrXtvnw@mail.gmail.com>
Subject: Re: [PATCH v17 1/4] Add flags option to get xattr method paired to __vfs_getxattr
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        David Sterba <dsterba@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 21, 2020 at 8:07 AM Mark Salyzyn <salyzyn@android.com> wrote:
> On 10/20/20 6:17 PM, Paul Moore wrote:
> > On Tue, Oct 20, 2020 at 3:17 PM Mark Salyzyn <salyzyn@android.com> wrote:
> >> Add a flag option to get xattr method that could have a bit flag of
> >> XATTR_NOSECURITY passed to it.  XATTR_NOSECURITY is generally then
> >> set in the __vfs_getxattr path when called by security
> >> infrastructure.
> >>
> >> This handles the case of a union filesystem driver that is being
> >> requested by the security layer to report back the xattr data.
> >>
> >> For the use case where access is to be blocked by the security layer.
> >>
> >> The path then could be security(dentry) ->
> >> __vfs_getxattr(dentry...XATTR_NOSECURITY) ->
> >> handler->get(dentry...XATTR_NOSECURITY) ->
> >> __vfs_getxattr(lower_dentry...XATTR_NOSECURITY) ->
> >> lower_handler->get(lower_dentry...XATTR_NOSECURITY)
> >> which would report back through the chain data and success as
> >> expected, the logging security layer at the top would have the
> >> data to determine the access permissions and report back the target
> >> context that was blocked.
> >>
> >> Without the get handler flag, the path on a union filesystem would be
> >> the errant security(dentry) -> __vfs_getxattr(dentry) ->
> >> handler->get(dentry) -> vfs_getxattr(lower_dentry) -> nested ->
> >> security(lower_dentry, log off) -> lower_handler->get(lower_dentry)
> >> which would report back through the chain no data, and -EACCES.
> >>
> >> For selinux for both cases, this would translate to a correctly
> >> determined blocked access. In the first case with this change a correct avc
> >> log would be reported, in the second legacy case an incorrect avc log
> >> would be reported against an uninitialized u:object_r:unlabeled:s0
> >> context making the logs cosmetically useless for audit2allow.
> >>
> >> This patch series is inert and is the wide-spread addition of the
> >> flags option for xattr functions, and a replacement of __vfs_getxattr
> >> with __vfs_getxattr(...XATTR_NOSECURITY).
> >>
> >> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> >> Reviewed-by: Jan Kara <jack@suse.cz>
> >> Acked-by: Jan Kara <jack@suse.cz>
> >> Acked-by: Jeff Layton <jlayton@kernel.org>
> >> Acked-by: David Sterba <dsterba@suse.com>
> >> Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
> >> Acked-by: Mike Marshall <hubcap@omnibond.com>
> >> To: linux-fsdevel@vger.kernel.org
> >> To: linux-unionfs@vger.kernel.org
> >> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-security-module@vger.kernel.org
> >> Cc: kernel-team@android.com
> > ...
> >
> >> <snip>
> > [NOTE: added the SELinux list to the CC line]
>
>
> Thanks and <ooops>
>
> >
> > I'm looking at this patchset in earnest for the first time and I'm a
> > little uncertain about the need for the new XATTR_NOSECURITY flag;
> > perhaps you can help me understand it better.  Looking over this
> > patch, and quickly looking at the others in the series, it seems as
> > though XATTR_NOSECURITY is basically used whenever a filesystem has to
> > call back into the vfs layer (e.g. overlayfs, ecryptfs, etc).  Am I
> > understanding that correctly?  If that assumption is correct, I'm not
> > certain why the new XATTR_NOSECURITY flag is needed; why couldn't
> > _vfs_getxattr() be used by all of the callers that need to bypass
> > DAC/MAC with vfs_getxattr() continuing to perform the DAC/MAC checks?
> > If for some reason _vfs_getxattr() can't be used, would it make more
> > sense to create a new stripped/special getxattr function for use by
> > nested filesystems?  Based on the number of revisions to this
> > patchset, I'm sure it can't be that simple so please educate me :)
> >
> It is hard to please everyone :-}
>
> Yes, calling back through the vfs layer.
>
> I was told not to change or remove the __vfs_getxattr default behaviour,
> but use the flag to pass through the new behavior. Security concerns
> requiring the _key_ of the flag to be passed through rather than a
> blanket bypass. This was also the similar security reasoning not to have
> a special getxattr call.
>
> [TL;DR]
>
> history and details
>
> When it goes down through the layers again, and into the underlying
> filesystems, to get the getxattr, the xattributes are blocked, then the
> selinux _context_ will not be copied into the buffer leaving the caller
> looking at effectively u:r:unknown:s0. Well, they were blocked, so from
> the security standpoint that part was accurate, but the evaluation of
> the context is using the wrong rules and an (cosmetically) incorrect avc
> report. This also poisons the cache layers that may hold on to the
> context for future calls (+/- bugs) disturbing the future decisions (we
> saw that in 4.14 and earlier vintage kernels without this patch, later
> kernels appeared to clear up the cache bug).
>
> The XATTR_NOSECURITY is used in the overlayfs driver for a substantial
> majority of the calls for getxattr only if the data is private (ie: on
> the stack, not returned to the caller) as simplification. A _real_
> getxattr is performed when the data is returned to the caller. I expect
> that subtlety will get lost in the passage of time though.
>
> I had a global in_security flag set when selinux was requesting the
> xattrs to evaluate security context, denied as a security risk since
> someone could set the global flag. I had a separate special getxattr
> function in the earlier patches, denied for security issues as well, and
> others took issue with an additional confusing call site. I added the
> flag parameter, and that satisfied the security concerns because the
> value was only temporarily on the stack parameters and could not be
> attacked to bypass xattr security. This flag passed to __vfs_getxattr
> was also preferred from the security standpoint so that __vfs_getxattr
> got the _key_ to bypass the xattr security checks. There was a brief
> moment where the get_xattr and set_xattr calls shared a similar single
> argument that pointed to a common call structure, but th as requested by
> a few, but then denied once it was seen by stakeholders.

Thanks for the background!

-- 
paul moore
www.paul-moore.com
