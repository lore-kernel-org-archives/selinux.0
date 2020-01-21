Return-Path: <SRS0=4+dM=3K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84557C2D0CE
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 19:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498F321835
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 19:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Wdwq99XH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgAUTj7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:39:59 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:32184 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgAUTj6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jan 2020 14:39:58 -0500
X-EEMSG-check-017: 46952568|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,347,1574121600"; 
   d="scan'208";a="46952568"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Jan 2020 19:39:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579635597; x=1611171597;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EHQxDod4fEgnVpmufMoZrg/y35yK3yxzncnNQTuOZFs=;
  b=Wdwq99XHNAvn0zD/Zm31PTYEPdh2HuI9afsNZYxqJ4aIegIIbx+wDrCb
   ZCypPtDPMeCyhg29XA1oDxYEFBuMBFe75PZ7A5wDj0UNpMc1l/Xxli13c
   AJDw9O6sdGyEf/eOLkyF/4mfSHgUxuDxqnwz9N5gFsh3ahkXaZzBmhvyh
   bR1RwUnWPR+HhOWQ1Z0XtnDMeRNLtyhuZQoQWh2wfQcito1UU9PItHcDX
   cpSBYLb6Rd8/OmqgpM3bwOXh6iqN1rDPyh2qRtw68BQgV/1dTNiWkbLw4
   mwDsfN49YKblIgqCVt7Y+YAzFOA1V/opNaNAEnYcRXK+RZyZlIAuU5Uf6
   w==;
X-IronPort-AV: E=Sophos;i="5.70,347,1574121600"; 
   d="scan'208";a="32169812"
IronPort-PHdr: =?us-ascii?q?9a23=3A/3nUDhSfVcVDlOGyW43BnCmKHNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYh2N2/xhgRfzUJnB7Loc0qyK6vymADxLuMzd+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTv3dFeOtayX52KV+cgh3w4tu88IN5/ylfpv4s+dRMXbnmc6g9ULdVECkoP2?=
 =?us-ascii?q?cp6cPxqBLNVxGP5nwSUmUXlhpHHQ3I5wzkU5nyryX3qPNz1DGVMsPqQ780Xy?=
 =?us-ascii?q?+i77pwRx/zlCgHLT85/3rJhcF2kalWvQiupx17w47TfYGVKP9zdb7TcN8GWW?=
 =?us-ascii?q?ZMWNtaWjdfCY2gcYQAE+sBPf5Zr4bjoVsOsQC+DhSoCO/21zNEmmP60ag83u?=
 =?us-ascii?q?svCwHG2BErEcwIvnrasd75ML4eXO6xwaXNyzjIcvFY1irn6IXQbx4vv/+MU7?=
 =?us-ascii?q?Jzf8Tfx0YgGAHKgUmfp4H+IzOY1P4Av3SH4+duV++ijXMspQFrojiow8chkp?=
 =?us-ascii?q?THhp4LxVDc9SV23oA1LsClRk5+e9GkFJ9QuD+aNoBrRc4iWHxnuD0hx70auZ?=
 =?us-ascii?q?+0YCgKyJM9yx7ZcPyIaZKE4h3kVOaPODp1gm9udry4hxa360egy+v8W9G30F?=
 =?us-ascii?q?lUtCpFlMfDtnQX2xzU8MiHRf1w9Vqi1zaXzw3f9+5JLE8umafbNpIt2KA8m5?=
 =?us-ascii?q?UNvUjZAyP7nlj9grWMeUU+4Oeo7vzqYrDhppCBKYB5khr+MqEymsynBuQ4Lx?=
 =?us-ascii?q?QOU3Cb+eui0L3j+lX0QKlQgf0sk6nZrYvaKd4apq6/DQ9V1Z0j5AijADu8zN?=
 =?us-ascii?q?QZnWUILFJCeB6diYjmJ0rOL+ziAfe6glSslC9nx/HAPrL/HpXANmXPnbjucL?=
 =?us-ascii?q?pn60NQ1RA/wc5Q6p5KEL0NPer/Wkrru9zZCh85PRa0w+HiCNhlzYMRRHmPD7?=
 =?us-ascii?q?SFMKLSrVCI5uUvL/OKZI8OojnxMfcl5/nwjXMhg18SYbGp3YcLaHC/BvlpOE?=
 =?us-ascii?q?SZYX7ogtsbDWgGpBA+TOvxh1KcSz5Te22yUrkz5jE+Eo2mDIPDSpqxj7yG2S?=
 =?us-ascii?q?exBodWaXxeClCQDXfocJ2JW+wSZyKWI89hlCEEVLe6Ro8/2hGhqhX6x6BkLu?=
 =?us-ascii?q?XK4C0Ys4zs1Nxv6+3UjxEy+m88M8PI7GCJS2B9mysyQDU7xrxk6Rh3y1OHl6?=
 =?us-ascii?q?M+mftSGMZP/NtGVw47MdjXyOksWP7oXQeURcuEUFarRJ2dBDg1St8gi4sVb1?=
 =?us-ascii?q?1VB8SpjheF2TGjRbASierYV9QP7qvA0i2pdI5GwHHc2fxk1gJ3Tw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CjAwAlUyde/wHyM5BlHQEBAQkBEQUFAYF7gX2BGFUgE?=
 =?us-ascii?q?iqEEokDhmgBAQEGgRIliW6PYoFnCQEBAQEBAQEBASsMAQGEQAKCNjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIU3DII7KQGCegEFIxVBEAsOCgICJgICVwYNBgIBAYJjP?=
 =?us-ascii?q?wGCViUPrx2BMoVKgzWBOAaBDiqMLnmBB4E4DAOCXT6EFgESAYMvgl4EllFhR?=
 =?us-ascii?q?pdagkOCSYR0jm4GG4JHmDCQJ4cYlDYiZ3ErCAIYCCEPO4I4ATNQGA2RCIVdI?=
 =?us-ascii?q?wMwi1uCMgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 21 Jan 2020 19:39:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00LJd5JY170925;
        Tue, 21 Jan 2020 14:39:05 -0500
Subject: Re: [PATCH] libselinux: update man pages for userspace policy
 enforcers
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     selinux@vger.kernel.org
References: <20200117144813.55896-1-sds@tycho.nsa.gov>
 <CAFftDdrWB6Aa6=O30KwCx5uoFCHC6kTSU0P6feoCYYPrn_iHgw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <623d3ecf-51d0-2480-b52d-6d01d2897bc5@tycho.nsa.gov>
Date:   Tue, 21 Jan 2020 14:40:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFftDdrWB6Aa6=O30KwCx5uoFCHC6kTSU0P6feoCYYPrn_iHgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/20 10:26 AM, William Roberts wrote:
> On Fri, Jan 17, 2020 at 8:47 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> Despite deprecating use of flask.h and av_permissions.h back in 2014,
>> the man pages for avc_has_perm(3) and security_compute_av(3) were not
>> updated to provide instructions on how to dynamically map class/permission
>> names nor to encourage use of selinux_check_access(3) instead of these
>> interfaces.  Also, while selinux_set_mapping(3) supports dynamic
>> class/perm mapping at initialization, it does not support changes to
>> the class/perm values at runtime upon a policy reload, and no
>> instructions were provided on how to set up a callback to support
>> this case.  Update the man pages accordingly.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks, this patch is now applied.  For future reference, if you reply 
with a full Acked-by: name <email> line, patchwork will automatically 
mark that the patch has received an Ack in the A/R/T tags field which 
makes it easy to track.  It doesn't recognize a bare Ack.

https://patchwork.kernel.org/project/selinux/list/
