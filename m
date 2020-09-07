Return-Path: <SRS0=D1eb=CQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73438C43461
	for <selinux@archiver.kernel.org>; Mon,  7 Sep 2020 15:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E112078E
	for <selinux@archiver.kernel.org>; Mon,  7 Sep 2020 15:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="WCHqsYMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgIGPWI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:22:08 -0400
Received: from mailomta22-sa.btinternet.com ([213.120.69.28]:29405 "EHLO
        sa-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730090AbgIGPVV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Sep 2020 11:21:21 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20200907152049.UOUF26396.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Mon, 7 Sep 2020 16:20:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599492049; 
        bh=iFQuko6eT1pt71ugbLOE+VUueYvNb2Rg95cfG4L9Ffk=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=WCHqsYMne2IuaeAUYL+8C3XRtHZnu2ySDgcU8PLT8MfHW+J4FaWIzZvln2WrdcEksG/TXd3VDFopR5BaYuwUO4w3WcYGlaw6dv5KH5vfBH61lTSWlnoIMKm6YrX9eslPDdnB7xQ77xUhK1j3mZvJKFdWfrxNjCGUovQHpjtWO5YDudoV4tGn1MZRzdGwQAigYAkN7BJQMEbMdMIeLjWElAkCGAmWaqiJaUwAzJ1t+4gY70IaAwSuEVPoOipuM5zCctJMI41eGu1+oYTZplS5sUzjaXxT3641Sh8HnVFFTYfaAZvGW3cq13+F4KR+K1b+mvZiQsDe1xHQ2wHnz9/hIw==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.147.13.255]
X-OWM-Source-IP: 86.147.13.255 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleevtdeghfefvdefjedvjeeukeduteejjedvvdelgeehueekudduieegudfggeeknecuffhomhgrihhnpehgihhthhhusgdrtghomhdpihgvthhfrdhorhhgpdhlihgsrhgvshifrghnrdhorhhgnecukfhppeekiedrudegjedrudefrddvheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrudefrddvheehpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeothhoihifohhtohhnsehgmhgrihhlrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.147.13.255) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0FC2A4F4; Mon, 7 Sep 2020 16:20:49 +0100
Message-ID: <ecbced32f4cf284f7a8d7f71369c1330bff6465a.camel@btinternet.com>
Subject: Re: [PATCH] network_support: Update LibreSwan configuration
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org
Date:   Mon, 07 Sep 2020 16:20:41 +0100
In-Reply-To: <030e2ae3-0f2e-3fed-a02a-142c3eec681b@gmail.com>
References: <20200906152721.16448-1-richard_c_haines@btinternet.com>
         <030e2ae3-0f2e-3fed-a02a-142c3eec681b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, 2020-09-06 at 21:11 +0300, Topi Miettinen wrote:
> On 6.9.2020 18.27, Richard Haines wrote:
> > Update ipsec.conf file that describes the labeled ipsec entries.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > This was used to test the updated LibreSwan that now supports
> > selinux_check_access(3) from https://github.com/libreswan/libreswan
> > 
> >   src/network_support.md | 38 ++++++++++++++++++++++++++++++++++++-
> > -
> >   1 file changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/src/network_support.md b/src/network_support.md
> > index 36af1f4..4a3fd38 100644
> > --- a/src/network_support.md
> > +++ b/src/network_support.md
> > @@ -452,11 +452,45 @@ Context type identifier has never been
> > defined in any standard. Pluto is
> >   configurable and defaults to '*32001*', this is the IPSEC
> > Security
> >   Association Attribute identifier reserved for private use. Racoon
> > is
> >   hard coded to a value of '*10*', therefore the pluto
> > ***ipsec.conf**(5)*
> > -file must be configured as follows:
> > +configuration file *secctx-attr-type* entry must be set as shown
> > in the
> > +following example:
> >   
> >   ```
> >   config setup
> > -        secctx-attr-type=10
> > +	protostack=netkey
> > +	plutodebug=all
> > +	logfile=/var/log/pluto/pluto.log
> > +	logappend=no
> > +	# A "secctx-attr-type" MUST be present:
> > +	secctx-attr-type=10
> > +	# Labeled IPSEC only supports the following values:
> > +	#   10 = ECN_TUNNEL - Used by racoon(8)
> > +	#   32001 = Default - Reserved for private use (see RFC 2407)
> > +	# These are the "IPSEC Security Association Attributes"
> > +
> > +conn selinux_labeled_ipsec_test
> > +	# ikev2 MUST be "no" as labeled ipsec is not yet supported by
> > IKEV2
> > +	# There is a draft IKEV2 labeled ipsec document (July '20) at:
> > +	#   
> > https://tools.ietf.org/html/draft-ietf-ipsecme-labeled-ipsec-03
> > +	ikev2=no
> > +	auto=start
> > +	rekey=no
> > +	authby=secret # set in '/etc/ipsec.secrets'
> > +	type=transport
> > +	left=192.168.1.198
> > +	right=192.168.1.148
> > +	ike=3des-sha1
> 
> Since this configuration may set an example for less experienced
> users 
> who may just copy this without much understanding, would it be
> possible 
> to use a more modern crypto algorithm? Also libreswan documentation 
> tells that sha1 will be obsoleted in near future. Would something
> like 
> "ike=aes_gcm256-sha2" work? I don't have a working libreswan setup.
> 
> https://libreswan.org/man/ipsec.conf.5.html
> 
> > +	phase2=esp
> > +	phase2alg=3des-sha1
> 
> How about "phase2alg=aes_gcm256"?

Thanks for the feedback. It appears that racoon does not support aes
gcm types so I've changed them to aes256 and added some comments. This
config does work LibreSwan - Racoon. Is this ok ???

...
	ike=aes256-sha2		# See NOTE
	phase2=esp
	phase2alg=aes256	# See NOTE
...

# NOTE:
#   The encryption algorithms should be chosen with care and within the
#   constraints of those available for interoperability.
#   Racoon is no longer actively supported and has a limited choice of
#   algorithms compared to LibreSwan.


> 
> -Topi

