Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E184227EBA
	for <selinux@vger.kernel.org>; Thu, 13 Feb 2025 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447344; cv=none; b=NfMhMO/PLdEbw8paiL2V3H6OCH2sAgnNE2rjUVoESvHL1IkwBHK+TadMmopxNG4x6q6APFFhoOs3jTMmhCJMXxkUd09TAS7BO5B3UXJAXjqB4oUQfEHNzkCifpoNT1GY0xHWH9MoIXU2lKQiDtvP3bJPpsMCauVLZC/w3FFvFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447344; c=relaxed/simple;
	bh=unEIe0CTSPFmARaE1uLGvzPg9lrOWLZ6TMTBfCEbXAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fImZEsUv58nJDsYyeX/8BaNtPCQyyVaMWNq/chlInfG3A9lcGQeo09w5myDHxcSIl2yAK9FpL8Bh4dURaXixN6uoQ3j4WfdgXAth25Mymxodzo/tnU7P6J/qh9OW8d1+8bTDQwdCMQHqvLf7FwMpaqgklIocBRADCm+rYneSSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=IDhod/uK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7WulbCU; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="IDhod/uK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7WulbCU"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1FB525400CC;
	Thu, 13 Feb 2025 06:48:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 13 Feb 2025 06:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739447339; x=1739533739; bh=KazkcGk/i4
	GJMki4G6b9xYw0kzvs9pexxPM2VGuc1ng=; b=IDhod/uKDW1QHxpR0D6nYnerUW
	inpLiH/bups1O6mr5MKUr+VDmQwGXgdgYx4vEFbJEFx9xqSKYZSR0HmlDRbdNNXF
	9p0vEP2LNgBE3K83epqTwaA/G4TMM6FS4R/OhQZ1uyf/2t7pUQCV/AWVL4a/0l3p
	IZrOM36lxj2jco2xRKXWXrrjchcd96PMuprOS0bkCFFBF7dnycvx5KjDEIh/uitu
	2k8coi0oxTE2w6JDyPBlCFl8VNcp7lBOBxRFqMN2dg5hosdayV9v2rMwNOvAv9vl
	Ztzud9Bmz73H9eIg1+zGB5v0ktPLb9r6sAkMCRdgvXPhDIIEYRARA3oftVjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739447339; x=1739533739; bh=KazkcGk/i4GJMki4G6b9xYw0kzvs9pexxPM
	2VGuc1ng=; b=S7WulbCUytYJhhBlCncRFOZGttINLtxJLWfTC8WTF6W0H5Pqm1t
	LnJflyvHgaXL/8LUpFS9xWgSrDKCzJr2HXYfh+E9XxwxZhkogW3UDY+nzWHVSy03
	rYA40U4lJ3vEzEuPWWk0O/tFFffiOqEcpcyOzUZ0TOSmVOlI+LFa9sV5jsastH4a
	M8rTst17a8i/151wLdjVP+d4n+EtO50VSKA17eAHJJE0CpVfLJn1wgKVF4sil+gS
	nwiLLBdPtYyXhQCp3fprRE0M1usXECLt5umJCucNpJpQrksi9b/0p0NJay9P4sCq
	TRzf6FvZ73qfSwjfj+5VfGU08peF1qtuofg==
X-ME-Sender: <xms:K9ytZ6RmzX31ttgiQ1xGcvnH2KpUWIE0-B9UIj1DsxTpbA59aT1xlw>
    <xme:K9ytZ_wn0jkFTgkTUdqFL8W5sE5uEIbFnZHjYmmB2zeKvbiMApr_Dchf_iKAAosmo
    S2IlZ_vg0brUhLmqQ>
X-ME-Received: <xmr:K9ytZ33GF8qvj46dLwp10lTcgBWHuFsTSbna1TjglQhI7aDWZgbKoczE086C2a-2Q6cu6KT8lYUR8yJPrG-LGt2FDXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgesghdtreertddtjeen
    ucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecugg
    ftrfgrthhtvghrnhephfeugeelkedtjefhudfgfeelleeltedtfeejvdelieffkeevudfg
    veegfeevteeinecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhs
    rgdrihhspdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegusghurhhgvghnvghrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghp
    thhtohepnhhitgholhgrshdrihhoohhsshesmheggidrohhrghdprhgtphhtthhopehsvg
    hlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:K9ytZ2A9kw4BOIkIhHEWS2_sDFG1ALm43wXR1C-HwM2nZcgPrlFLNQ>
    <xmx:K9ytZzgmmY79nhL5KJlpl8gsW5od-IDwoEIK9jR_gUbmWAWHloWmDQ>
    <xmx:K9ytZyoyEpyf8JtUWdN3Prmt9XxLT5hQcGqMaMmTMjfyDI6NFapSTQ>
    <xmx:K9ytZ2ipJuo_xDPR3Z8dKoAkja6QXTHUSA7O4POavR4xhY5S6VPICg>
    <xmx:K9ytZwvzOqfC0XAMvk6qmDuUEky6D16u1h4MIN_IxXUgJ9u1Dry-TgJy>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 06:48:58 -0500 (EST)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id 704D44E8FF3A; Thu, 13 Feb 2025 12:48:57 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] Support static-only builds
