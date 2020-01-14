Return-Path: <SRS0=4X/7=3D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DCBC33C9E
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB7724670
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 21:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ItfAOAyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgANVIG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:08:06 -0500
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:44393 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728882AbgANVIF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jan 2020 16:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579036084; bh=S1RuHVSSCTI+FYyksoDTYxnCy7uxatUJQO8nYEAdzV4=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=ItfAOAyc0fZK98UGctRIwjrfs+vvBbXduEaCu3gdi/DmtngWWFPQXa2Rm35y6AUaEeFC9ZBS2xOXAaBGPpNWY8DQFoKR7a982Wy8nOtekL9xvRM2zd/DySu8ZDTLeM6UZvoXwM7lm7qBNfxc3CraCxpiXgMwPvYinpdytdT0U3tu6Z0BjRU6TmT5UgVyLmiO+ivoIFsqgUWp4d2OlOTZwPXlcFupE/IUCG3ExfgKBbWbET6kdQEy+8tksA61Paz4a82GGw3Y9uGJ3Ob3Lx4n146ojzMcTmSuKRK/plcnsDCzR/Ux08tpuiyMnqyv8Ov0BGuflp6kwzt3LySWLOSmgQ==
X-YMail-OSG: P9Uk0iYVM1lOGCSC47rZJzLeIg2UAZDVYBphkfBY1ttWt5QRMXWCKaoqpXyaUMk
 q0uNth_qp.e0_9bBrZRDj5jNAaAGLp0zvEmvoC_RtK0jR6T9PrBoE2gtrbcVqbhRt0EE.OINQgFB
 8R5vxHHayTNzubKWmgPbWk_XUoeLYrHc60DNLZvOdZzQ4PRo3qQIkj_nOe7Exb.NmYE6aKdm1ypr
 23ilU_afRFVjaDisXLWgY5dcyQryU0Q0_8npoir.4m35cYSdi10CG97lnxdHJq3sEVColIGfbFIh
 jkcPYGI5eYD3Wa9Cg4DxKbaKRF_d4nukyUrkmM7KJG4QEHL9QMhrf4.Y7u5p4v8k2QIIeG9w3N9i
 f9MjU.JnHvYY4NaF_xVoO3qY.EYX31Mk07n2rpxVhfxlOv6Vi9ABK0qb6mhx6xLuM0OcDKnoUnm_
 Iis6iudVTFw072dSyLuvjbSIak02vzRqX92YK2PlTUNmeuZ8AIXzz2yf4w2mFR0AS3avdHm.F4GN
 YXRoyKCWvbO6E56BXiBPZP51mP1SklvAZZXvoM9egJYVEcK370IXzV6mjJZ_cKLIEKJx_.q8T28c
 pn9cDlv0h6COqxQGxButPekr3v5MnrfLgTVKyUmATNrYPyY82i9CHnmdecE77M.v72aKmJe4nwOb
 93jL1sQD4ddJ2PZMSLuLaut11IkphrXhfe11SNOEhNgUGYs0ydzIQkg9JV9ZfMzpxFoxTbT4YO73
 KrznOCbx.6LpS__qZmTsIm2olnIQkn82rJqpig_.MHRjiBKziwR_TNo4OiwUPgO9S5YTScbQzKor
 GplLjrRAUjZgITtrC32nn23PAp60qToqOuByM0Urzi91rWWVW19QwtlkBd0oIIbIhmjGWpHtpMS1
 UL4GYfOTfKdRmQrKxMGCzbO63.6jd3XMhUsV5nR0gMW.iVFB6Y85Yqi9OiaZsIjZiRjIfaEsAk8z
 SxoJ._XUC5kA2IJ3GgL3rS4YBarHiqRyljAmWvEAD0l36.9XcmrbZdhnHcuh.Tdfl5qKn129opuW
 dF4EbSANEslpQdQOjKmZLfPSiCoTg2QhSVwxsquuaMY1cDht4L_AUz12JBkB73uu2ttLpq1l7uVp
 PcbbNQ65DVCgJurUBblSAtWP87Nhl0VC00vH60k53oW4oRwDFn1VA8wP7quADc8uimZFy2t01xzR
 OQZp0noeoMWNjcHJVHYGtBdXzmj63tgxBvRcfAh5bwxKS2dMnCDcVzIy58s9byOjXyH2J4pRrfjM
 Nyz1A.PnJ6qgNjc4Am.WDY.ptzPu4JM4oFpNnEUFEGkC4dRPYwcsYeeUy9NLBNFCWpm.Wp38HzJK
 CZHhU3k4jXrDs3w7crZWdQSwY29G1uEn4yjDYitz47VBV57QZdYrU67vGZiKZP9qc.B.ES.3EBu5
 dF44GqKlPvN6b4tjIEJU8ljkt2wvMiEXbHJBVeLEpAAs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Tue, 14 Jan 2020 21:08:04 +0000
Received: by smtp410.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 77620eaf6d3f81bd3489aaf0512074c3;
          Tue, 14 Jan 2020 21:07:59 +0000 (UTC)
Subject: Re: Perf Data on LSM in v5.3
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>
References: <CAOSEQ1poqrUQdRc+ZLNbEoPqgd4MMomeYmefjca_mj-2zxrdUA@mail.gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <7ebd42d8-5392-90f6-fc08-4364176cfbb6@schaufler-ca.com>
Date:   Tue, 14 Jan 2020 13:07:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1poqrUQdRc+ZLNbEoPqgd4MMomeYmefjca_mj-2zxrdUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/14/2020 12:15 PM, Wenhui Zhang wrote:
> Hi, Casey:
>
> I just performed a performance check on 
> 1. v5.3 with DAC only, and 
> 2. v5.3 with DAC and MAC framework, an empty-policy enabled in sub-modules(e.g. selinux)
> It seems like the downgrade is quite obvious. (here the perf is described in range 0 - 1, 0 is 0% and 1 is 100%).
> I am using a typical laptop for test,  4 2750MHz CPU, with SSD and 8G memory.
> Hope this might raise the performance issue.

Thank you for doing this. Unfortunately, your graph is unreadable.
Could you provide some more detail about your results?

>
> The last paper mentioning about performance of LSM was about 20 years ago, where Chris was using a setup of 4 700MHz CPU, 128MB memory with Disk. 
>
> Due to the change of hardware, performance on filesystem changes a lot.
>
>
> sec1.png
>
> -- 
> V/R,
>  
> Wenhui Zhang
>  
> Email: wenhui@gwmail.gwu.edu <mailto:wenhui@gwmail.gwu.edu>
>            Telephone: 1-(703) 424 3193
>           
>  
>  
>  
>
>
