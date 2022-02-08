Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEE0C433EF
	for <selinux@archiver.kernel.org>; Tue,  8 Feb 2022 23:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiBHXvG convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Tue, 8 Feb 2022 18:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiBHXvF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Feb 2022 18:51:05 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 15:51:04 PST
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1F46C061576
        for <selinux@vger.kernel.org>; Tue,  8 Feb 2022 15:51:04 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-5-34ZSeE5ZPTGlj3py7oltng-1; Tue, 08 Feb 2022 23:44:44 +0000
X-MC-Unique: 34ZSeE5ZPTGlj3py7oltng-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 8 Feb 2022 23:44:43 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 8 Feb 2022 23:44:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dominick Grift' <dominick.grift@defensec.nl>,
        Chris PeBenito <chpebeni@linux.microsoft.com>
CC:     William Roberts <bill.c.roberts@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        "Stephen Smalley" <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
        "selinux-refpolicy@vger.kernel.org" 
        <selinux-refpolicy@vger.kernel.org>
Subject: RE: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
Thread-Topic: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
Thread-Index: AQHYHQyXVOSyCHpUB0mpWP39zhRRb6yKUIVg
Date:   Tue, 8 Feb 2022 23:44:43 +0000
Message-ID: <23e35a8fc78e414c982ab40670157667@AcuMS.aculab.com>
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
        <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
        <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
        <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
        <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
        <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
        <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
        <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
        <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
        <875ypt5zmz.fsf@defensec.nl>
        <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
        <4be3fef6-63ca-af97-7fc6-d93d85a9b706@linux.microsoft.com>
 <87ee4dnw52.fsf@defensec.nl>
In-Reply-To: <87ee4dnw52.fsf@defensec.nl>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Dominick Grift
> Sent: 08 February 2022 16:47
...
> I would not mind removing these two checks, but i am not a big user of
> xperms (i only filter TIOSCTI on terminal chr files and only for the
> entities that write or append them).

TIOSCTI isn't your only problem.
Much 'fun' can be had with terminals that support a settable
answerback message.
Possibly that is limited to physical serial terminals, but some
emulators might be 'good enough' to support the relevant escape
sequences.

Even the default answerback message can be very confusing.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

