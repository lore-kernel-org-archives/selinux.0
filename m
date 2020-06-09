Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE022C433DF
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8AE207ED
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 08:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=collaborative.li header.i=@collaborative.li header.b="0LtxRFpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgFIIC2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:02:28 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:40490 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgFIIC1 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 9 Jun 2020 04:02:27 -0400
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jun 2020 04:02:27 EDT
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 37688B12
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 09:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        collaborative.li; h=content-language:content-transfer-encoding
        :content-type:content-type:mime-version:date:date:message-id
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1591689192; x=1593503593; bh=lWyCERFvduKjycUWxDT
        TagSsp3zzcOwBmtWDkOxKPWY=; b=0LtxRFpez+KhVfnJwgvgauNDtqwj7LfL0tO
        Q/eSF9rajonNTv8xG6ETfDdtWtIxdbE/NHKktFNhPKwwapkbIV6xfmwwhpxfH//l
        o5HZZ109kVNGqHieGHsb5j/ejpvQG1vEjtfqXhmx/onb9P6gNl1EWmQVLUcvmKaz
        DFlhWAcoJYylXCrBdWzcvHsAXr46Daj/sBXRxnDOfjuSMl0XxFvn/tWeMO60NO2C
        +IB/jlfCIELRvxS2UCryks+vLG0SmMj7gGj69Q/ie7cTNozmMGvHgt1gB8P3lyiB
        66RxdQr2d1DNIvoeRaubX2JwAXWhpxQCEGDqWN25fRyEMoCoKE4LTkBsinZ1SVWG
        HoTH+KP1DoKcLb617lSUWsKh3vLbhSBrgvFNhyX8scA+ZwDcGEVRgBAICqOzLMcA
        CDaY0gcyavwu5uqgJ2fwLDnJT1116JjwFGjl6Tzc629Se0MTs3P24EPS2X8dfT2H
        zXnTFz42+Sclb0EKXGsG/StlZmKdZnFLM2c0dRET07pIA0H9konD1QXaOoAbJtDI
        GwvnKbuhVj8jrPXEQQ3on8v6vYieUc3CCpw50KSsLIHPfOiz3PlqkSw2K/aI35o7
        yERHPXdRBtl8F5+1nbF0MpVsojJsqzeH8ubfeCOhphOPzpJ4BDWHmp/N2aMlch0P
        gkILgg6s=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PeskUI6hYG4j for <selinux@vger.kernel.org>;
        Tue,  9 Jun 2020 09:53:12 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 9E4EA627
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 09:53:12 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 59EE62379
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 09:53:12 +0200 (CEST)
To:     selinux@vger.kernel.org
From:   Cristian Ariza <cariza@collaborative.li>
Subject: No window opening when running sandbox -S
Message-ID: <7b738730-bbc3-eb04-b8b8-63706cebce24@collaborative.li>
Date:   Tue, 9 Jun 2020 08:53:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

$ sandbox -H sandbox/home -T sandbox/tmp -S

shows a few Gtk warnings (which I am assuming means Gnome loaded 
somewhere) but no window opens. In the man page I can't find much 
information about how sandbox -S actually works so not sure if I am 
missing something or it's just a bug.

I am using Fedora 32 with Gnome.

