Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFD0C433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BE42072A
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 17:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgGaRAO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:00:14 -0400
Received: from mr013msb.fastweb.it ([85.18.95.104]:47958 "EHLO
        mr013msb.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgGaRAO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 13:00:14 -0400
Received-SPF: pass (mr013msb.fastweb.it: domain assyoma.it designates
 93.63.55.57 as permitted sender) identity=mailfrom;
 receiver=mr013msb.fastweb.it; client-ip=93.63.55.57;
 envelope-from=g.danti@assyoma.it; helo=plutone.assyoma.it;
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrieekgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfetuffvhgfguedpucfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepggffhffvufgjfhgfkfigtgfgsehtkehjtddtreejnecuhfhrohhmpefiihhonhgrthgrnhcuffgrnhhtihcuoehgrdgurghnthhisegrshhshihomhgrrdhitheqnecuggftrfgrthhtvghrnhepudefffevfffffeetieeglefgkeejfeejkeejveeuleetffffhefgleefvdeijedvnecuffhomhgrihhnpegrshhshihomhgrrdhithenucfkphepleefrdeifedrheehrdehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehplhhuthhonhgvrdgrshhshihomhgrrdhithdpihhnvghtpeelfedrieefrdehhedrheejpdhmrghilhhfrhhomhepoehgrdgurghnthhisegrshhshihomhgrrdhithequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegtghiiohhnvghssehgohhoghhlvghmrghilhdrtghomhequcfqtfevrffvpehrfhgtkedvvdentghgiihonhgvshesghhoohhglhgvmhgrihhlrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuqfftvefrvfeprhhftgekvddvnehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from plutone.assyoma.it (93.63.55.57) by mr013msb.fastweb.it (5.8.208)
        id 5F04EFC902223467; Fri, 31 Jul 2020 19:00:10 +0200
Received: from webmail.assyoma.it (localhost [IPv6:::1])
        by plutone.assyoma.it (Postfix) with ESMTPA id 92E9FC0CB4C4;
        Fri, 31 Jul 2020 19:00:10 +0200 (CEST)
MIME-Version: 1.0
Date:   Fri, 31 Jul 2020 19:00:10 +0200
From:   Gionatan Danti <g.danti@assyoma.it>
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: lnk_file read permission
In-Reply-To: <CAJ2a_Dcev_o+NyuwUqh2ANseRniZRMQJ4dhDtrF1BtCmFSLgpg@mail.gmail.com>
References: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
 <CAJ2a_Dcev_o+NyuwUqh2ANseRniZRMQJ4dhDtrF1BtCmFSLgpg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <b697596bcda20251d9d0a0f675b53747@assyoma.it>
X-Sender: g.danti@assyoma.it
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Il 2020-07-31 18:25 Christian Göttsche ha scritto:
> An alternative would be, since these symlinks are trusted and
> permanent, to label them as their parent directory (e.g. var_lib_t
> (use the '-l' file type specifier)) and allow the applications to read
> these lnk types.
> This also prevents e.g. mysqld_t to alter the symlink /var/lib/mysqld
> (since it probably has write permission to mysql_db_t:lnk_file but not
> var_lib_t:lnk_file).

Yeah, in some cases I uses the approach above as it seems that many 
domain have lnk_file read permission to var_lib_t. I wonder if a more 
generic solution exists.

Thanks.

-- 
Danti Gionatan
Supporto Tecnico
Assyoma S.r.l. - www.assyoma.it
email: g.danti@assyoma.it - info@assyoma.it
GPG public key ID: FF5F32A8
