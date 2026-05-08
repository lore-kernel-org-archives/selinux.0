Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBBA23507B
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 01:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205568; cv=none; b=IdTL1owZ02SkysmjdyPBKBsM2wug47as2ddV6vFEfn024rJTi4rA3dDxBomE53OI3lQgzl13QsUaAUf/jFFvXpY8fGUkaARAQ6J0bzXGqEscb9BHSYx2LaNaHHBF26EGbsQ3tDVN3x7Ac9IkAahhhwDgBPNP535Rxn8aMIeZP+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205568; c=relaxed/simple;
	bh=U/l1BZnvYKRrbVyfrdt41NVZYHGPzhtS0eRX27C1GJY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X32jSBpsUu6WcfFEpX1PxawSjRc6X+Jh8eFQnwNQSV/3lvtlrVYRgumps5PhFMvgBnzBiLJTyBi+oNY8SwOBC08OCIxqcL2LjVdsiIgr4mUvwWJK7k4/1W0lVw00KmiymMSPPYd/xwkTswX5GgAcMXpcyfz/0V5uOl29NGmHkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=h2eTL075; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="h2eTL075"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 85BC824003B
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 03:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1778205563; bh=3vx+/6MzO2INVfsPUGkS8axO4z8/fXM7vK6jc/BLmtA=;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:From;
	b=h2eTL075unEN0tYKPPIWld5Qe02/ze6ni+FP+HiZ0Vv8K8hXgqAU2rWtJbB7YEXEN
	 gudS2wk0AAZRXTWfMz4Tc9UbPw9JzvwFMT/CG0nbQ5q/Z5uI9Q94hD/WLJIfM7HNXH
	 P+WiVL0+dhlRBANjhgVqh1RUnXLL5nGszSvL7HXXe5VKYR9Muou6sxOnLcq3VR7bwO
	 wugaS8Xn+FK9DrqGhGbulJxnkDqpfkDIhFFQK9sILgcg3ReDHahECOTy7WDil4sRHV
	 D84RkfLgfEaFO2JojLo9IhXWKnzN/aNPLFiFhBGwlG17k1lBNiIBzj8hSBXBeIcMqh
	 fVhtufT+Xc7bQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gBXNq0kSpz9rxD;
	Fri,  8 May 2026 03:59:23 +0200 (CEST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 01:59:23 +0000
Message-Id: <DICX9I4V9L7C.3KJTX0MUJ9CEM@posteo.uk>
Cc: <selinux@vger.kernel.org>
Subject: Re: [PATCH] checkpolicy: replace malloc()+memset() with calloc()
From: "Rahul Sandhu" <nvraxn@posteo.uk>
To: "Kalevi Kolttonen" <kalevi@kolttonen.fi>, "Rahul Sandhu"
 <nvraxn@posteo.uk>
References: <20260507213838.85273-1-kalevi@kolttonen.fi>
 <DICRV1S9SASW.2NQC19L5E71QA@posteo.uk>
 <af0KxyCu_hVF0EuH@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
 <af0ox3uY6I1LQSDp@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
In-Reply-To: <af0ox3uY6I1LQSDp@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>

On Fri May 8, 2026 at 1:05 AM BST, Kalevi Kolttonen wrote:
> On Fri, May 08, 2026 at 12:57:27AM +0300, Kalevi Kolttonen wrote:
>> On Thu, May 07, 2026 at 09:45:25PM +0000, Rahul Sandhu wrote:
>> > On Thu May 7, 2026 at 10:38 PM BST, Kalevi Kolttonen wrote:
>> >=20
>> > This overall looks like a good change. I have a few nit suggestions.
>> >=20
>> > > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>> > > ---
>> > >  checkpolicy/policy_define.c | 81 +++++++++++++---------------------=
---
>> > >  1 file changed, 27 insertions(+), 54 deletions(-)
>> > >
>> > > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define=
.c
>> > > index b73de45c..a08cdf59 100644
>> > > --- a/checkpolicy/policy_define.c
>> > > +++ b/checkpolicy/policy_define.c
>> > > @@ -175,12 +175,11 @@ int define_class(void)
>> > >  		yyerror("no class name for class definition?");
>> > >  		return -1;
>> > >  	}
>> > > -	datum =3D (class_datum_t *) malloc(sizeof(class_datum_t));
>> > > +	datum =3D (class_datum_t *) calloc(1, sizeof(class_datum_t));
>> >=20
>> > What is the point of the cast from void * here? I do realize that this=
 is not
>> > something that you introduced, but given that said cast is not consist=
ently
>> > applied, even in this file, and is a bit pointless, I'd personally say=
 we may
>> > as well just drop it whilst we're at it.
>>=20
>> That is *exactly* what I was thinking of, too. I am no C guru but
>> I remember learning from somewhere (maybe the old C FAQ?) that it
>> is in general a bad habit to cast malloc() and calloc() return
>> values because it is at best useless and when erroneous, could
>> mask errors.
>>=20
>> It is too late for today, but I will send PATCH v2 later.
>
> I actually did it now: v2 also removes the unneeded casts
> of calloc() return values.
>

o/

>> > Also, I am of the opinion that it is preferred to use *foo over sizeof=
(type),
>> > i.e. in this case *datum instead of sizeof(class_datum_t). Whilst this=
 _is_ a
>> > purely stylistic change, it does carry some practical benifits too. Na=
mely, if
>> > the type of datum changes in the future, one can't accidently forget t=
o update
>> > the call to calloc()!
>>=20
>> I know. I will fix those as well later. Thanks for your comments! So hap=
py
>> having removed 27 useless memset()s!
>
> I changed my mind about this. I simply do not have the nerve to change
> the sizeof() calls because there is always that slight chance of
> making a typo or blowing it some other way. I believe the code we are
> looking at here is very stable at this point. Changing the sizeof() calls
> would yield only theoretical benefits. So I would prefer playing it
> safe, but if you feel the need do the fixes, you are welcome to do so.
>

That's fine. Granted, there's nothing to play that's "unsafe" about preferr=
ing
*foo over sizeof(foo), but I understand not wanting to make loads of edits.

This may be better off as something done treewide as a separate patch anywa=
y,
and if so something to be mentioned in the style guidelines if it is desire=
d
such that there is some reference of consistent enforcement.

> Now with my PATCH v2, all the changes made are quite mechanical and
> we can be confident we will not break the policy compiler.
>
> br,
> KK

