Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4D1C433DF
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 19:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC142087C
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 19:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgGaTtG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:49:06 -0400
Received: from mr014msb.fastweb.it ([85.18.95.103]:46275 "EHLO
        mr014msb.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGaTtG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 15:49:06 -0400
Received-SPF: pass (mr014msb.fastweb.it: domain assyoma.it designates
 93.63.55.57 as permitted sender) identity=mailfrom;
 receiver=mr014msb.fastweb.it; client-ip=93.63.55.57;
 envelope-from=g.danti@assyoma.it; helo=plutone.assyoma.it;
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrieekgddugedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfetuffvhgfguedpucfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvffujghffgfkgigtgfesthejjhdttdervdenucfhrhhomhepifhiohhnrghtrghnucffrghnthhiuceoghdruggrnhhtihesrghsshihohhmrgdrihhtqeenucggtffrrghtthgvrhhnpedvffevtdeuveelhedukeffieeluefhvddtiefgueekgfdvvdfhleehgfekfffgtdenucffohhmrghinheprghsshihohhmrgdrihhtnecukfhppeelfedrieefrdehhedrheejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepphhluhhtohhnvgdrrghsshihohhmrgdrihhtpdhinhgvthepleefrdeifedrheehrdehjedpmhgrihhlfhhrohhmpeeoghdruggrnhhtihesrghsshihohhmrgdrihhtqedprhgtphhtthhopeeotghgiihonhgvshesghhoohhglhgvmhgrihhlrdgtohhmqecuqfftvefrvfeprhhftgekvddvnegtghiiohhnvghssehgohhoghhlvghmrghilhdrtghomhdprhgtphhtthhopeeoughomhhinhhitghkrdhgrhhifhhtseguvghfvghnshgvtgdrnhhlqecuqfftvefrvfeprhhftgekvddvneguohhmihhnihgtkhdrghhrihhfthesuggvfhgvnhhsvggtrdhnlhdprhgtphhtthhopeeoshgvlhhi
        nhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghequcfqtfevrffvpehrfhgtkedvvdenshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from plutone.assyoma.it (93.63.55.57) by mr014msb.fastweb.it (5.8.208)
        id 5F04F0540224ECBA; Fri, 31 Jul 2020 21:49:01 +0200
Received: from webmail.assyoma.it (localhost [IPv6:::1])
        by plutone.assyoma.it (Postfix) with ESMTPA id 6AD48C0CB4C4;
        Fri, 31 Jul 2020 21:49:01 +0200 (CEST)
MIME-Version: 1.0
Date:   Fri, 31 Jul 2020 21:49:01 +0200
From:   Gionatan Danti <g.danti@assyoma.it>
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: lnk_file read permission
In-Reply-To: <ypjl1rkrmpul.fsf@defensec.nl>
References: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
 <CAJ2a_Dcev_o+NyuwUqh2ANseRniZRMQJ4dhDtrF1BtCmFSLgpg@mail.gmail.com>
 <ypjld04bmxry.fsf@defensec.nl> <9f363af014b8670267af982f9d4a6362@assyoma.it>
 <bd08eef14271d6a6003bf6ba83ff1904@assyoma.it> <ypjl1rkrmpul.fsf@defensec.nl>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <ddebf7e0ac775d521e86c023decf9bbb@assyoma.it>
X-Sender: g.danti@assyoma.it
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Il 2020-07-31 21:44 Dominick Grift ha scritto:
> Everyone who has business in /var/lib should probably be able to read
> var_lib_t lnk_files.

I agree.

> You can use audit2allow to allow these entities to read symlinks of
> type var_lib_t

Sure, but I would like to avoid policy customization outside what can be 
done via semanage.

> Again though, there is a larger picture here and I would argue that 
> your
> distribution maintainer should acknowledge that.

Yeah, I opened a BZ agaist it.

Do you think this also affect the reference policy? Should I write to 
the selinux-policy mailing list?
Thanks.

-- 
Danti Gionatan
Supporto Tecnico
Assyoma S.r.l. - www.assyoma.it
email: g.danti@assyoma.it - info@assyoma.it
GPG public key ID: FF5F32A8
