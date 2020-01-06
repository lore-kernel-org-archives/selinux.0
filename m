Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FEDC33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 20:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1D124677
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 20:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EB46CiH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgAFUsz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:48:55 -0500
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:38357 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFUsz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 15:48:55 -0500
X-EEMSG-check-017: 63114718|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="63114718"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jan 2020 20:48:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578343727; x=1609879727;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rrHoaE8Mh9lClZKBwZmj8FD+YTLi4TqwI+D2nvvMRBc=;
  b=EB46CiH1t5F6tjc1lbdtByDr0I0Esl2lLPDtWnzEvuc6SyDUn3cVnYKf
   bp2waA+qE23y/bfodrt+YIXRozUVSbaOq8jYUPG/9y9CuM1wrCZfeXVOi
   6tRMyzmTb6eHNMrn9vyryMuD6EA2v9JWFPv5UmXVNt69+LeMrNfSCoOK4
   6KNc/ANOC9yo1us+/SH33ahvAj9W5wKlciCG/jwCeenVbkjsbOqKM0P+j
   ilPhOxgIBLkOCOH+ucd6DtKPpEJyDQ1PkMbR4TR60o6bUlUF46Hgvic7u
   9EbrkLa6UYC6kKlS+RV3W7QBH1Q2aA577J5L/bY5T/rw+v0qMC0ksvzfz
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="31644627"
IronPort-PHdr: =?us-ascii?q?9a23=3ApxgZPhEZiiGd6Dr4CyClYp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pciybnLW6fgltlLVR4KTs6sC17ON9fq9ASdZvc7JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQWnYduJbs9xx?=
 =?us-ascii?q?TVrnBVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHAehCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbf5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSU0yqUetJ?=
 =?us-ascii?q?KmcyUHx44ryh7CZ/CdbYSF7QzvWPyMLTp+mXlrYqiwhwyo/kil0uD8U86030?=
 =?us-ascii?q?tUoSddidnMs2wN1wTU6siaVvtx5keh1iiL1wDU8uxEPVo7lbDaK5482b48jJ?=
 =?us-ascii?q?sTsULNHi/xg0X5krOZel84+umo9+vnYrLmqoWaN4BokQHxLr4imsm+AeQ8Kg?=
 =?us-ascii?q?QOXm6b9vqg1LD74EH0T7pHguc2n6XEqpzWO8sWqrCjDwNIyooj7gywDzai0N?=
 =?us-ascii?q?QWh3kHK1dFdQqcj4f0IFHDO+z4DPejjFSslzdn3fbGPqb7DZnXIXjDl6nhca?=
 =?us-ascii?q?5n60FA0Aoz0cxf55VMB7ABOv3zXEDxtNjZDh8kPA20xujqBdpm24MRXGKAGK?=
 =?us-ascii?q?6ZMKfIvVCU4eIvJvGGZJUJtzblN/gl+/nugGchmVAHYKmp2YAaaGiiEfR7J0?=
 =?us-ascii?q?WVeH/sgtAGEWcQoAUyVvDliFqHUTRLfXa9Q7o85i0nCIKhFYrMWJitj6ab3C?=
 =?us-ascii?q?e6BZ1bfXhGBUqWEXfpbIWEQ/MMZziOLcB/iDAEUqKhS4A53xG0qAD606ZnLv?=
 =?us-ascii?q?bT+iAArpLsytx15+zVlREv+j15FNqd026TQGFuhG8IRCE53Lp5oUNjzlePy6?=
 =?us-ascii?q?94g+ZXFdZL/fNGTh86NYLAz+x9E93yXgPBftGUSFepW9mmAi8+Tsg3w9AQZ0?=
 =?us-ascii?q?ZwAMuijh/d0CqwGbMVlKKEBIYy8q3C23j9PcF9y2zJ1KM5lVkpXtNPNXG6hq?=
 =?us-ascii?q?547wXTA4/Jk1iZlqmwc6Qc0yDA+WiYwGuBvUFXSglwUaDEXXwFekTWqtH5tQ?=
 =?us-ascii?q?v+SOqqCKk2Ow1OkpLKfrpDbNLtjEhWQay/ENvbamO13Wy3AEDMjouFcY6iXm?=
 =?us-ascii?q?IaxiiVXFANjgQ75X+bMU07ASC7riTVCzk4URrCeULnudF3snKgBhs51wiQbl?=
 =?us-ascii?q?ZJz7Ov+wUNgfWXRrUUxL1S/G86pjF1Gkut98zZBsDGpAd7eqhYJ9Qn7xMP0W?=
 =?us-ascii?q?Pfqhw4PZG6Ka1mrkARfh4xvE700RhzTIJanpsEtnQvmTFuJLqY3VUJTDaR2Z?=
 =?us-ascii?q?T9K/WDMWXp1Ay+YK7RnFfF2ZCZ/blZu6dwkEnqoAz8ThlqyH5gydQAliLHt5?=
 =?us-ascii?q?g=3D?=
X-IPAS-Result: =?us-ascii?q?A2DbAgAqnBNe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXyBf?=
 =?us-ascii?q?YFsASASKoQJiQOGZAEBBAaBN4lukUgJAQEBAQEBAQEBNwEBhEACgg04EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KQGCeQEBAQECASMEEUEQCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/glMFIKx4dX8zhU+DKIE9gQ4ojDN5gQeBOA+CXT6EEoNHgl4ElxZGl?=
 =?us-ascii?q?z2CQIJFk08GG5pbLY4mnGoigVgrCAIYCCEPgydQGA2bdiMDMIwkgkMBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Jan 2020 20:48:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 006Km9Y2100607;
        Mon, 6 Jan 2020 15:48:10 -0500
Subject: Re: [PATCH] selinuxfs: use scnprinft to get real length in
 sel_read_class
To:     liuyang34 <yangliuxm34@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liuyang34 <liuyang34@xiaomi.com>
References: <cover.1578274288.git.liuyang34@xiaomi.com>
 <ba3290e18f9867e110b77d058c3f8c7015bd868b.1578274288.git.liuyang34@xiaomi.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f6dab965-b248-41e0-4cc2-06e140174f68@tycho.nsa.gov>
Date:   Mon, 6 Jan 2020 15:49:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <ba3290e18f9867e110b77d058c3f8c7015bd868b.1578274288.git.liuyang34@xiaomi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/5/20 8:56 PM, liuyang34 wrote:
> as the return value of snprintf maybe over the size of TMPBUFLEN,
> use scnprintf to instead of it

Is there a reason you didn't make the same change to sel_read_perm()?

> 
> Signed-off-by: liuyang34 <liuyang34@xiaomi.com>
> ---
>   security/selinux/selinuxfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index ee94fa4..977c32d 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1672,7 +1672,7 @@ static ssize_t sel_read_class(struct file *file, char __user *buf,
>   {
>   	unsigned long ino = file_inode(file)->i_ino;
>   	char res[TMPBUFLEN];
> -	ssize_t len = snprintf(res, sizeof(res), "%d", sel_ino_to_class(ino));
> +	ssize_t len = scnprintf(res, sizeof(res), "%d", sel_ino_to_class(ino));
>   	return simple_read_from_buffer(buf, count, ppos, res, len);
>   }
>   
> 

