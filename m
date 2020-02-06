Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA5AC33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 17:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B0B214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 17:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mACO56M4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBFRU1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:20:27 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:60836 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgBFRU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 12:20:27 -0500
X-EEMSG-check-017: 55614711|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55614711"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 17:20:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581009623; x=1612545623;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DxWny464dCc7tXzLelvSHfB6p/0gy/ETPq8LLco+Ggg=;
  b=mACO56M4Z13pyLExa1iMpEmsuURqaiFyJ1y3QMC40ZQWV0q6wIo5j2iI
   zjJvWMkOlkK8A5Tb4rbKY+LpAxon01It7SY4oL10ByctgadkFolmsUmMn
   edWsKDeYiJ4rsPeaBZi1J/NwHBPDHzQ/lqUzwlZrP+RlNJW09+JFQbvDe
   g0dJvvNo2pLkvbnigRXeI2uxucIt50+EUC5IeD2Fx8AN0PwGtcLllujcD
   UTZLngXdgtdoGgRgm/OmkR4YQ2jyeHfpUt54VGD5kh4hI3OFd+gmxI6yb
   Fz6+Nylm0d9p1hmga21xEC2frN7CgRQGqTI8emumYwKmXmpNCsNrsKTxe
   A==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="32771859"
IronPort-PHdr: =?us-ascii?q?9a23=3AzXLgcRwIsNl2iJnXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uwRKvad9pjvdHbS+e9qxAeQG9mCt7QZ0KGH7uigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4tvJ6g+xh?=
 =?us-ascii?q?bNonZDZuBayX91KV6JkBvw+8m98IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sAvXnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwHIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/tWuaWJDd3nnNleLSniha98Eig1u38VtSv31?=
 =?us-ascii?q?pQsiVFldzMu3YQ3BLQ8siKUuZx80iu1DqV1w3f9/tILV47mKbFMZIt37g9nY?=
 =?us-ascii?q?cJv0vZBC/5gkD2gbeTdkUj5+en9fzqYq7jpp+AL490jRz+Mrg2lsy/H+s4Ng?=
 =?us-ascii?q?8OUnCH+eumzr3j/FD5QK5Qgv03lKnZvpfaJd8FqaGlGQNVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2UILElZdx6diojpOlXOLOj5Dfe5nVusjC9my+3JM7DuGJnALmXPnK3/cb?=
 =?us-ascii?q?ty9UJQ0hc/wcha551OC7EBJPzzWlX2tNzdFhI5KBG7w/38BdVh1oIRRWKPAq?=
 =?us-ascii?q?iDPKPUql+H/PgjI+aLZI8LoDr9MeQq5+byjX8lnl8QZbKp3Z4QaHCiAPtmJ1?=
 =?us-ascii?q?+WYXzxjdoaHmcKuQ0+TOPuiFKcSzJce3GyX6ck7DEhFI2mFZvDRpyqgLGZxC?=
 =?us-ascii?q?e0BIBWZmRdB1CUC3joaoGEV+4JaCKVJc9hiCILWaK9RI8m0BGkrBX6xKZ/Lu?=
 =?us-ascii?q?rI5i0Ysoru28Zt5+LJjxEy9Cd0At+F026XVWF0n3gIRycy3K9lvUNy1E2P0a?=
 =?us-ascii?q?9ig/xXDdZT/e9GUh8mNZ7AyOx3E9PyVRzfcdeSVFmmRdKmATIqQ90tw98OeU?=
 =?us-ascii?q?F9G9CjjhDe2iqmGbgVl6aEBJYs6KLTw2DxJ9phy3bBzKQulV8mQtdINW2gna?=
 =?us-ascii?q?Nw6Q7TB4nMk0WCmKamb6Mc3DTC9G2b12qBoFlYUBJsUaXCRX0QelfZrc7+5k?=
 =?us-ascii?q?PZVL+jEq4oMg1cxs6YLatKa8DmgU9aS/fkPdTUe3ixlHuoBRaU2rOMa5Lne3?=
 =?us-ascii?q?ka3CXbCEkIiQQT/WuaOgg9HSqhomTeDCBwGlLreU/j7e5+qHajRE8u0w6Kd1?=
 =?us-ascii?q?Fh16ay+hMNnvyTVfcT3rMCuCc8pDR5B0i9393IBNqavQZhf7tTYck74FhZ0W?=
 =?us-ascii?q?LVrQt9PoavL6p6nF4Rbxx3v1/y1xVwEohAlckqrHU3zAt9MK6Y001Odyme3Z?=
 =?us-ascii?q?/uPr3aMXfy/B+xZK7MwF3e08iZ+r0J6Psmr1XvpgapFlAt839/ydlaz2Oc5o?=
 =?us-ascii?q?nWDAoVSZ/xUVg49wJ8p77EZikx/p/U2mN2PqmxqTLNwdQpC/Y/yhanftdQLb?=
 =?us-ascii?q?mIGxP1E80fH8KuMvAlm0C1bhIYO+Bf7LI7P8Sgd/uA366rJuFgkSmpjWRA54?=
 =?us-ascii?q?B93UaM+DRmRuHU2JYFxqLQ4gzSbCvxklqn+uXwg41AbDceVj6kzC/+CYpYYK?=
 =?us-ascii?q?FacoEMBmOjZcaww4M6z4bkRnpw7Fe+AxYD38izdFyZaFm5lQBI3F4WulS/kD?=
 =?us-ascii?q?G51CRwmjok6K2F02iGwOnvbxEAPW1jT2l4ilLtPI3yiMoVGAChaRQukjOo40?=
 =?us-ascii?q?H/3Kcdo75wayHYSl1PZDPeJmduSKyxuvyJZMsLoI8vtzQRVPm3YnibTKLwp1?=
 =?us-ascii?q?0R1CanV3BTwDE9aiGCpJr0hVp5hXibIXI1q2DWPYl0xBHC9JnfSORX0z4uWi?=
 =?us-ascii?q?Z1k3/UC0K6Mt3v+s+b09/Av/q4WmbkSpBadAHiy4+asyq3o2ZtBE6Rhfe2z+?=
 =?us-ascii?q?b7HBA63Cmz7NxjUSHFvV6oeYXw/7irOuJgOE9zDRnz7NQsSdI2qZc5mJxFgS?=
 =?us-ascii?q?tSvZ6S53dS1D6oYNg=3D?=
