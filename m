Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62932C433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485DD2072A
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 16:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgGaQ4O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:56:14 -0400
Received: from mr014msb.fastweb.it ([85.18.95.103]:59436 "EHLO
        mr014msb.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbgGaQ4N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 12:56:13 -0400
Received-SPF: pass (mr014msb.fastweb.it: domain assyoma.it designates
 93.63.55.57 as permitted sender) identity=mailfrom;
 receiver=mr014msb.fastweb.it; client-ip=93.63.55.57;
 envelope-from=g.danti@assyoma.it; helo=plutone.assyoma.it;
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrieekgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfetuffvhgfguedpucfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvffujghffgfkgigtgfesthejjhdttdervdenucfhrhhomhepifhiohhnrghtrghnucffrghnthhiuceoghdruggrnhhtihesrghsshihohhmrgdrihhtqeenucggtffrrghtthgvrhhnpedvffevtdeuveelhedukeffieeluefhvddtiefgueekgfdvvdfhleehgfekfffgtdenucffohhmrghinheprghsshihohhmrgdrihhtnecukfhppeelfedrieefrdehhedrheejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepphhluhhtohhnvgdrrghsshihohhmrgdrihhtpdhinhgvthepleefrdeifedrheehrdehjedpmhgrihhlfhhrohhmpeeoghdruggrnhhtihesrghsshihohhmrgdrihhtqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghequcfqtfevrffvpehrfhgtkedvvdenshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeeoshhtvghphhgvnhdrshhmrghllhgvhidrfihorhhksehgmhgrihhlrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from plutone.assyoma.it (93.63.55.57) by mr014msb.fastweb.it (5.8.208)
        id 5F04F054022325F9; Fri, 31 Jul 2020 18:56:10 +0200
Received: from webmail.assyoma.it (localhost [IPv6:::1])
        by plutone.assyoma.it (Postfix) with ESMTPA id DED78DE85F7B;
        Fri, 31 Jul 2020 18:56:09 +0200 (CEST)
MIME-Version: 1.0
Date:   Fri, 31 Jul 2020 18:56:09 +0200
From:   Gionatan Danti <g.danti@assyoma.it>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: lnk_file read permission
In-Reply-To: <CAEjxPJ5XGhaZmAvC=-2A=KaCKmqZEp4r6z7fOoDP0+GpJDOZog@mail.gmail.com>
References: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
 <CAEjxPJ5XGhaZmAvC=-2A=KaCKmqZEp4r6z7fOoDP0+GpJDOZog@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <e0c9fd0926d97314b4abec38ab0fe8ca@assyoma.it>
X-Sender: g.danti@assyoma.it
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Il 2020-07-31 15:12 Stephen Smalley ha scritto:
> The lnk_file read permission check can be used to protect processes
> from following/reading untrusted symlinks, often used in malicious
> symlink attacks.
> The more broadly you allow it, the more potential for the process to
> be misdirected to an unexpected file in order to overwrite some file
> or leak its contents.

Hi Stephen,
I generally know the catchs with symlinks, but I fail to understand how 
this can be a problem for selinux: after all, the real/target file must 
be labeled with the correct type, otherwise the service binary (running 
in its confined domain) will not be able to open it. In other words, it 
is my understanding that selinux not only matches the symlink, but the 
target file also. So it should not be possible to fool it by chaning the 
symlink target on the fly. Am I missing something?

> That said, I think the policy macros/interfaces could allow it more
> widely than is currently done without too much risk. That's more of a
> question for selinux-refpolicy for upstream policy and/or the Fedora
> selinux list for their fork of it. The alternative approach for
> relocating directories is to use bind mounts.

Well, I'm coming from the fedora selinux mailing list ;)
But if you think I should write to selinux-refpolicy, I will do that.
Thanks.

-- 
Danti Gionatan
Supporto Tecnico
Assyoma S.r.l. - www.assyoma.it
email: g.danti@assyoma.it - info@assyoma.it
GPG public key ID: FF5F32A8
