Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0CAC761A6
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 13:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCaNxf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjCaNxd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 09:53:33 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1ACA2E
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 06:53:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id BA61C320016F;
        Fri, 31 Mar 2023 09:53:31 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute4.internal (MEProxy); Fri, 31 Mar 2023 09:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        pleasantsmoke.com; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680270811; x=1680357211; bh=ne4Hf97PT9pf0E3+px9vjUiam8CYVPV/DEP
        ZLbgJK+0=; b=bsZg9Ee5nIJWmqMZWvpusE2vknClm084KmrXIATCiDLUTpb76LA
        48PDUUeGpHpIk6aEoHOzSautYFk0rM2XvX8PMNJ57cNKge+7Jlj9zicu3ZKA17Pj
        6nrHD8Cp6h8St2alNdBxbR3g3+ozPBIKszKaABU/b/DiXwhjEkoFuteoqceoOYpT
        aNuF8TDV9vC+KZncE0z3UuNqTGZqAIrHJ3INF22iGMOpyFlZKNP4SzSPVEVY9jxs
        ybOHw4K71iZ6Zg4o9QVoW6CyuUqBXl7DI1OM18JQu/f6K7xTZXHSRL1WdbxVjET8
        1u49MNnLz+AJZCP48MsQ9X2DTayTn9B4o/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680270811; x=1680357211; bh=ne4Hf97PT9pf0
        E3+px9vjUiam8CYVPV/DEPZLbgJK+0=; b=AbRneDbFsfE6GxdrTnoAsFO8eV6z+
        N0b8Im8gEYiO0XoN6RtrlPci+d1HmSToBZRlBgr/2gQKZbZooQVHwHCD4+CLdksR
        oVKZZpgAogMxX2M53yEwku7IHVFP3RKEBPLywUEPEHWgNg4xuQ73k1phrXLhx/gC
        5qjEIRXUuqdfB9dmNfCsNGzjkdYG/5nGBYlL+qZyadZnLA2Ypn37g1LhEUwAWhlr
        Y0KnMrb4KirvFPQVIbZCCoy+47ud+H3kBTK3w8NuMHXLJw/38yjSInIbW0UmipV9
        UDgX5E6Bzgm5Pz/pxmf4E6JS17pBa7ig6uSvhb9FkaVM6AtHTfx2X7QIg==
X-ME-Sender: <xms:2uUmZEkBm5-qoc5ZqeFjXvkq_dHoAJVtZ2VSEkw62WNIdotGtT0iTw>
    <xme:2uUmZD0-af1E4tThC7o11LU2flkR2e417IU3TpOjWV2EDzZgRStpcRqAOZnnvIPpi
    43la_Ii9pS9BOJEeVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfho
    nhgrthhhrghnucfuthhrrghushhsfdcuoehjohhhnhesphhlvggrshgrnhhtshhmohhkvg
    drtghomheqnecuggftrfgrthhtvghrnhepueegtdeltdfghffhheevudevlefguddvhfet
    tdfhueelvdejffeikeetgeejfefhnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhhnhes
    phhlvggrshgrnhhtshhmohhkvgdrtghomh
X-ME-Proxy: <xmx:2uUmZCqmVrGBtqtcAZ_6r9zq0axJymR3K5FQ6snReTcgAJ9CZcxleg>
    <xmx:2uUmZAnoyTpG8_08vuDJVXUYtOGPcZ-Z57Nlcedorw-BnMX7u6TotQ>
    <xmx:2uUmZC2m_2AH0mj4M1op0B5t0ys_REh3NUCFoHMu_nuliCwBHjWchQ>
    <xmx:2-UmZLgbzlmlX02xVxn0yrhOx6p0NAPQamg4uNosPrwJTEAfN-xQbg>
Feedback-ID: i5281472f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DD77F2A20092; Fri, 31 Mar 2023 09:53:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <b0037c2a-c10c-4819-8add-14c176aed942@app.fastmail.com>
In-Reply-To: <CAP+JOzR_nL0Y12hOU2gTU6=U+J4YaZsyE6TLMQWFSUi0dJ3NCA@mail.gmail.com>
References: <c58a0cc8-6453-45ca-9bfc-f041b0e7478a@app.fastmail.com>
 <CAP+JOzR_nL0Y12hOU2gTU6=U+J4YaZsyE6TLMQWFSUi0dJ3NCA@mail.gmail.com>
Date:   Fri, 31 Mar 2023 09:53:09 -0400
From:   "Jonathan Strauss" <john@pleasantsmoke.com>
To:     "James Carter" <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: Possible bug in policy compilation
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter wrote:
> Jonathan Strauss wrote:
> >
> > I'm not sure if this is the right place to post this, I was writing a
> > policy for an API gateway and couldn't figure out why I wasn't getting
> > a domain transition. Turns out I was missing `type init_t;` in my
> > require block in the type enforcement file, but the compiler did not
> > complain about the missing type.
> >
> > Seems like it should have failed with the missing `type init_t;`
> >
> 
> It is hard to say what is going on without seeing the policy you were
> trying to compile. Are you able to share it?
> Jim
> 

Apologies in advanced if I mess up the formatting, looks like I am also
missing another type `sysadm_t` (Still trying to understand the roles so
it's a bit ugly) reproducer here :

https://github.com/pss-john/se-missing-type
