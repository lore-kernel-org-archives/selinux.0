Return-Path: <SRS0=UzQU=QG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D124AC282D7
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 18:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92DC20870
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 18:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DqWHBn1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfA3SOB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:14:01 -0500
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:54734 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfA3SOB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jan 2019 13:14:01 -0500
X-EEMSG-check-017: 638731642|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,541,1539648000"; 
   d="scan'208";a="638731642"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jan 2019 18:13:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548872021; x=1580408021;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Kg2hlhudTvfcsUUeY8bpD0VtTF/P6CpRi9FFyJg5SR4=;
  b=DqWHBn1QHxfCnGgDSy9x6nVF+98F4jToCehPsN7k1NlOPTReZKC4tano
   fHVXrINuk+o6B5rvnhZAyfnC90i+vbA81k2+bTifBzxsPYHN4wxTRga/T
   x0idh1XENRPc8XyX6+rI+mCPzB4SCXVpg9ZpDIqMYP27c3nMoHBLR+XOS
   EByJW8YUrjz1LHQfWge+jPyCrT4MGhQPCo3X+2PsX9LtOdTlaWnxIj7Vy
   Hfahqqw/Xbb81Vvz2sKYQFR10DWdk3Hj7D+HgU0fQjPLI34OkRYRyOOx1
   Zv+IpqeDWHxSqoF8v09l+AgRCvW3gp6REssAP4sJGisRMZDm/cPw3Md6H
   g==;
X-IronPort-AV: E=Sophos;i="5.56,541,1539648000"; 
   d="scan'208";a="20026895"
IronPort-PHdr: =?us-ascii?q?9a23=3AOmFFsB+AuwjcW/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B31+8cTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMsPsTbAwRD?=
 =?us-ascii?q?+s8aFlRhH1gysDLjI17n3bhsl2galGohyuugZ/zpbJbo+LOvpwfqDTc90USm?=
 =?us-ascii?q?VOXMleSyNPD5igb4YMFecNIfpUoof/qlYIsBCwBROsBOTqyjJQm3H2wbM10/?=
 =?us-ascii?q?whEQ7Y2gwrAs8AsHHOo9XxMKcdT+C0x7TPwDXYcvxWwizw6JTIcx89ofGMWq?=
 =?us-ascii?q?h8cczKyUY1DQ/FgVKQqZL8Mj6Ty+8DsHCb4vJ9We+ghGMrsQF8riW1yssyhY?=
 =?us-ascii?q?TFmJgZxk3C+C5k2og6P8e4R1R+YdO8FZtQsDyVOJVuT8M5RmFopD46yrobuZ?=
 =?us-ascii?q?6nZCQKyIooxxrYa/Gfb4iH+AjjVOeMITdjnn5lZLK+iAqy8Uin0OH8UNW70E?=
 =?us-ascii?q?1WoSZfl9nMt3QN2wTS6siBVPR94l+s1SuA2g3c8O1JIV04mbDFJ5Mu3LI8jI?=
 =?us-ascii?q?cfvVzGHiDsmUX2iKGWdl8j+uit8+nneajppoSHOo9oigDxLqQumsulDeQ+KQ?=
 =?us-ascii?q?gBRXKX+eu71L395UH5WqlFjuUqkqnFt5DXPd4UprSnDA9Mz4Yj6g6/ACmg0N?=
 =?us-ascii?q?QfhnQHI1dFdwiGj4jtIV3BPPf4DfKniVS2jDhr3+zGPqHmApjVNXjMjrPhfb?=
 =?us-ascii?q?d7605Bxws+1s5f551KBbEbOv7zWVH+tMbeDhAnNwy42eHnCM9y1tBWZWXaI6?=
 =?us-ascii?q?afeJvTtVSI6/hnd+CWaZYIuS7wLf8N6PvnjHt/klgYK+3h5rYzaXalDrwyOE?=
 =?us-ascii?q?idYHzxkv8fHmoQ+AkzVurnjBuFSzEFNFioWKdp3S02EIKrC8/4Q4mphLGQlH?=
 =?us-ascii?q?OgEoZ+enFNClfKF2zhMYqDRaFfO2qpPsZ9n2lcBvCaQIg72ETr7lf3?=
X-IPAS-Result: =?us-ascii?q?A2BKAwCB6FFc/wHyM5BlHAEBAQQBAQcEAQGBZYFbKWdRM?=
 =?us-ascii?q?ieEA5RfBoE1iTSQVCwMAYRAAoMHIjgSAQMBAQEBAQECAWwcDII6KYJoAQUjD?=
 =?us-ascii?q?wEFUQsOCgICJgICVwYBDAgBAYJfPwGBdA2sQoEvhUOEcoELizUXeIEHgTiCa?=
 =?us-ascii?q?4gKglcCiVuHSVaQXgmHLop+BhiBa4U5iw+KGZMmIYFWKwgCGAghDzuCbAmCH?=
 =?us-ascii?q?heKHIQgIQMwgQUBAY8AAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Jan 2019 18:13:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0UIDdAX022278;
        Wed, 30 Jan 2019 13:13:40 -0500
Subject: Re: Why is bash calling ioctl?
To:     Ian Pilcher <arequipeno@gmail.com>,
        SELinux <selinux@vger.kernel.org>
References: <84f08014-17f6-f0a9-0f98-34d62ca84abf@gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <08f633ce-e130-fa4b-b241-fac2edfd1314@tycho.nsa.gov>
Date:   Wed, 30 Jan 2019 13:16:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <84f08014-17f6-f0a9-0f98-34d62ca84abf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/30/19 12:59 PM, Ian Pilcher wrote:
> This is not strictly an SELinux question, but I figure that someone may
> have run across this before and have some idea what's going on.
> 
>   type=AVC msg=audit(1548870149.222:8945): avc:  denied  { ioctl } for 
> pid=20752 comm="bash" path="/etc/pki/radiusd/certmonger-post.sh" 
> dev="dm-0" ino=8415894 ioctlcmd=5401 
> scontext=system_u:system_r:certmonger_t:s0 
> tcontext=unconfined_u:object_r:radiusd_cert_t:s0 tclass=file permissive=0
> 
> This occurs when certmonger runs:
> 
>    '/usr/bin/bash /etc/pki/radiusd/certmonger-post.sh'
> 
> Try as a might, I can't think of any reason why bash would be calling
> ioctl on a script file, so I'm not sure whether to dontaudit or allow
> this (as it seems to be a non-fatal error).
> 
> Anyone have any ideas?

(corrected list address to the new list location; please note for future 
postings)

ioctlcmd=5401 is TCGETS.  This is used by isatty() to probe whether a 
descriptor refers to a tty.  bash is checking whether the descriptor is 
a tty.  You can generally dontaudit harmlessly.


