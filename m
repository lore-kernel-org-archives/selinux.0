Return-Path: <SRS0=JZpt=3E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C16C32771
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B32F2081E
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 16:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="AcQH44qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgAOQsI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:48:08 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:2829 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgAOQsH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jan 2020 11:48:07 -0500
X-EEMSG-check-017: 44816974|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,323,1574121600"; 
   d="scan'208";a="44816974"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2020 16:48:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579106886; x=1610642886;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Z+IlujCbNI+70UdqEgyL4sAAY+Bx4axRMvSjymtJrMc=;
  b=AcQH44qx+BmkK9PnSlciMvb03fk2onM/wL94KbQWrIpU5+a5gwZDjxVJ
   ZN1KVhIO5b4hsFf9L+E3vjbkOBxlU82baop9BlUTTuct9pC1P6rSWesho
   UseyHCEWBSCA5mgof4Y5my+Yuyh+99txTXLjXgq1tfF8XhGRbI1fi/5ch
   XxKtpgCv98rkuIhafSMtSH4EEa1eFj73HwiXLjq+Tc//Eg/IJkLbGcwY2
   mH0Hkt3UgbG1r27qiUX8hBjpnmGVWKU2lAU1V1Zp9r1oIbzbnKKIdM36S
   v2Q0CBfN2E+pPoX5jIAyqlEtYXuEbR65kCVb3MwUh+DIqY31L/9xB1g86
   g==;
X-IronPort-AV: E=Sophos;i="5.70,323,1574121600"; 
   d="scan'208";a="37819654"
IronPort-PHdr: =?us-ascii?q?9a23=3AfT7Lxh/+jFRNof9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1+4eIJqq85mqBkHD//Il1AaPAdyHraofwLuO++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMnYdvJKk9xx?=
 =?us-ascii?q?/VrnBVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBtIDvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFA7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2Mpth1xrSa3xscslI?=
 =?us-ascii?q?bJgJ8exE3B9SpjxIY1IcO3SU5matOjC5tfqjqaOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreLTmppmSN49zkQHxLLghltajAeU4Lg?=
 =?us-ascii?q?cOX2+b9f661LL/5k32XK9Gjvg3kqndqJzaJMIbqbClAwJNz4ou5BmyAy2m3d?=
 =?us-ascii?q?gFh3ULMl1IdAydg4T0I13OJer3Dfa7g1SiijdrwPXGM6X6AprQNXjOi6vhfL?=
 =?us-ascii?q?Zh5E5czwo/19Zf54lOBb0bL/LzXVHxuMTCDhAlKwy03/rnCNJl24IQR22PBK?=
 =?us-ascii?q?+ZML7TsVKT6eIuLeyMa5UUuDb5MfQl6PDvjWIjlVADYKapwIMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88DEWcNvgo+SvbmiF+FUT5TfXmyWbk86S89CI+9EYjMXIatgLuH3C?=
 =?us-ascii?q?e6ApJZfGRGBkqQHnfvcoWOQ+0MZz6KIs99jjwEUqCsRJM72hG1qgD7y6FqLv?=
 =?us-ascii?q?HI9S0Yr53jydZ15+nNmhEo7DB7E96S33uRQGFzm2MCXyU207xnoUxh1leD1r?=
 =?us-ascii?q?B1jOBCGtxI+fxIUh02NYXAwOx6Ed/yRwzBftOXR1a8WdimADcxTs4vzN8KeU?=
 =?us-ascii?q?pyB9KijhXb1SqwH7AVj6CLBIAz8q/E3XjxIsF9y2zc1KkglFkrWc1POnejhq?=
 =?us-ascii?q?Fh9gjfHYnJk1+Wl6yyb6QTwDbN9HufzWqJpExYVA9wUaPYXXEQf0fWtsr26V?=
 =?us-ascii?q?/fT7+0CLQnLgtAxdeHKqtNd9LpkFFGS+n4NdTAbGK+hX2wCQyLxrySdorqfX?=
 =?us-ascii?q?sS3CHHBEgDiQAT8m6MNRIiCSe5v2LeEDtuGEr0Y0zy9el+qXW7TlI7zgyRcU?=
 =?us-ascii?q?1h2KS6+gQPifyfVfwTxLQEtzklqzluG1a9xd3WAcKapwV9ZKVcfc894FBf2G?=
 =?us-ascii?q?LaqQNyIIegILxlhl4ZcAR6pF/h1xVtCoVHlMgqrW4qzA9oJaKfylNBeCuS3Y?=
 =?us-ascii?q?rsNb3PNmny4BevZrbO2l7A1taW9boP6PU+q1n6vwGmCFAi83N53NlRyHac54?=
 =?us-ascii?q?zGDA4VUZLvTEk77QN6qKvZYikg/YPbz2dgMa+qvTPY2dIpHPMvygy8cNdHLK?=
 =?us-ascii?q?OECAjyHtUCB8e0Newqn0OkbgoeM+BP8K44Jsamd/yB2K6xIulshi6pjWNC4N?=
 =?us-ascii?q?M17kXZyCd6SvPJl6QFyveXll+YWjH8kVaJvd/ykIFAIz4NAyyyxTWyV6BLYa?=
 =?us-ascii?q?gnRpoGEWejJYWMw9x6g5P8EypD+EWLG0IN2MjvfwGbKVP6w1sDhgwsvXW7lH?=
 =?us-ascii?q?7gnHRPmDYzo//ahXGfzg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DzAwAaQR9e/wHyM5BkDg4BAQEBAQcBAREBBAQBAYF7g?=
 =?us-ascii?q?X2BbAEgEiqED4kDhl0GgRIliW6RSQkBAQEBAQEBAQE3AQGEQAKCIzgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIw8BBUEFCwsYAgIjAwICRhEGD?=
 =?us-ascii?q?QYCAQGCYz+CVwUgpXN1gTKFSoNJgT6BDiiMMnmBB4ERJwwDgi8uPoQigzeCX?=
 =?us-ascii?q?gSNRYJMh1+XVIJCgkmTYQYbgkeIA5Akq20igVgrCAIYCCEPO4JsUBgNlgxZI?=
 =?us-ascii?q?wMwix2CQwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Jan 2020 16:48:04 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00FGl94F141602;
        Wed, 15 Jan 2020 11:47:17 -0500
