Return-Path: <SRS0=79IL=5O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DADCC43331
	for <selinux@archiver.kernel.org>; Sun, 29 Mar 2020 09:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10330206CC
	for <selinux@archiver.kernel.org>; Sun, 29 Mar 2020 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgC2J1i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:27:38 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:51920 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgC2J1i (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sun, 29 Mar 2020 05:27:38 -0400
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 92C821320611;
        Sun, 29 Mar 2020 11:27:36 +0200 (CEST)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: mount selinuxfs nodev,noexec,nosuid
References: <f4e6ddb4-66ac-45d1-04a6-67bfd9fd225e@gmail.com>
Date:   Sun, 29 Mar 2020 11:27:35 +0200
In-Reply-To: <f4e6ddb4-66ac-45d1-04a6-67bfd9fd225e@gmail.com> (Topi
        Miettinen's message of "Sun, 29 Mar 2020 00:09:05 +0200")
Message-ID: <ypjla73zwlx4.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> writes:

> Mount selinuxfs with mount flags nodev,noexec and nosuid. It's not
> likely that this has any effect, but it's visually more pleasing.

will nodev interfere with this?

  File: /sys/fs/selinux/null
  Size: 0               Blocks: 0          IO Block: 4096   character special file
Device: 15h/21d Inode: 23          Links: 1     Device type: 1,3
Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    0/    root)
Context: sys.id:sys.role:null.isid:s0
Access: 2020-03-28 13:04:05.578999988 +0100
Modify: 2020-03-28 13:04:05.578999988 +0100
Change: 2020-03-28 13:04:05.578999988 +0100
 Birth: -

/sys/fs/selinux/null: character special (1/3)

>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  libselinux/src/load_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index fa1a3bf1..3e4020a9 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -279,7 +279,7 @@ int selinux_init_load_policy(int *enforce)
>         const char *mntpoint = NULL;
>         /* First make sure /sys is mounted */
>         if (mount("sysfs", "/sys", "sysfs", 0, 0) == 0 || errno == EBUSY) {
> -               if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, 0, 0) == 0
> || errno == EBUSY) {
> +               if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, MS_NODEV |
> MS_NOEXEC | MS_NOSUID, 0) == 0 || errno == EBUSY) {
>                         mntpoint = SELINUXMNT;
>                 } else {
>                         /* check old mountpoint */

-- 
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