In-Reply-To: <06fd3492-f8b4-4b68-aeef-fd38f6f3587c@linux.microsoft.com>
References: <20250211211651.1297357-3-hi@alyssa.is>
 <9316b48f-64f0-469b-8dde-1386aa13d384@linux.microsoft.com>
 <87a5aro74k.fsf@alyssa.is>
 <d36501b0-e546-4de6-aa73-85613b276366@linux.microsoft.com>
 <06fd3492-f8b4-4b68-aeef-fd38f6f3587c@linux.microsoft.com>
Date: Thu, 13 Feb 2025 12:48:55 +0100
Message-ID: <871pw26p5k.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Burgener <dburgener@linux.microsoft.com> writes:

> On 2/12/2025 10:11 AM, Daniel Burgener wrote:
>> On 2/12/2025 4:16 AM, Alyssa Ross wrote:
>>> Daniel Burgener <dburgener@linux.microsoft.com> writes:
>>>
>>>> On 2/11/2025 4:16 PM, Alyssa Ross wrote:
>>>>> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
>>>>> index 32ad0201..7acd51dd 100644
>>>>> --- a/policycoreutils/Makefile
>>>>> +++ b/policycoreutils/Makefile
>>>>> @@ -1,5 +1,10 @@
>>>>> =C2=A0=C2=A0 SUBDIRS =3D setfiles load_policy newrole run_init secon =
sestatus=20
>>>>> semodule setsebool scripts po man hll unsetfiles
>>>>> +PKG_CONFIG ?=3D pkg-config
>>>>> +
>>>>> +LIBSELINUX_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libselinux)
>>>>> +export LIBSELINUX_LDLIBS
>>>>> +
>>>>
>>>> I think that in the DISABLE_SHARED case, the pkg-config command needs
>>>> --static as well.=C2=A0 I tried your patch, and I get errors that the
>>>> downstream users of libselinux have undefined references to libpcre2,
>>>> and they are being build without -lpcre2-8.=C2=A0 Based on the pkg-con=
fig man
>>>> page, it looks like Requires.private libraries are only included if the
>>>> --static flag is passed.
>>>
>>> I think it's generally expected that the user set
>>> PKG_CONFIG=3D"pkg-config --static" when they want static linking.=C2=A0=
 See
>>> e.g. <https://bugs.freedesktop.org/show_bug.cgi?id=3D19541#c3>.
>>=20
>> Thanks for clarifying.=C2=A0 Yes, this command builds everything for me:
>>=20
>> make DESTDIR=3D~/obj PKG_CONFIG=3D"pkg-config --static" DISABLE_SHARED=
=3Dy=20
>> install
>>=20
>> However, the binaries still appear dynamically linked when I investigate=
=20
>> them with the "file" command.=C2=A0 Am I missing some other step?
>
> It occurs to me that I've possibly misunderstood the point of your=20
> patch.  This is just about not building the shared libraries,=20
> independent of whether the binaries are statically linked?

Yes.  The purpose of this is to make it possible to build using a
compiler that only supports static linking.  In Nixpkgs, we have a
special mode where a package and all its dependencies can be built
statically, and my intention here is to be able to build packages that
depend on libselinux in that mode.

Would it maybe make more sense if I split this patch up, so one patch
just makes it possible to disable building shared libraries, and another
fixes building using only static libraries?  Originally this patch was
only the former, but then it grew=E2=80=A6

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCZ63cKAAKCRBbRZGEIw/w
ol+lAP9kiFjSJ4wACEb95nzyOJo1rcz28mAKImFwB44GvammPAD8COJZhAYOoDkh
MEczm2O6bfUrroRNQfVvCdgJPT8HAA8=
=Y2Ts
-----END PGP SIGNATURE-----
--=-=-=--
