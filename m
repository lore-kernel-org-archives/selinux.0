Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2987C433F5
	for <selinux@archiver.kernel.org>; Sat, 11 Dec 2021 16:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhLKQly (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Dec 2021 11:41:54 -0500
Received: from mailomta14-re.btinternet.com ([213.120.69.107]:43410 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230318AbhLKQly (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Dec 2021 11:41:54 -0500
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20211211164152.MUOE24878.re-prd-fep-047.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sat, 11 Dec 2021 16:41:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1639240912; 
        bh=Sf2INu2PjBGg6zPkl0Xy/x2Vr3dzSCvg0/90n28qkuI=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=Wf9u88iyi2frS12QCj+fin8ATtMtYEP+FoyReHuWCvvTqomHEZ4GtBuvWEliqd23kGNfMzxvlQlZQddXXfR5AMcNDfd0bJErapWeCk2i9OSIjpt5Y8GBp5GF2hcE2DX7lEm5V0rd4v1wH0vz7DywTZ+R+j6cmv2/q9Sakwz3PSVWS24g2dmFWT1FXj7p1t9VRAssDt1/IQBwroiCUUTrspNHWsjELG0WSdKVTwJS4tul5HyOLDaKHjCXpwXnzyR5Wz4Bjnmw4PHvD/wtpoxf8RDwT+uofY9QBabqgjZYzSfdnvHsiVcqtFmpKw7nyQk/66mnXQIofif6whh0UmG5Vw==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 61A69BAC014854E4
X-Originating-IP: [217.43.180.255]
X-OWM-Source-IP: 217.43.180.255 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrkeeggdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepvdeiudfhvdejteffjeelvdeuvdehgffflefghfefleegieejjeelkeeljeejhfdvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedrgeefrddukedtrddvheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpedvudejrdegfedrudektddrvdehhedpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepuggsuhhrghgvnhgvrheslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (217.43.180.255) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 61A69BAC014854E4; Sat, 11 Dec 2021 16:41:52 +0000
Message-ID: <68b1b0d896d70cb9ed9b21260e5f881ee01dd023.camel@btinternet.com>
Subject: Re: [PATCH 0/4] SELinux Notebook: Add eBook reader build
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com
Date:   Sat, 11 Dec 2021 16:41:51 +0000
In-Reply-To: <95acdf19-b66a-bcbd-6cbc-7eadebfdfb61@linux.microsoft.com>
References: <20211210114340.13977-1-richard_c_haines@btinternet.com>
         <95acdf19-b66a-bcbd-6cbc-7eadebfdfb61@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2021-12-10 at 11:14 -0500, Daniel Burgener wrote:
> On 12/10/2021 6:43 AM, Richard Haines wrote:
> > This allows an eBook to be built that can be read by readers such
> > as
> > Bookworm and Foliate. Note that Bookworm does not render tables or
> > examples
> > very well, whereas Foliate does.
> > 
> > As eBooks use a different cover format the current SELinux penguin
> > has been replaced with one from the SELinux artwork repository.
> > 
> > Richard Haines (4):
> >    selinux-notebook: Make file links consistent
> >    src/images: Remove current penguin
> >    src/images: Add new SELinux penguin
> >    selinux-notebook: Add epub build
> > 
> >   BUILD.md                           |  17 +-
> >   CONTRIBUTING.md                    |  10 +-
> >   Makefile                           |  48 +++-
> >   README.md                          |   9 +-
> >   src/bounds_rules.md                |   2 +-
> >   src/cil_overview.md                |   2 +-
> >   src/cover.md                       |  16 ++
> >   src/cover_epub.md                  |   2 +
> >   src/embedded_systems.md            |  12 +-
> >   src/images/selinux-penguin.svg     | 398 ------------------------
> > -----
> >   src/images/selinux-penguin_400.png | Bin 0 -> 65728 bytes
> >   src/network_support.md             |   4 +-
> >   src/postgresql.md                  |   6 +-
> >   src/styles_epub.css                |  44 ++++
> >   src/title.md                       |  16 --
> >   src/toc.md                         |   2 +-
> >   16 files changed, 139 insertions(+), 449 deletions(-)
> >   create mode 100644 src/cover.md
> >   create mode 100644 src/cover_epub.md
> >   delete mode 100644 src/images/selinux-penguin.svg
> >   create mode 100644 src/images/selinux-penguin_400.png
> >   create mode 100644 src/styles_epub.css
> > 
> 
> Applying these patches (and subbing in a random png for the penguin 
> cover image since you obviously didn't include the binary diff on the
> list)

I did submit [PATCH 3/4] to add new SELinux penguin, however it was
bounced. The file added can be found at [1].

>  allows me to successfully build an epub and load it using the 
> Overdrive app on my Android device.  Everything I poked at generally 
> worked fine, although long lines overrun really awkwardly, which is 
> particularly an issue for tables.  For example, the table in the
> SELinux 
> Overview section overruns the next several pages and make the whole 
> thing very hard to read.  I'm not sure if thats may pandadoc version,
> my 
> epub reader, or just basic difficulties with table rendering in epub.

I've tried a number of readers and found they do vary on rendering
tables, also whether they centre the images or not. I don't see a way
around this except to add a note in BUILD.md explaining these type of
issues. Does anyone have a better idea ?

> 
> It might also be nice to populate the epub metadata.
I could update, anything in particular you would like as there seems to
be quite a few possible entries.

> 

Thanks for testing, also corrected the nit for next update
> Tested-by: Daniel Burgener <dburgener@linux.microsoft.com>

[1]
https://github.com/SELinuxProject/selinux-artwork/blob/main/PNG/selinux-penguin_400.png

