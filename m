Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E473C12002
	for <selinux@archiver.kernel.org>; Wed, 21 Jul 2021 18:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468B86121E
	for <selinux@archiver.kernel.org>; Wed, 21 Jul 2021 18:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbhGUSGA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 14:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhGUSF7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 14:05:59 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461F2C061575;
        Wed, 21 Jul 2021 11:46:35 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id v14so2561351qtc.8;
        Wed, 21 Jul 2021 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9Fx7ougZGeTzlLIFaE4m3/NC1uNdZbIB5MWQn6BdR2o=;
        b=onOXYBho5d+IhQQK+IaPKdfrhlUH+ZgJRLCgEAmi5Y7eIxE+ZkFhtczczmHCdMiCtG
         YSEqMuH2DRTzf2uwym2RL3VD/kawdFDS+jiv9Ia+IlQjp3YVf/PrBYoMMuRrjJUu3PLu
         7QmwkiSqILlfGRm7u+R8qW4DfFKtr5EJjUXDQ8Vp40/XpqCyTF8yZq3Y2g5KMVqPxaSa
         KfgUkRzlbXczzdD6e9Uo7GHpTJop8l//8Z0mgT4d/FEQABoyyR+pfkDlstRtJMSsW3U4
         ZnmVjb97L38MxuZ9LFootbQC2f2Jp4E2HdFxfupDDmlQZWTIHfYrtWHzyeO/aWwFIfnC
         t/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9Fx7ougZGeTzlLIFaE4m3/NC1uNdZbIB5MWQn6BdR2o=;
        b=kSoNUPDZ81r91lSycR7FSIUI1SNhZQXOpbdHcCj7ytlU0XEC4Y/eeVsm4KxhZiyUQq
         5+kdXW1yUOh/SJq35V9pv2Rd3pkhAkhBhW3U0OGOSFdBHkOlZwfSx4xjfwuLafH1ph6U
         NCjNryYlrF8vFI0HSM2AQcC7Tf1fAN8458MDQOA6fkJUssgpeAZZmPLXlGWmgqg6NOJC
         pbqKyP0842M1x9J/Hwk503AkjvE+o6lmLfVu8l8U+ayerpDyPTPXT2bMCNyoAL4O+BWy
         0UeyFbRlI0Z9+8m7weqcBLQLGBf8G09ESCquySwIIEeYwR/OI+n+x1RVHrJqpL+8kQjQ
         cdmg==
X-Gm-Message-State: AOAM530cj4C2kn4GRMuiLwxpwobLS1B67hv2dLyMDrHpWrwNm5HxqbuL
        9J55/jNOG2eCmB85tdj+BIaqBkcTl5N7KTev74afRuxIXwLlPA==
X-Google-Smtp-Source: ABdhPJw9+3ddZU5B0khl/a/3m91qnMovdU5wMmBkUn0dvu3CABrC9n0kkjSBseZ/QsrIb9ifVGBnEz81yomz9PMf09A=
X-Received: by 2002:ac8:6a06:: with SMTP id t6mr12996311qtr.378.1626893194212;
 Wed, 21 Jul 2021 11:46:34 -0700 (PDT)
MIME-Version: 1.0
From:   Sujithra P <sujithrap@gmail.com>
Date:   Wed, 21 Jul 2021 11:46:23 -0700
Message-ID: <CAP198X8TNTv1tqpO6Y7eyE2+iSwK9XHk0qRH6J-Z0Ww=a+53tA@mail.gmail.com>
Subject: AVC denied for docker while trying to set labels for tmpfs mounts
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi SELinux Experts,

The following issue is described in the below post as well.
https://github.com/containers/container-selinux/issues/141

Occasionally running into the following selinux denials for docker

type=AVC msg=audit(1626732057.636:4583): avc:  denied  { associate }
for  pid=57450 comm="dockerd" name="/" dev="tmpfs" ino=150014
scontext=system_u:object_r:container_file_t:s0:c263,c914
tcontext=system_u:object_r:lib_t:s0 tclass=filesystem permissive=0

type=AVC msg=audit(1626812823.170:9434): avc:  denied  { associate }
for  pid=20027 comm="dockerd" name="/" dev="tmpfs" ino=198147
scontext=system_u:object_r:container_file_t:s0:c578,c672
tcontext=system_u:object_r:locale_t:s0 tclass=filesystem permissive=0


 level=error msg="Handler for POST
/v1.40/containers/a3a875e7896384e3bff53b8317e91ed4301a13957f42187eb227f28e09bd877c/start
returned error: error setting label on mount source
'/var/lib/kubelet/pods/f7cee5b2-bcd9-4aa1-9d67-c75b677ba2a1/volumes/kubernetes.io~secret/secret':
failed to set file label on
/var/lib/kubelet/pods/f7cee5b2-bcd9-4aa1-9d67-c75b677ba2a1/volumes/kubernetes.io~secret/secret:
permission denied"


Docker is not able to set labels for these tmpfs mounts because they
end up having wrong labels when they are created (sometimes
"locale_t", sometimes "lib_t" which of course is not the
default/correct context for tmpfs fs).
Apparently semodule -R and deleting these tmps files or reboot of the
node fixes the problem.
Not sure what is causing the tmpfs mounts to get wrong labels in the
first place.

Everything seems to be fine to begin with, but as the system keeps
scheduling pods on the node, this behavior is observed sometimes (not
consistent always).


OS Details:

NAME="CentOS Linux"
VERSION="8 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="8"
PLATFORM_ID="platform:el8"
PRETTY_NAME="CentOS Linux 8 (Core)"

Docker Version:
Client: Docker Engine - Community
Version: 19.03.13
API version: 1.40
Go version: go1.13.15
Git commit: 4484c46d9d
Built: Wed Sep 16 17:02:36 2020
OS/Arch: linux/amd64
Experimental: false

Kubernetes Version*
v1.20.8-gke.1500


Any help on how to debug this issue  would be greatly appreciated.


Thanks
Sujithra.
