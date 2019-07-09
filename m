Return-Path: <SRS0=OcM+=VG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8C4C73C53
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 16:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3046F21670
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 16:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="uG007aD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGIQXS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:23:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34697 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGIQXS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jul 2019 12:23:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so10363289plt.1
        for <selinux@vger.kernel.org>; Tue, 09 Jul 2019 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=HkoWtg3+2XTaihhdsMNcreTYV2cAjEr9DuG3PQom/00=;
        b=uG007aD2XHi8AYGVtR5ZtT6AvkrDdMso70i2MYzVGdfgxstJdVzNN6blo72WVlUzX0
         cogsnCOg/lhe4nEO+FoD8NXk3UdMbdVmFFZCQ/QC7+i8lByTieCporZYLRbl0Nd1w2/C
         6BWEDdwk2n13bnHqgpIUNd4UBAxtdsjzWuSZKCJpYY6w8bOfcLJZzs7COrsQA9B+iuO2
         qOtk8XkHargG9L4ESTllKu0UdcvkfACDlyMDxiq9l19jl6/BQqskGvZKaKst6X4KShpr
         4EHdwLZgEE17yAaTvI0bczvgaoLHcSH7SEjkEFdKtQkb+DUV40C1jDaCxxpcEXKGlLvL
         5xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=HkoWtg3+2XTaihhdsMNcreTYV2cAjEr9DuG3PQom/00=;
        b=Y2r//ubemN0FVL4nHbhSp8sdxmv03EZotueguiMI48yH6JD16Ovrpu6DD4eKdRlrhV
         XxnNe/EaflRlGyJQ7iXcAeNCDHPY0VZizoKpsu5OJzGNCd3YAK6gvN5BTkAYa41iAfI3
         WQ0q2VRKQ7qKgFa/BbylfAhq/pHuqcnmlsiMzqbb4zw2nD6Kg3D/BnNKe9Iav6tcpDTE
         cPVvMMMUsxJeQmeP3BMNOduHjrpfvkiy9F9P68ShhI75eAylfB6l2CYDSnh6VrQ5Nncr
         z6rSt8v53EuIagDB1f3fsydJs7to8zOhCp7cvTfb/2aDyRf4quWKFpJESUUYI7JiQSvx
         D4Iw==
X-Gm-Message-State: APjAAAUcFeKRcpDfBCW54TRMWvQan37X5/r19n5cDYjnX4jB3+3QnOOl
        weghD8R+rBWFza1ONvdhv50wIw==
X-Google-Smtp-Source: APXvYqxPVsH0B4sX4aoOMXTb/bJpSpmYHY/aTTZfGE9/0NZNSxWNOp9TOZ1abUHua2rHLwtHvWmuKw==
X-Received: by 2002:a17:902:a5c7:: with SMTP id t7mr33662980plq.288.1562689397856;
        Tue, 09 Jul 2019 09:23:17 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([100.96.59.204])
        by smtp.googlemail.com with ESMTPSA id w18sm27242499pfj.37.2019.07.09.09.23.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 09:23:17 -0700 (PDT)
To:     linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Miklos Szeredi <miklos@szeredi.hu>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        kernel-team@android.com
From:   Mark Salyzyn <salyzyn@android.com>
Subject: RFC: BUG: overlayfs getxattr recursion leaves a poison sid.
Message-ID: <b5c3bc4a-eb39-d994-7723-947a464383a2@android.com>
Date:   Tue, 9 Jul 2019 09:23:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For EACCES return for getxattr, sid appears to be expected updated in 
parent node. For some accesses purely cosmetic for correct avc logging, 
and depending on kernel vintage for others (older than 4.4) the lack of 
the corrected sid in the parent overlay inode poisons the security cache 
and results in false denials.

The avc denials would contain an (incorrect) unlabelled target 
references, we could fix this by copying up the sid to the parent inode. 
However the test (below) needs to refactored to the pleasure of the 
security, selinux and overlayfs maintainers. The security_socket_accept 
function is _close_, it will copy sid and class from the old socket to 
the new. Along those lines, we probably need to add a new 
security_copy_to_upper handler that takes the upper and lower dentries 
and ensures that the upper contains all the security information 
associated with the lower.

Prototype adjustment (tested in 3.18 to ToT)

int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char 
*name, { ssize_t res; const struct cred *old_cred; struct dentry 
*realdentry = ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry); 
old_cred = ovl_override_creds(dentry->d_sb); res = 
vfs_getxattr(realdentry, name, value, size); ovl_revert_creds(old_cred); 
+ if (res == -EACCES) { + selinux_copy_sid(dentry, realdentry); return 
res; }

. . .

+ void selinux_copy_sid(struct dentry *parent, struct dentry *child) + { 
+ struct inode *pinode, *cinode; + struct inode_security_struct *pisec, 
*cisec; + + if (!parent || !child) + return; + pinode = parent->d_inode; 
+ cinode = child->d_inode; + if (!pinode || !cinode) + return; + pisec = 
pinode->i_security; + cisec = cinode->i_security; + if (!pisec || 
!cisec) + return; + pisec->sid = cisec->sid; + } + 
EXPORT_SYMBOL_GPL(selinux_copy_sid);

Sincerely -- Mark Salyzyn

