Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F87C433DF
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 08:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB08420721
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 08:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="VNoakNGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgEUI5d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 04:57:33 -0400
Received: from mailomta6-re.btinternet.com ([213.120.69.99]:14676 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728635AbgEUI5d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 04:57:33 -0400
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200521085729.KTPL4009.re-prd-fep-044.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 21 May 2020 09:57:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1590051449; 
        bh=hQgcsAbPn6TlMmrQR6TXa6kbKggSrbamJwryddEbEpk=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=VNoakNGQi2jZGEKlGZJ8d2XCdC518qOdsiNo4q7Pf3UWTl3EdpMCiKzEVnI9CwxApvuUKhoD/um5cbZonnT7gUgblmnv8PWf2q1zpD32k1baJb1fG6haeVO86/zLYp81dEgMEJKo2qPZKZSpW3aB8qYDE7DoS5Y7SVMwVGJ78MVonVWplJcKj9Zg3eHVpcgqJSzFQCM1rlPTsboOFlhv+DRzwRKQxaYrglGMCxRf3OGiRxg5lLoxgS1TosoJdbIUNRiHFVT5M6ty876V3Db9Gb+6jg3HqWvqBCpJV2Oc6QhbC8Xvul5ZdhwfoyPJbhmg+K3DJUQ7ELvcfAhexQW83A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.148.83.78]
X-OWM-Source-IP: 109.148.83.78 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrudduuddgtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeetteevgeehveeiieefkedvieehjeevtdeileffffefveelieejvedvjedvuddugeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedutdelrddugeekrdekfedrjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrddugeekrdekfedrjeekpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehpfiifsegvughgvghkvggvphdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsvghl
        ihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.148.83.78) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A147D11B1ED83; Thu, 21 May 2020 09:57:29 +0100
Message-ID: <321f492f19164c43104ec1fd9d699e80ad2a7380.camel@btinternet.com>
Subject: Re: Bad context in PostgreSQL page on SELinux Project wiki?
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Peter Whittaker <pww@edgekeep.com>, selinux@vger.kernel.org
Date:   Thu, 21 May 2020 09:57:29 +0100
In-Reply-To: <CAHC9VhTgXU=yLncdXHrZkyo23OGc+aLDcNZinqkTLPLiq81Ycw@mail.gmail.com>
References: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
         <55ef0d617fa84d72f142ec0fa6492e5c5e1b1e2b.camel@btinternet.com>
         <CAHC9VhQ5f_h_H=CyunX2tKbCgHP8o2Jp4dyMLzX0t9XkG8TPgQ@mail.gmail.com>
         <60438e5b407320275932f60bc10936b75c9280aa.camel@btinternet.com>
         <CAHC9VhTgXU=yLncdXHrZkyo23OGc+aLDcNZinqkTLPLiq81Ycw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2020-05-19 at 17:40 -0400, Paul Moore wrote:
> On Tue, May 19, 2020 at 9:50 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Sun, 2020-05-17 at 17:59 -0400, Paul Moore wrote:
> > > On Sun, May 17, 2020 at 7:17 AM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > I update the notebook occasionally to keep track of changes for
> > > > my
> > > > own
> > > > reference, but currently have no plans to publish a new one. If
> > > > you
> > > > do
> > > > have comments I'm happy to take them onboard, however no
> > > > guarantees
> > > > to
> > > > publish.
> > > 
> > > I just wanted to say thank you once again for all your work on
> > > the
> > > notebook, it's a great resource!
> > Glad it's useful
> > 
> > > I understand not wanting to go through the process of generating
> > > new
> > > editions of the notebook, but is the source material posted
> > > somewhere
> > > online so that people who wanted an updated copy could access it?
> > The source is not available anywhere that I know of (I did send it
> > to a
> > few people who wanted to translate it but never heard from them
> > again
> > !!!). I edit it with LibreOffice Writer as an odt document. It
> > converts
> > to pdf okay, but epub looks real crap.
> > 
> > I guess I could post it somewhere, would you like to host it on
> > your
> > site ??.
> > 
> > It needs cleaning up as I've scribbled all over it so will take a
> > few
> > weeks.
> 
> While I'm happy to host it, I think it might be better if we hosted
> it
> in the community GitHub repo - what would you think about creating a
> new repo under https://github.com/SELinuxProject?  Perhaps
> https://github.com/SELinuxProject/notebook?  While it might seem a
> bit
> odd to host an ODT file in a git repo, it is a good way to keep track
> of historical changes and there are other tools such as the issue
> tracker and "release" hosting which might be helpful.

githubs sounds good, however as the document is quite large I'm
splitting into sections like on the wiki as it will make easier editing
(should anyone feel the need).

I've converted with pandoc using 'markdown_strict', where it converts
text to md but most tables into html (as their own md table format will
not render in some viewers). With firefox and the Markdown Viewer
Webext, the samples I've done look ok.

As with all these conversion apps, pandoc leaves a lot of cleaning up
to do, so I'll be some time. I'll send you the files once I'm done.
Thanks for your support.

> 
> However, the last thing I would want to do is put a hurdle between
> you
> and the doc.
> 
> Let me know what you think, I'm happy to create a new repo for you on
> the SELinuxProject GH org and set you up with the necessary
> permissions - assuming the others don't mind, and I can't imagine
> they
> would.
> 

