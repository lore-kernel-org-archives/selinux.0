Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F222C4727E
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 10:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA6420789
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 10:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgI3Kjq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Sep 2020 06:39:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59881 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbgI3Kjq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Sep 2020 06:39:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 27DC15C01CF;
        Wed, 30 Sep 2020 06:39:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 30 Sep 2020 06:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        71CghTCBpxVTFJhIlLR4Ey6zPfCV9SPHg/HlojHYo18=; b=S3xEqFU44nJpjBYH
        VyMtFWE2g7K2lw7uX+XZRshAfbFFg5MQfN32J/SQRQDUqDmfVfrK4q7glrUVjbQo
        3Z6SUfL8vFjXGCN6ntfUWa0/spVmsZw7kDF5TmcJR3ivg7MUsRqLOZfkIp+eV7+7
        qbWb6NXNj0j4W6TVyNHxJDFmBHrHKMFSI88W9mBhIdzDfwbqAbbDc8YXomjlTcPT
        ReQzsTQsdG4FHjGwrHY5o4Yo7QyA0YzVr7ewuVDH9U42Ylouzqq/uUouoASDEErn
        tvBuOsDtZ+humRlllG2E/NGhQ/akBspSumF2h4gpnz/TAONJ5+dUspfJVL/ASmST
        BH1jJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=71CghTCBpxVTFJhIlLR4Ey6zPfCV9SPHg/HlojHYo
        18=; b=k79MqM+CJkHDsTYj7aK7OFrfiEoPv2h/fJCNG4NDiA3O9li+IG/cfTjpe
        t9F9lL4hAyjxuBa0jDlqlI1RzycP7RrP6e3BbUtZCGHnn/QbMQenJkigjV51DHF8
        Y0NsBnkA8nqvYVwsr56mlArFdzssJO3+sTmMFFSLy34GJcQCGUAmkd42n9YxQIIS
        JaUOL5jhdW/2t9H9d1mjExG+89z7spqh6unhB26RFDeYlLuUAmjQ+N8i/H+WNFWt
        xynnwbNVwfiE71PHV8CVHgKKfK5CXN1OKWy5ZH68HEv27JgdCW2KB+lazMnYVEqA
        1P6SQa+F7T5KUn0+Y2hMCPeqO2bpQ==
X-ME-Sender: <xms:cGB0X01A4Lotafi5hmt4jr3Fq61grTwbFVuNhVkWk6X4Zl2V1TRgfA>
    <xme:cGB0X_GqMmCdGFuWqxAdibLO9yYv7QgNOvo3YFCTLIq-mL2VpIkcUjHHjBUVIkxC-
    PIG7brJObav>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedvgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peduvddurdeggedruddvkedrvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:cGB0X86mswbP86BaqZtAawEO-mVXxMUJSJOlay88YhxnTAmzjn44Mg>
    <xmx:cGB0X92FJvEO2nLMDx2_VJi-yyb-7R6MRs5HLx36MfgpbnJ-aVLDnQ>
    <xmx:cGB0X3FRq5PcOPq-iiR4katbVamW8iVZy1PhbbhrU1xNDSCIKOv5ZQ>
    <xmx:cWB0X4OgEg_oNvx1zWS_k-B-Xg746BEdf0g4cuYsFxosOTKbwTRJtw>
Received: from mickey.themaw.net (unknown [121.44.128.20])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4638C328005A;
        Wed, 30 Sep 2020 06:39:41 -0400 (EDT)
Message-ID: <c1f38075cde1b51caa2e2e040c294d25bb650f85.camel@themaw.net>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
From:   Ian Kent <raven@themaw.net>
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Date:   Wed, 30 Sep 2020 18:39:37 +0800
In-Reply-To: <689756d7d7d73a8eb86d020b0dfeb976e28cc9b4.camel@themaw.net>
References: <20200921163011.GZ3421308@ZenIV.linux.org.uk>
         <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
         <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
         <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
         <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
         <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
         <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
         <05c18390d485ae6d84c49f707d20b49e28f210a6.camel@themaw.net>
         <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
         <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
         <20200929180037.GA12447@lst.de>
         <689756d7d7d73a8eb86d020b0dfeb976e28cc9b4.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-09-30 at 13:50 +0800, Ian Kent wrote:
> On Tue, 2020-09-29 at 20:00 +0200, Christoph Hellwig wrote:
> > On Tue, Sep 29, 2020 at 10:23:50AM -0700, Linus Torvalds wrote:
> > > On Tue, Sep 29, 2020 at 5:16 AM Ondrej Mosnacek <
> > > omosnace@redhat.com> wrote:
> > > > OK, so it seems that reverting comes out as the best choice
> > > > here.
> > > 
> > > Yeah.
> > > 
> > > > BTW, I'm looking at rw_verify_area() and I see this "If (ppos)"
> > > > check
> > > > and the comment above it... And then I look at autofs_write(),
> > > > which
> > > > passes &file->f_pos, while ksys_write() passes file_ppos(file)
> > > 
> > > Ok, that doesn't matter for the security_file_permission() issue,
> > > but
> > > yes, autofs is doing the traditional thing, and it's pointless.
> > > Using
> > > file_ppos(file) isn't an option since it's an inline to
> > > read_write.c,
> > > but it could just pass in NULL these days and avoid that too.
> > > 
> > > So how about we just do the appended patch? Can whoever sees this
> > > problem just verify, even though it looks trivially correct...
> > 
> > This looks sensible to me.  I'd throw in a
> > 
> > /* only for autofs, don't use in new code */
> > 
> > near the export, but users of these kind of functions tend to be
> > blind copy and paste code anyway, so the comment probably isn't
> > even read by the relevant parties..
> 
> I'll build a patched kernel and give it a whirl.

Duplicated the problem first then built a patched kernel and tested.

The patch makes the problem go away, communication to the daemon
is occurring fine so the use of NULL as the file position is ok.

It looks like the error returns should be as before which is good
but there may be another problem I need to fix in there that became
apparent because this problem drew attention to it. That's something
else entirely though.

> 
> Ian

