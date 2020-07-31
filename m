Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C38C433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 17:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B5622074B
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 17:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbgGaRJz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:09:55 -0400
Received: from mr012msb.fastweb.it ([85.18.95.109]:59867 "EHLO
        mr012msb.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgGaRJz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 13:09:55 -0400
Received-SPF: pass (mr012msb.fastweb.it: domain assyoma.it designates
 93.63.55.57 as permitted sender) identity=mailfrom;
 receiver=mr012msb.fastweb.it; client-ip=93.63.55.57;
 envelope-from=g.danti@assyoma.it; helo=plutone.assyoma.it;
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrieekgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfetuffvhgfguedpucfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvffujghffgfkgigtgfesthejjhdttdervdenucfhrhhomhepifhiohhnrghtrghnucffrghnthhiuceoghdruggrnhhtihesrghsshihohhmrgdrihhtqeenucggtffrrghtthgvrhhnpedvffevtdeuveelhedukeffieeluefhvddtiefgueekgfdvvdfhleehgfekfffgtdenucffohhmrghinheprghsshihohhmrgdrihhtnecukfhppeelfedrieefrdehhedrheejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepphhluhhtohhnvgdrrghsshihohhmrgdrihhtpdhinhgvthepleefrdeifedrheehrdehjedpmhgrihhlfhhrohhmpeeoghdruggrnhhtihesrghsshihohhmrgdrihhtqedprhgtphhtthhopeeotghgiihonhgvshesghhoohhglhgvmhgrihhlrdgtohhmqecuqfftvefrvfeprhhftgekvddvnegtghiiohhnvghssehgohhoghhlvghmrghilhdrtghomhdprhgtphhtthhopeeoughomhhinhhitghkrdhgrhhifhhtseguvghfvghnshgvtgdrnhhlqecuqfftvefrvfeprhhftgekvddvneguohhmihhnihgtkhdrghhrihhfthesuggvfhgvnhhsvggtrdhnlhdprhgtphhtthhopeeoshgvlhhi
        nhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghequcfqtfevrffvpehrfhgtkedvvdenshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from plutone.assyoma.it (93.63.55.57) by mr012msb.fastweb.it (5.8.208)
        id 5F04EEC8022328FC; Fri, 31 Jul 2020 19:09:51 +0200
Received: from webmail.assyoma.it (localhost [IPv6:::1])
        by plutone.assyoma.it (Postfix) with ESMTPA id 2408DE03EC6E;
        Fri, 31 Jul 2020 19:09:51 +0200 (CEST)
MIME-Version: 1.0
Date:   Fri, 31 Jul 2020 19:09:51 +0200
From:   Gionatan Danti <g.danti@assyoma.it>
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: lnk_file read permission
In-Reply-To: <ypjld04bmxry.fsf@defensec.nl>
References: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
 <CAJ2a_Dcev_o+NyuwUqh2ANseRniZRMQJ4dhDtrF1BtCmFSLgpg@mail.gmail.com>
 <ypjld04bmxry.fsf@defensec.nl>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <9f363af014b8670267af982f9d4a6362@assyoma.it>
X-Sender: g.danti@assyoma.it
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Il 2020-07-31 18:53 Dominick Grift ha scritto:
> I agree with this, also for compatibility with systemds' 
> StateDirectory=
> in conjunction with DynamicUsers=.
> 
> I you would for example have a mysqld service with 
> StateDirectory=mysqld
> and DynamicUser=yes then systemd would maintain a symlink
> /var/lib/mysqld that points to /var/lib/private/mysqld
> 
> Even if you do not use that functionality it should still be compatible
> with /data/lib /var/lib equivalency.
> 
> I do this consistently in my personal policy. ie instead of using
> "/var/lib/mysqld(/.*)? i use /var/lib/mysqld -d and /var/lib/mysqld/.*
> so that the symlink context stay's generic
> 
> Regardless, this is a policy design issue that you should probably take
> to your distribution maintainer.

I did not know that systemd would, with specific settings, create a 
private mysql data dir.
I would try the var_lib_t approach more widely.
Thanks.

-- 
Danti Gionatan
Supporto Tecnico
Assyoma S.r.l. - www.assyoma.it
email: g.danti@assyoma.it - info@assyoma.it
GPG public key ID: FF5F32A8
