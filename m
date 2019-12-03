Return-Path: <SRS0=8r5V=ZZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DC8C432C3
	for <selinux@archiver.kernel.org>; Tue,  3 Dec 2019 07:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE1E206DF
	for <selinux@archiver.kernel.org>; Tue,  3 Dec 2019 07:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLCH5c convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Tue, 3 Dec 2019 02:57:32 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727491AbfLCH5c (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 3 Dec 2019 02:57:32 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A86098A26BDC9BB15333;
        Tue,  3 Dec 2019 07:57:29 +0000 (GMT)
Received: from fraeml703-chm.china.huawei.com (10.206.15.52) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 3 Dec 2019 07:57:29 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 3 Dec 2019 08:57:27 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Tue, 3 Dec 2019 08:57:27 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
CC:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        initramfs <initramfs@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [GIT PULL] SELinux patches for v5.5
Thread-Topic: [GIT PULL] SELinux patches for v5.5
Thread-Index: AQHVpJ/x+d16ntrB80i8vjtQflP95qem+KsAgABEtACAAGN6gIAABAmAgABuhjA=
Date:   Tue, 3 Dec 2019 07:57:27 +0000
Message-ID: <48156b9a11844d5b98ea960fd1351872@huawei.com>
References: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
 <1575302310.4793.379.camel@linux.ibm.com>
 <CAHC9VhRkosCVR+4qyf=GPKQuQoJzwjZZJ_z7rhE-qiL-TNbtPw@mail.gmail.com>
 <1575338427.4793.486.camel@linux.ibm.com>
 <16ec989f948.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <16ec989f948.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> -----Original Message-----
> From: owner-linux-security-module@vger.kernel.org [mailto:owner-linux-
> security-module@vger.kernel.org] On Behalf Of Paul Moore
> Sent: Tuesday, December 3, 2019 3:15 AM
> To: Mimi Zohar <zohar@linux.ibm.com>
> Cc: selinux@vger.kernel.org; linux-security-module@vger.kernel.org;
> Roberto Sassu <roberto.sassu@huawei.com>; initramfs
> <initramfs@vger.kernel.org>
> Subject: Re: [GIT PULL] SELinux patches for v5.5
> 
> On December 2, 2019 9:00:35 PM Mimi Zohar <zohar@linux.ibm.com>
> wrote:
> 
> > On Mon, 2019-12-02 at 15:04 -0500, Paul Moore wrote:
> >> On Mon, Dec 2, 2019 at 10:58 AM Mimi Zohar <zohar@linux.ibm.com>
> wrote:
> >>> [Truncated Cc list, adding Roberto and the initramfs mailing list]
> >>>
> >>> Hi Paul,
> >>>
> >>> On Tue, 2019-11-26 at 16:24 -0500, Paul Moore wrote:
> >>>
> >>>> - Allow file labeling before the policy is loaded.  This should ease
> >>>> some of the burden when the policy is initially loaded (no need to
> >>>> relabel files), but it should also help enable some new system
> >>>> concepts which dynamically create the root filesystem in the initrd.
> >>>
> >>> Any chance you're planning on using Roberto's patches for including
> >>> security xattrs in the initramfs?[1]
> >>> [1] https://www.spinics.net/lists/linux-initramfs/msg04771.html
> >>
> >> I'm assuming you're not asking about me personally? ;)
> >
> > No, of course not.  I was wondering if "help enable some new system
> > concepts which dynamically create the root filesystem in the initrd"
> > adds SELinux labels on the root filesystem.
> 
> Once again, that is more of a distro specific question.

If recent changes allow file labeling before the SELinux policy is loaded,
I think it would help the mechanism I developed. The SELinux label,
IMA/EVM signature can be included in the ram disk (standard CPIO image),
in a special file named METADATA!!! that follows the file xattrs are applied to.

Roberto