X-IPAS-Result: =?us-ascii?q?A2DWAgCfSTxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVCESKoQViQOGZQEBAQaBEiWJcJB0A1QJAQEBAQEBAQEBKwwBAYRAAoJhO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYMBAQEBAQIBIwQRQQULCw4HAwICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCYz8BglYFIA+rY3V/M4VKg1eBOAaBDiqMPXmBB4E4DAOCX?=
 =?us-ascii?q?T6CZAKEdYI8IgSWXWFGl2eCRIJOhHyOdgYCGYJIiBCQM45iiGyUSCI3gSErC?=
 =?us-ascii?q?AIYCCEPgydQGA2SEIocVSMDMI5KAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2020 17:20:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016HJNJl163593;
        Thu, 6 Feb 2020 12:19:23 -0500
Subject: Re: [PATCH] security: selinux: allow per-file labeling for bpffs
To:     Steven Moreland <smoreland@google.com>, paul@paul-moore.com,
        eparis@parisplace.org, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     "Connor O'Brien" <connoro@google.com>
References: <20200206165527.211350-1-smoreland@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <91465612-2fb2-5985-ba45-d4d9fcf0f70c@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 12:21:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206165527.211350-1-smoreland@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/20 11:55 AM, Steven Moreland wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> Add support for genfscon per-file labeling of bpffs files. This allows
> for separate permissions for different pinned bpf objects, which may
> be completely unrelated to each other.

Do you want bpf fs to also support userspace labeling of files via 
setxattr()?  If so, you'll want to also add it to 
selinux_is_genfs_special_handling() as well.

The only caveat I would note here is that it appears that bpf fs 
supports rename, link, unlink, rmdir etc by userspace, which means that 
name-based labeling via genfscon isn't necessarily safe/stable.  See
https://github.com/SELinuxProject/selinux-kernel/issues/2

> Change-Id: I03ae28d3afea70acd6dc53ebf810b34b357b6eb5

Drop Change-Ids from patches submitted upstream please since they aren't 
meaningful outside of Android.

> Signed-off-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: Steven Moreland <smoreland@google.com>
> ---
>   security/selinux/hooks.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index de4887742d7c..4f9396e6ce8c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -872,6 +872,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>   	    !strcmp(sb->s_type->name, "sysfs") ||
>   	    !strcmp(sb->s_type->name, "pstore") ||
>   	    !strcmp(sb->s_type->name, "binder") ||
> +	    !strcmp(sb->s_type->name, "bpf") ||
>   	    !strcmp(sb->s_type->name, "cgroup") ||
>   	    !strcmp(sb->s_type->name, "cgroup2"))
>   		sbsec->flags |= SE_SBGENFS;
> 

