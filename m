Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D0BC11F69
	for <selinux@archiver.kernel.org>; Wed, 30 Jun 2021 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A4D61D05
	for <selinux@archiver.kernel.org>; Wed, 30 Jun 2021 08:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhF3IKe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233288AbhF3IKb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jun 2021 04:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625040482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spXMVCuw6N13xLjcZGemYJM/fS6G+xh95O5x4vR27TA=;
        b=OWR0TFQKbwRRrRFQdmmtbq6QQrvoe53uEI+PzplIStXMHP1/mnI59qEQX0SAFdX1dXoJ76
        DLqMZ0IItq4d9RNkZusg2qMIKcF+FGYWprAoYJexTl4qA15v4WA0nt4hdIMoBCXDDd06rm
        FlV+l+r8Hn7YKQdvHX/VfaJQWqeRO2U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516--tkXIUTON1ynZs4YSgp2lw-1; Wed, 30 Jun 2021 04:08:00 -0400
X-MC-Unique: -tkXIUTON1ynZs4YSgp2lw-1
Received: by mail-wr1-f70.google.com with SMTP id p6-20020a5d45860000b02901258b6ae8a5so553145wrq.15
        for <selinux@vger.kernel.org>; Wed, 30 Jun 2021 01:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=spXMVCuw6N13xLjcZGemYJM/fS6G+xh95O5x4vR27TA=;
        b=cjlMfPCPrXjHzWyW7Jv5fH+eHc1qjYx0EKHGJIUDp5QJpKCI6OSm5dLL+fu2/qLaib
         lee0sUfUW+lOzB6Qr0PQ9vfBj/BvcyiypZWSg7u8k92QSJzS7HW1SnQz1xJYLsvcWvvz
         vBenIdvQUis15l/RL2PzjNs0+cmO1j+Z8AaeePAtbLUTyj0M3vZSHSY0eJTWFYoBW3QN
         t53P16Bmx+8RT62tnufUSw1qaf9uQcIUxfczDyJNLmE6kEGAk8jZlheUpXmjpmOwq502
         dHz8ydXhPgQRLuPyNy5HuOYV/nOvGu08JFQcC4oiw2oIL8WfmfS3CI44WiG/AoHOgRzS
         aZTA==
X-Gm-Message-State: AOAM530XCK/bNMzR0IkPBKKVeSNXebtHHr8fXKVbvI4uqvg+Y8SLcjtT
        Ha2o0Nlo9ulA08WKBViRWQdKJPQQXEZlUzkwG5X7sINhjrlga5KIkelrWn9/58fIyh2iOElDjKo
        Vh6NXK2DkBUJDdQBxcA==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id n10mr3045918wmq.11.1625040479519;
        Wed, 30 Jun 2021 01:07:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhZXi0exlmVWXNW1b1HA6azTiENG2juGHvNPkDsRCdeTCmLeynlOmWabasKRpCJAXel/C2Tw==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id n10mr3045884wmq.11.1625040479197;
        Wed, 30 Jun 2021 01:07:59 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id m7sm22064425wrv.35.2021.06.30.01.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 01:07:58 -0700 (PDT)
Date:   Wed, 30 Jun 2021 09:07:56 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Daniel Walsh <dwalsh@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <YNwmXOqT7LgbeVPn@work-vm>
References: <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
 <YNvvLIv16jY8mfP8@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNvvLIv16jY8mfP8@mit.edu>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* Theodore Ts'o (tytso@mit.edu) wrote:
> On Tue, Jun 29, 2021 at 04:28:24PM -0400, Daniel Walsh wrote:
> > All this conversation is great, and I look forward to a better solution, but
> > if we go back to the patch, it was to fix an issue where the kernel is
> > requiring CAP_SYS_ADMIN for writing user Xattrs on link files and other
> > special files.
> > 
> > The documented reason for this is to prevent the users from using XATTRS to
> > avoid quota.
> 
> Huh?  Where is it so documented?

man xattr(7):

       The  file permission bits of regular files and directories are
       interpreted differently from the file permission bits of special
       files and symbolic links.  For regular files and directories the
       file permission bits define ac‐ cess to the file's contents,
       while for device special files they define access to the device
       described by the special file.  The file permissions of symbolic
       links are not used in access checks. *** These differences would
       al‐ low users to consume filesystem resources in a way not
       controllable by disk quotas for group or world writable special
       files and directories.****

       ***For  this reason, user extended attributes are allowed only
       for regular files and directories ***, and access to user extended
       attributes is restricted to the owner and to users with appropriate
       capabilities for directories with the sticky bit set (see the
       chmod(1) manual page for an explanation of the sticky bit).

(***'s my addition)


Dave

>  How file systems store and account
> for space used by extended attributes is a file-system specific
> question, but presumably any way that xattr's on regular files are
> accounted could also be used for xattr's on special files.
> 
> Also, xattr's are limited to 32k, so it's not like users can evade
> _that_ much quota space, at least not without it being pretty painful.
> (Assuming that quota is even enabled, which most of the time, it
> isn't.)
> 
> 						- Ted
> 
> P.S.  I'll note that if ext4's ea_in_inode is enabled, for large
> xattr's, if you have 2 million files that all have the same 12k
> windows SID stored as an xattr, ext4 will store that xattr only once.
> Those two million files might be owned by different uids, so we made
> an explicit design choice not to worry about accounting for the quota
> for said 12k xattr value.  After all, if you can save the space and
> access cost of 2M * 12k if each file had to store its own copy of that
> xattr, perhaps not including it in the quota calculation isn't that
> bad.  :-)
> 
> We also don't account for the disk space used by symbolic links (since
> sometimes they can be stored in the inode as fast symlinks, and
> sometimes they might consume a data block).  But again, that's a file
> system specific implementation question.
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

