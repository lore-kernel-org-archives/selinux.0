Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2050CC43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 13:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EA3206EC
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 13:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iHbZsh5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfLQNML (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:12:11 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36963 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQNML (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 08:12:11 -0500
Received: by mail-lj1-f174.google.com with SMTP id u17so10889256lja.4
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2019 05:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWG4AMbepZ/1rat8s/PEABceboCH3OIsoACE/bEM3ro=;
        b=iHbZsh5sR6iWGJnqgJ5Wn7rB3E7V4pO70Hweta9S6KHJuqcN5QPWQnQNqYxHHr2x/1
         4u8pq5DPgIEq91GJ255kOXxugioShyRfO+Jcn8xXkqtTOJkCfcSZn1xmMyX7AzqyBuhr
         cRUdXpzmC+XYYG7Z7MYeTOYOZqGOQKv05zqiy1BS39wbxcYP6GbJCg6vO0c8frW17Hxh
         T1oCBiVc9kVTqHf+tHYaIMbiNFYeXRwFk1byqW3uqU4eMzbQM20KA4ij8y4oxFSRK2GL
         pF7sMD5TG83xWhJdhdylhUheFrG8safG/+Z7tHcBADD0dCZYFbZbdcKoCFU5EPVRhpVt
         28Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWG4AMbepZ/1rat8s/PEABceboCH3OIsoACE/bEM3ro=;
        b=HKCnNDQNOmtHqzaVHc3fTKauIauaoCO05CdiACoZw9Wqu4iS7ecxh+3MpTQwHQ1VqM
         WqP1hv0YJR6oWRDv5D36qpED/VBVsuYlhwyQ/8iK6m2pEmHEI9NuAc7S/P0rHD3XaRw6
         lflVRSgUFiV8Dr+NgEXtSz2pl2lkd16jbcI5DLT09G45MUHqA26fn6x/Rd/3nszetmgO
         mFVo3eyRJjgaVXtFrOmWSedvDoSzvjuEf7WTir6XuTiokFjBrcvJGfAZp2qvZr4PAhHa
         CVZD1f/X2UXUCU80yEvMW7lS1Pfk5+N3pO//vGfulCsDEMail1yZbbBki+AtnNBARmx3
         ZdrQ==
X-Gm-Message-State: APjAAAWW5G2cIKa3RjQYq9v0hLG9t467y+eXNuz+x1/69JBCaTRJr1xB
        PzjtRv4eLkiwHOfR2UupZEkGk1UxyBhYrUI5+niU
X-Google-Smtp-Source: APXvYqzJ8eER6Che4LVq5cW55+tKPpOSnoD4Ml7eri7GSiSAN06gePVfpd1be+KhxBDv439YkxKiKQLBAzBBPxtyX7A=
X-Received: by 2002:a2e:89da:: with SMTP id c26mr3279699ljk.54.1576588329093;
 Tue, 17 Dec 2019 05:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20191210153945.20635-1-sds@tycho.nsa.gov> <4d40e7cb-f191-2327-7160-333c2c100f57@tycho.nsa.gov>
In-Reply-To: <4d40e7cb-f191-2327-7160-333c2c100f57@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Dec 2019 08:11:57 -0500
Message-ID: <CAHC9VhRU8qgHkKnhTAKZWz1CPom5pgV0AqAcNtizR39mbbtX3g@mail.gmail.com>
Subject: Re: [PATCH v4] selinux-testsuite: add lockdown tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 16, 2019 at 8:47 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/10/19 10:39 AM, Stephen Smalley wrote:
> > Test all permissions associated with the lockdown class.
> > Also update other test policies to allow lockdown permissions
> > where needed.
> >
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> Barring objections, I will merge this tomorrow Dec 17.

Thanks Stephen.

-- 
paul moore
www.paul-moore.com
