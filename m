Return-Path: <SRS0=4X/7=3D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C8C33CB6
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 14:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B16B24680
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 14:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mJ3rLOys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgANOd2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:33:28 -0500
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:37806 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgANOd2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jan 2020 09:33:28 -0500
X-EEMSG-check-017: 65769128|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,433,1571702400"; 
   d="scan'208";a="65769128"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jan 2020 14:33:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579012400; x=1610548400;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HH+lFIzaphgIIcrPyGR6mS0ju04jrXzqWNe7LfdoiUg=;
  b=mJ3rLOysszU2+HDhhD3xtlzdDG7s1B9R56RZIBy1JIY47zUfkOVvH5ch
   DnOFjYvn+QiFy0nihjqmwtWILZdRsfRI2olUfsTrsr7nK9DqVq+2Z1Dnc
   XgDCxO9tc1VQgwbVuTg5T7r6oV6flpQ1WeJ/tQpxW9MmOFrSKB4mVNBfi
   fbl1Zld8/aqfs4L/Rq0v4WgPOl0pFzEop+iY3fpg2yooAMPXHVuPPK0IK
   Wh1W+6BAxG7Zx+A3S9E7KuZQJOU0Dde8cARm492LqF9nnRcpmFcux6gTL
   e5UVekeIPOwosP3YdMKPZbGgF3gmVirJsqJiJDMEPeNecnP1xyGbaecMj
   g==;
X-IronPort-AV: E=Sophos;i="5.69,433,1571702400"; 
   d="scan'208";a="37745736"
IronPort-PHdr: =?us-ascii?q?9a23=3ArORQfxZci8fxibUK57ZL/wP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps6/bB7h7PlgxGXEQZ/co6odzbaP7+a4ASdcvN7B6ClELMUXEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/Jas90A?=
 =?us-ascii?q?fFrmdHd+lZxW5jOFafkwrh6suq85Nv7ipdt+g9+8JcVKnxYrg1Q6FfADk6KW?=
 =?us-ascii?q?4++dfltQPETQuB53scVnsZnx9VCAXb7x/0Q4n8vDLiuuVyxCeVM8v2TaspWT?=
 =?us-ascii?q?u59KdkVAXoiCYcODEn9mzcl9F9g7haoBKloBx/3pLUbYSIP/dwYq/RYdUXTn?=
 =?us-ascii?q?dPUcZLUyxKH52yYY0BAeEcOepUtofwql8LoRa4GAKiBv7gyiVQi3Hrw6M63e?=
 =?us-ascii?q?QvHwLI0gMuEN0BsmjbotruOacOU+241rXEwSnNYv5U3zr29YjGcgomofGJRb?=
 =?us-ascii?q?9+bNbRxlc3FwPFkFqQr5HuMS6Q1usXt2ib6/RvVOKygGMgsAF+vyOvy9wwio?=
 =?us-ascii?q?jJmo0VylfE+T9/wIYuP9K0UkF7Ydm6EJZJsSyRKoV4QsQnQ25yuSY6zKULuZ?=
 =?us-ascii?q?2lcygQzpQo2RrfZ+aAc4iS7RLvTPyeITNihH17Yr2wmhaz/VK5xuHlT8W0y0?=
 =?us-ascii?q?hFoTZYktnWt3ANyxzS586aQfV+5keswSuD2g/c5+1eIU04iLDXJ4Auz7IujJ?=
 =?us-ascii?q?YfrELOFTLslkrslq+ZbEAk9/Ct6+Tgf7rpuIeRN5RxigHiKqQundG/AfggPg?=
 =?us-ascii?q?gOQWeb/eO82aX//ULjWrVKj+A2krLDvJDbI8QbqKm5AxRL3Yk/8Rq/Ezen38?=
 =?us-ascii?q?gYnXkANl5Ffg6Ij5P1NF3UJfD4DPO/j0ytkDdt2f/GIqXsDojCI3XMirvsfa?=
 =?us-ascii?q?tx51RCxAc809xT/Y9YBqkEIP3pW0/xsNLYDgU+Mwyx2+vnE8hy1pgFVGKTAq?=
 =?us-ascii?q?6WLKPSsViS6uIpOOmDfpUZuDn6K/g7//Lul2M2mUcBfam12psacGi4Ee57I0?=
 =?us-ascii?q?Wdenfsms0OEXoOvgYnSezqj1qCUSRNaHqoQ6084TQ7Apq8DYjfXoCtnKCB3C?=
 =?us-ascii?q?CjE51NeG9GDlGMEXH1d4SLQPoMdi2SLdF7kjAeVriuVZUh1Rewuw/+0bZnKf?=
 =?us-ascii?q?DU+iIAv5L5yNd1//HTlQ019TFsCMSd1maNT3pynmwSWzA5wrtyoVZjxVie0a?=
 =?us-ascii?q?h3meBYGcZP6PNOVwcwLYTcwPBiC9DuRgLBec+ER0umQtWhDzA+UNYxw9sVY0?=
 =?us-ascii?q?tmAdWtkA3M3yqwDL8JjbCEGJs08qfE1XjrO8l902rG1LUmj1Q+RstPNGumhr?=
 =?us-ascii?q?Nw9gTKHI7GjVmWl7uwdaQdwC7M9H6PzW+JvE5FTQ5wVbvKUGsBZkvZs9v5/F?=
 =?us-ascii?q?nOT7ywBrQ9NAtO18qCJrFNat3zglVMXO3jN8jGY2Kth2ewAg6FxrGJbIrtYW?=
 =?us-ascii?q?UdxiTdCFMfngAV53mGMBYxBia7r2LZFjxuGkrlY1nw/ulmtHO7Ukg0whmQb0?=
 =?us-ascii?q?1gy7W1+gQaheaBRPwLwr0LoCchpC91HFa7wd3WEMGNqBF9fKVdZ9M9/ElI1X?=
 =?us-ascii?q?jftwNjIpysNbxthlkbc1c/g0S7zxxqDq1YmNUu6XYtyxB/b6mf1QBvbTSdiK?=
 =?us-ascii?q?vsN6XXJ2+6xxWmb6rbyxmKy9qN0rse4/Q/7VP4tUemEVR0oCYv6MVcz3bJvs?=
 =?us-ascii?q?aCNwEVS5+kFx1m+g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2D3AABizh1e/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gRhVIBIqhA2JA4VlgQgGgTeJbo9igWcJAQEBAQEBAQEBLwgBAYRAA?=
 =?us-ascii?q?oIhNwYOAhABAQEEAQEBAQEFAwEBbIU3DII7KYJ7AQUjBBFBEAsYAgImAgJGE?=
 =?us-ascii?q?RMGAgEBgmM/AYJWJQ+raH8zhDQBgRSDVIE3BoEOKAGMMnmBB4E4D4JdPoF5g?=
 =?us-ascii?q?h0BEgGDL4JeBJcmRpdSgkKCSYRzjmsGG5ptLZcKlCsjZ3ErCAIYCCEPO4JsE?=
 =?us-ascii?q?z0YDYgNF4hkhV0jAzABAQqKY4IyAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Jan 2020 14:33:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00EEWSLx168723;
        Tue, 14 Jan 2020 09:32:33 -0500
