Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2C3C04EB8
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 17:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003602145D
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 17:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZQtwbqgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003602145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbeLAFE4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:04:56 -0500
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:45132
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbeLAFE4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Dec 2018 00:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543600489; bh=EKFIxx1OGurdZ64qxIbo8nmWMLjhHV1ussafrqpr+bk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ZQtwbqgIReoZayWrycZ/T5wMwom5NAlTIs8nqYrawd6TBtIiIzhhxWYI0OlqvgXn6mGArkKh2vqRmnSLAdvNXbeyiOVnL/vjOK0vRDyFqzKj2q5liX4PFLPvg419d3lt1Ba8cXwQx+IGfnBKFDys8urHd+7v7mVL3kJCaQSjnow80FoVaJVJ52NI+cBcYqO7np/vETJIyLJMBqtfptyY++v0gvSsxvHCQRJTpxiKsr+vQaAy8VDTVX1fiZTakbG9eF97evtp8rbgpHZe+DPCidoZAfNWdExDSivBD5b2qpdCYH4Qqmz2f8CU3M9n08ch0aDabvibKJJEvc3nTNQyaQ==
X-YMail-OSG: oW..KG4VM1lb2Xs.9pj_y9vhXJEFyZXAr7eqcOVvy1YDuDPkTOCTokqkIf45_yi
 gA7ygWgmRnd8Y3B1j719fTCVT2UMNGVbqLfXB00.NcE8z1m1NOzAS7cJjXDZckG8JMj0w7MXKr1O
 D8Oe3QXBVRi3aT_gPCNas9.h0tjBUUfGCws8jdTkncXm2bgCvAsNihA6q.J.qx0TiY135rDL4tk8
 reURnzzu9LQuB78sfaBk26nj5AhqfsHn3PDbS6NDwUbgDngaAjOgL6clOMNyp68uj9vcMTyNnSU1
 e33g1Dnh6bgH.yQU9ems2wo2Q2vmA3SWBXgpz7R5Dsp5BfMiKyguIhr6tDoOICVbSc5surBaeHzV
 OAkiE2HverHq15QZEtu5bw36efGTFUInnqK34wk.h1a251ZPshsjXNbFqY.VnNW6h_eiO06gglwj
 nVmqvB5HvO2m6C9nYcTq9gaqjj8VNoJYOJ9vvj.MO37Xqw4HoD9HhM6bYVXuiwL9AVW5aukmznNl
 T5ZU13OQ7OfecOPrK7DCvKLvrjzwjsNSunzGLOP80yST3M3VupP7y0a4vW4dy6PfNUgJ2VcV1mjI
 ZQavlo_oQErlXddD.W3JJsf6uZ8jF05bOUhKnPzQvFSrhtwgSWFdpAVPJpSsWM2fZHIKkTSVJbWk
 5XOs3kloQfAfOZVNy3Ue1N2TV8QFJD5GeX8ngX3sHf4m9Bf_5V_DYewEViVdfbZRP.NHxAHtUlNH
 qI.u5n4ukccDRAKQSDmvG35Gl751LqNKlif3Gq4jY7GI7irBEVg2NqdZviDSiv_Jew5hgvopQ8Dn
 INKJ6xQ4DDTBhq6cU1r1NO7WQtWkfx7BzI1rkZkebu2XY7B.fmtKuQsMjR7tYkxpmbEjpkOKBFiM
 QGrHiLtbpit69BOqdtDYtlHImdXnQ5ehWvEfyZMGBuI.J_lqlbbDcKXJPzGLXtY15z1Cb__uX66c
 0VQXlyC60z0cPSJH4qCf8CKnfOcUrGymg8xRKsErj7OgCHPeSrJuVX5m1GNgQo6oQfFiX4le.m.J
 E7DcNYIAsfPDAFtlsi78NwSJZKOw.K6ktk1kp1wm1UUeGuZf65Y6w6Ssnt3i2o2qFmobodSQrTy8
 k3ZMhdr7cJw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Nov 2018 17:54:49 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d73f81e15452fc626b5336cf6327e178;
          Fri, 30 Nov 2018 17:54:48 +0000 (UTC)
Subject: Re: Security modules and sending signals within the same process
To:     Florian Weimer <fweimer@redhat.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
References: <87lg5asilo.fsf@oldenburg.str.redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2c3e813c-f56a-3354-1299-30b0646f40e1@schaufler-ca.com>
Date:   Fri, 30 Nov 2018 09:54:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87lg5asilo.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/30/2018 7:14 AM, Florian Weimer wrote:
> Is it guaranteed that tasks in the same thread group can always send
> signals to each other, irrespective of their respective credentials
> structs?

No. An LSM may chose to disallow this based on just about any
criteria it desires.

> It's not clear to me whether this is always possible based on the
> security_task_kill implementations I've examined.

SELinux, Smack and AppArmor make their decisions based on
the task_struct credential, so if it's possible to change
the LSM attributes at the task granularity, it's possible
to have a process that can't always talk to itself.

> I want to support per-thread setresuid/setresgid,

That's pretty dangerous in its own right. Effectively
the process containing the threads has multiple UIDs.
That complicates the DAC model significantly.

> but we also use
> signals for inter-thread communication.

It's unfortunate that no one has seriously proposed
mode bits on processes for signal delivery. The UID
matching policy is inconvenient in a lot of cases.
Hmmm...

> This is mainly for thread
> cancellation; the setxgid stuff isn't needed for threads with private
> credentials.  I wonder if I need to disable cancellation for threads
> with such credentials.
>
> Thanks,
> Florian
>

