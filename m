Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29315C433DF
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 19:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E0B2076B
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 19:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgGaThf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:37:35 -0400
Received: from mr012msb.fastweb.it ([85.18.95.109]:44545 "EHLO
        mr012msb.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgGaThf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 15:37:35 -0400
Received-SPF: pass (mr012msb.fastweb.it: domain assyoma.it designates
 93.63.55.57 as permitted sender) identity=mailfrom;
 receiver=mr012msb.fastweb.it; client-ip=93.63.55.57;
 envelope-from=g.danti@assyoma.it; helo=plutone.assyoma.it;
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrieekgddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfetuffvhgfguedpucfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvffujghffgfkgigtgfesthejjhdttdervdenucfhrhhomhepifhiohhnrghtrghnucffrghnthhiuceoghdruggrnhhtihesrghsshihohhmrgdrihhtqeenucggtffrrghtthgvrhhnpedvffevtdeuveelhedukeffieeluefhvddtiefgueekgfdvvdfhleehgfekfffgtdenucffohhmrghinheprghsshihohhmrgdrihhtnecukfhppeelfedrieefrdehhedrheejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepphhluhhtohhnvgdrrghsshihohhmrgdrihhtpdhinhgvthepleefrdeifedrheehrdehjedpmhgrihhlfhhrohhmpeeoghdruggrnhhtihesrghsshihohhmrgdrihhtqedprhgtphhtthhopeeotghgiihonhgvshesghhoohhglhgvmhgrihhlrdgtohhmqecuqfftvefrvfeprhhftgekvddvnegtghiiohhnvghssehgohhoghhlvghmrghilhdrtghomhdprhgtphhtthhopeeoughomhhinhhitghkrdhgrhhifhhtseguvghfvghnshgvtgdrnhhlqecuqfftvefrvfeprhhftgekvddvneguohhmihhnihgtkhdrghhrihhfthesuggvfhgvnhhsvggtrdhnlhdprhgtphhtthhopeeoshgvlhhi
        nhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghequcfqtfevrffvpehrfhgtkedvvdenshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from plutone.assyoma.it (93.63.55.57) by mr012msb.fastweb.it (5.8.208)
        id 5F04EEC80224AD76; Fri, 31 Jul 2020 21:37:31 +0200
Received: from webmail.assyoma.it (localhost [IPv6:::1])
        by plutone.assyoma.it (Postfix) with ESMTPA id D58FDE040443;
        Fri, 31 Jul 2020 21:37:30 +0200 (CEST)
MIME-Version: 1.0
Date:   Fri, 31 Jul 2020 21:37:30 +0200
From:   Gionatan Danti <g.danti@assyoma.it>
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: lnk_file read permission
In-Reply-To: <9f363af014b8670267af982f9d4a6362@assyoma.it>
References: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
 <CAJ2a_Dcev_o+NyuwUqh2ANseRniZRMQJ4dhDtrF1BtCmFSLgpg@mail.gmail.com>
 <ypjld04bmxry.fsf@defensec.nl> <9f363af014b8670267af982f9d4a6362@assyoma.it>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <bd08eef14271d6a6003bf6ba83ff1904@assyoma.it>
X-Sender: g.danti@assyoma.it
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Il 2020-07-31 19:09 Gionatan Danti ha scritto:
> I did not know that systemd would, with specific settings, create a
> private mysql data dir.
> I would try the var_lib_t approach more widely.
> Thanks.

Mmm, it seems labeling the link as var_lib_t is not always sufficient.
Doing a mongodb test relocation from /var/lib/mongodb to /zzz/mongodb 
the service does not start, even if I can see the link having var_lib_t 
label:

# ls -alZ /var/lib/
...
lrwxrwxrwx. root    root    unconfined_u:object_r:var_lib_t:s0 mongodb 
-> /zzz/mongodb

Indeed, I can see the following in /var/log/audit:

type=AVC msg=audit(1596222151.576:253): avc:  denied  { read } for  
pid=4313 comm="mongod" name="mongodb" dev="dm-0" ino=33673444 
scontext=system_u:system_r:mongod_t:s0 
tcontext=unconfined_u:object_r:var_lib_t:s0 tclass=lnk_file permissive=0

Relabeling the synlink with its "native" label via restorecon -RF 
produce the following:

# ls -alZ /var/lib/
...
lrwxrwxrwx. root    root    system_u:object_r:mongod_var_lib_t:s0 
mongodb -> /zzz/mongodb

But the service again does not start, with the followin logs:

type=AVC msg=audit(1596222240.363:257): avc:  denied  { read } for  
pid=4344 comm="mongod" name="mongodb" dev="dm-0" ino=33673444 
scontext=system_u:system_r:mongod_t:s0 
tcontext=system_u:object_r:mongod_var_lib_t:s0 tclass=lnk_file 
permissive=0

What would be the best approach in this case? I know that one approach 
would be to use a bind mount, but I would like to avoid it because:
a) it has bad filesystem discoverably (you had to search for bind mount 
explicitly, while a symlink is visible even with a simple ls)
b) I need to setup a fcontext <<None>> for the actual dir which is 
bind-mounted (otherwise, a "restorecon -RF /zzz/" will cause issues, by 
relabeling any files with default_t)

I am open to suggestions...
Thanks.

-- 
Danti Gionatan
Supporto Tecnico
Assyoma S.r.l. - www.assyoma.it
email: g.danti@assyoma.it - info@assyoma.it
GPG public key ID: FF5F32A8
