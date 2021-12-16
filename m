Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D85C433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Dec 2021 15:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhLPPhD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Dec 2021 10:37:03 -0500
Received: from mailomta27-re.btinternet.com ([213.120.69.120]:43481 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232607AbhLPPhC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Dec 2021 10:37:02 -0500
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20211216153700.NPXR8938.re-prd-fep-049.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 16 Dec 2021 15:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1639669020; 
        bh=E+AgHOJMeGv+h73OzmyK8eZjBXPblw7PuqwK9IL/fo4=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=sx5eEdjgAG/CjPkb6ARRNKYaT9XGyuyZADllxEFwZzPReH8rgoyudD9qel78iB66g4kULu/OMyr8DN9lolgrAatGvv+IA8hMDfsZI3GBxHwR0KtGY+BB96yx2SJmKCsgdI9jKieG36UVxx8mI8OOPkQ0aSjkRrF9bMEvbMR4T/t361CeySe3N8SSOEkwsa5mNfIujFUIs1BnKK5l++x7Z8LFhDPmeP77lL7ASc52/1L2bo6YDUtWBs0vEg/4hgQqj293vegNrK1mjuvB9S/ga8eGFfLf342XWljsFpkJ8VOwewStZlzZUJTQgz/k0lYdq77M3bTHuiOoYQysD+CZig==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A91240D796D10
X-Originating-IP: [217.43.180.152]
X-OWM-Source-IP: 217.43.180.152 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepveevgeeftdfhhfevtdejiedtvdduieegfeduleevleelgeeileefvdejieefiedtnecuffhomhgrihhnpegtrghlihgsrhgvqdgvsghoohhkrdgtohhmnecukfhppedvudejrdegfedrudektddrudehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudelkegnpdhinhgvthepvddujedrgeefrddukedtrdduhedvpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopegusghurhhgvghnvghrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (217.43.180.152) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A91240D796D10; Thu, 16 Dec 2021 15:37:00 +0000
Message-ID: <b9655a10f2864a583ff880c810ea73a10c478c19.camel@btinternet.com>
Subject: Re: [PATCH V2 4/4] selinux-notebook: Add epub build
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, dburgener@linux.microsoft.com
Date:   Thu, 16 Dec 2021 15:37:00 +0000
In-Reply-To: <CAHC9VhT5hw1JcgqOGZdTxaVWK5mE0gKKWiPLbJ3aZts+qm387A@mail.gmail.com>
References: <20211213101622.29888-1-richard_c_haines@btinternet.com>
         <20211213101622.29888-5-richard_c_haines@btinternet.com>
         <CAHC9VhT5hw1JcgqOGZdTxaVWK5mE0gKKWiPLbJ3aZts+qm387A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2021-12-13 at 20:01 -0500, Paul Moore wrote:
> On Mon, Dec 13, 2021 at 5:16 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > 
> > Build an epub document.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  BUILD.md            | 23 +++++++++++++++-----
> >  CONTRIBUTING.md     | 10 ++++-----
> >  Makefile            | 48 +++++++++++++++++++++++++++++++++++------
> >  README.md           |  9 ++++----
> >  src/cover.md        | 16 ++++++++++++++
> >  src/cover_epub.md   |  2 ++
> >  src/metadata.yaml   | 14 ++++++++++++
> >  src/styles_epub.css | 52
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  src/styles_html.css |  8 +++++++
> >  src/styles_pdf.css  |  8 +++++++
> >  src/title.md        | 16 --------------
> >  11 files changed, 169 insertions(+), 37 deletions(-)
> >  create mode 100644 src/cover.md
> >  create mode 100644 src/cover_epub.md
> >  create mode 100644 src/styles_epub.css
> 
> I had to do some merge fixups due to the logo change, and I added a
> few missing oxford commas (*cough*) but like others I had mixed
> results rendering the EPUB on my Linux system.  Thankfully the HTML
> and PDF formats still looked good.
> 
> However, one of the more unfortunate things is that when I tried to
> read the EPUB on my Kindle it failed miserably; although oddly enough
> the PDF worked fine, the text was just a bit too small to read
> comfortably.  I think it would be good to be able to generate a
> Kindle
> compatible EPUB before we merge this.

Thanks for merging the first three patches.
As you have probably guessed I don't have a Kindle, although I did use
Calibre to convert EPUB to:

AZW3 (KF8) - This was readable using Foliate and Calibre E-Book Viewer
with no problems (however the links to the examples didn't work with
the Calibre E-Book Viewer).

MOBI - This was only readable using Calibre E-Book Viewer, however the
tables lost their boarders.

So this Calibre command converts to AZW3:

ebook-convert SELinux_Notebook.epub SELinux_Notebook.azw3

Will this work on your Kindle with no issues ?? The command format is
described in [1] and there are many options.

[1] https://manual.calibre-ebook.com/generated/en/ebook-convert.html


> 