Subject: Re: [RFC PATCH] selinux: implement move_mount hook
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com, dhowells@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        richard_c_haines@btinternet.com
References: <20200113161800.63865-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a5839718-8b75-8a8b-189b-bd19e4c85219@tycho.nsa.gov>
Date:   Tue, 14 Jan 2020 09:33:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113161800.63865-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/13/20 11:18 AM, Stephen Smalley wrote:
> commit 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
> introduced a new move_mount(2) system call and a corresponding new LSM
> security_move_mount hook but did not implement this hook for any existing
> LSM.  This creates a regression for SELinux with respect to consistent
> checking of mounts; the existing selinux_mount hook checks mounton
> permission to the mount point path.  Provide a SELinux hook
> implementation for move_mount that applies this same check for
> consistency.  We may wish to consider defining a new filesystem
> move_mount permission and/or a new dir(ectory) move_mount permission
> and checking it in this hook in the future.
> 
> Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

NB I cc'd lsm list on this patch just as a heads-up/reminder that this 
hook hasn't been implemented for any security modules AFAICT, not just 
SELinux.  I see that there was some discussion of this in the past with 
a trivial patch proposed by Tetsuo to just disable the syscall when 
TOMOYO or AppArmor is enabled, but no action seems to have been taken,
https://lore.kernel.org/linux-security-module/5802b8b1-f734-1670-f83b-465eda133936@i-love.sakura.ne.jp/
https://lore.kernel.org/linux-security-module/1565365478-6550-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/

The move_mount syscall does check may_mount() and hence requires 
CAP_SYS_ADMIN for the user namespace associated with the mount 
namespace, so both SELinux and AppArmor would at least restrict the use 
of this syscall to processes allowed CAP_SYS_ADMIN by policy, but TOMOYO 
doesn't implement the capable hook either so move_mount is entirely 
unrestricted by it at present.  Looks like Smack doesn't implement any 
mount checking so it doesn't care about move_mount (especially since it 
requires CAP_SYS_ADMIN already).

> ---
>   security/selinux/hooks.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0606e107fca3..244874b103ff 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2766,6 +2766,19 @@ static int selinux_mount(const char *dev_name,
>   		return path_has_perm(cred, path, FILE__MOUNTON);
>   }
>   
> +static int selinux_move_mount(const struct path *from_path,
> +			      const struct path *to_path)
> +{
> +	const struct cred *cred = current_cred();
> +
> +	/*
> +	 *  TBD: Check new FILESYSTEM__MOVE_MOUNT permission to
> +	 *  from_path->dentry->s_sb and/or new DIR__MOVE_MOUNT
> +	 *  permission to from_path?
> +	 */
> +	return path_has_perm(cred, to_path, FILE__MOUNTON);
> +}
> +
>   static int selinux_umount(struct vfsmount *mnt, int flags)
>   {
>   	const struct cred *cred = current_cred();
> @@ -6943,6 +6956,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>   	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
>   
> +	LSM_HOOK_INIT(move_mount, selinux_move_mount),
> +
>   	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
>   	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
>   
> 