Subject: Re: Perf Data on LSM in v5.3
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>
References: <CAOSEQ1poqrUQdRc+ZLNbEoPqgd4MMomeYmefjca_mj-2zxrdUA@mail.gmail.com>
 <7ebd42d8-5392-90f6-fc08-4364176cfbb6@schaufler-ca.com>
 <CAOSEQ1p0q4gxVwN3MJkP=xxn4GUVaKsaArtQpxNy5rv7vYvVVw@mail.gmail.com>
 <abd4dddb-8968-2655-3d80-ce446451b3de@canonical.com>
 <CAOSEQ1rBu+wRzgk_Jh2RsZpf8Lv1+WUi-Pte-EsBMphnEr4SsQ@mail.gmail.com>
 <e7cfc960-32fb-7712-b21c-37999cf29430@tycho.nsa.gov>
 <2a984c76-a499-53f6-68c5-5d3604094ba4@tycho.nsa.gov>
 <CAOSEQ1o3nhY-svtsFSSv+M=V+NchxmBbhY-FvqoTzJgMnZ1ydw@mail.gmail.com>
 <1479ac1a-b957-f907-b983-c0bcefd51457@tycho.nsa.gov>
 <CAOSEQ1qPCtdsaieuXtWDEBEZAyddvLTNn8VDAJ-JWKeAP5PYsA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <057dfcd9-a843-827b-4472-41cfa27009e4@tycho.nsa.gov>
Date:   Wed, 15 Jan 2020 11:48:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1qPCtdsaieuXtWDEBEZAyddvLTNn8VDAJ-JWKeAP5PYsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/15/20 10:56 AM, Wenhui Zhang wrote:
> 
> 
> On Wed, Jan 15, 2020 at 10:33 AM Stephen Smalley <sds@tycho.nsa.gov 
> <mailto:sds@tycho.nsa.gov>> wrote:
>     Could be bottleneck changes, could be the fact that your kernel config
>     changes aren't limited to CONFIG_SECURITY* (e.g. PTI introduces
>     non-trivial overheads), could be changes to LSM since that time (e.g.
>     stacking support, moving security_ calls out-of-line, more hooks, ...),
>     could be that running SELinux w/o policy is flooding the system logs
>     with warnings or other messages since it wasn't really designed to be
>     used that way past initialization.  Lots of options, can't tell without
>     more info on your details.
> 
<snip>
> 
> Yup, seems like there used to be 29 hooks back 20 years ago, and now we 
> have 214 hooks with more placement locations for each.
> I am still struggling with the white-list based stacking logic, please 
> correct me if my understanding is wrong.

I don't think that's entirely accurate, since I believe the benchmarking 
performed for that paper was done using the LSM kernel patch (which was 
still out-of-tree at the time) which had a larger set of hooks than just 
29.  The hooks were incrementally merged to mainline but that wasn't the 
basis for the benchmarks IIRC. It is true however that the set of hooks 
and their callers has grown over time.

> I thought black-list  (i.e. firewall alike) logic might be easier to 
> understand and reasoning about the performance.
> By adding an off-line policy conflict/shadowing/redundant checker (i.e. 
> FIREMAN alike) should solve the rest of the issue.

Not sure I follow, but blacklisting is not a good approach for enforcing 
MAC security goals.
