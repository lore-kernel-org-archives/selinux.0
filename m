Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B503101A7
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237941; cv=none; b=jSNQcgO9yH8q/oJ9/tQNSlA9G+BJVNoRscVngSGs50NUZowUQVV7EcT5aeK74dufGaN+d3WNWmqazLP18MKdMwUKdgx47SHoojwSCt/pFmOmQyETvJl5rpBCrxumhyQ0L0MCiO98no0+vGXo+bNRoc+pWnCTBCVo+MfPctzhvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237941; c=relaxed/simple;
	bh=hyxAwhiEFR4VtHdo+e5dh4ceyzjam1cb/yPfdCCcv78=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=NTp1LKpdU2N4i8ZapDgF3iGax9nilM49KpW7WtSbotUgqU0Z38aEdclqVQnD/Jo3hiIcVGTfbelaJOVupH6w/i4jMzgHUbIoOVoIL7/5EGU5fXg01JSZCWkRkzu1i9a7HQL22terVD6FvBx+lTjZUKHlzgBoxtyvF+xQoeTMVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=nu3whyuM; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="nu3whyuM"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 19DDE2407F6
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 12:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1778237931; bh=hyxAwhiEFR4VtHdo+e5dh4ceyzjam1cb/yPfdCCcv78=;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:From;
	b=nu3whyuMjVbkWIAHs0Rpmc2kuSaqYS7c+rxgWvQS1PUQV/5HB0Uo+YgVyJ77BcbOE
	 i2L39Qc0Mdb2Jwc8V74c+rcdjfsCzTXdkws2ry9JlEkc+947Z48Gzc0yDBflbjQWVn
	 5q7EG0XC3Pj/L3tn0rCUFksaH7nkontBULRhHncKDrauYSwy/WZv4lPEu/ojjUKAUd
	 Vh1xBNnQ/cVfU39BgQFwjJkxo3A2fIIqSRUSeqFjevQWfoKV0zrwDzzXz+qVabBMdY
	 HfjSpQCvDXhKvBZWFFxKzQUu/YqEqqkTUt2ZpDkzQCUf+SDMCJdFopLNqhgcQjE5mb
	 Yb5Tc6b4Xwvnw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gBmMG4Cfjz6trs;
	Fri,  8 May 2026 12:58:50 +0200 (CEST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 10:58:50 +0000
Message-Id: <DID8QJHTR64F.1P933P9Z03623@posteo.uk>
From: "Rahul Sandhu" <nvraxn@posteo.uk>
To: "Kalevi Kolttonen" <kalevi@kolttonen.fi>, "Rahul Sandhu"
 <nvraxn@posteo.uk>
Cc: <selinux@vger.kernel.org>
Subject: Re: [PATCH] checkpolicy: replace malloc()+memset() with calloc()
References: <20260507213838.85273-1-kalevi@kolttonen.fi>
 <DICRV1S9SASW.2NQC19L5E71QA@posteo.uk>
 <af0KxyCu_hVF0EuH@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
 <af0ox3uY6I1LQSDp@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
 <DICX9I4V9L7C.3KJTX0MUJ9CEM@posteo.uk>
 <af2K83UGkQhVYEJz@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
In-Reply-To: <af2K83UGkQhVYEJz@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>

On Fri May 8, 2026 at 8:04 AM BST, Kalevi Kolttonen wrote:
> On Fri, May 08, 2026 at 01:59:23AM +0000, Rahul Sandhu wrote:
>> That's fine. Granted, there's nothing to play that's "unsafe" about pref=
erring
>> *foo over sizeof(foo), but I understand not wanting to make loads of edi=
ts.
>
> Thanks for understanding.
>
> In principle you are right, but I am just afraid of missing something lik=
e
> '*' in some call site and then accidentally allocating too little. The
> last thing I want to do is to break something, although it will be
> inevitable in life in general.
>
>> This may be better off as something done treewide as a separate patch an=
yway,
>> and if so something to be mentioned in the style guidelines if it is des=
ired
>> such that there is some reference of consistent enforcement.
>
> Well, it is a matter of common sense to prefer calloc() in contexts like
> these since it is only one line of code versus two using malloc()+memset(=
).

By this pattern, I was referring to *foo over sizeof(foo), not your patch;
sorry for the confusion.

>
> So it is probably not worth it to single out this pattern in guidelines.
>
> Please let me know if you are ready to accept further changes to the
> file policy_define.c. I went through the file and found some miscellaneou=
s
> minor things to fix there (i.e. unneeded tests that can be safely omitted=
,
> most importantly three missing checks for memory allocation failure, some
> code simplification by preferring strcasecmp() over two strcmp() calls,
> and one malloc() cast removal).
>

If you're making a number of refactors, you might prefer to send a patch se=
ries
for them given that they seem to be related.

> br,
> KK

