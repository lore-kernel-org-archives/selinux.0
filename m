Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CB21362
	for <selinux@vger.kernel.org>; Sun,  2 Jun 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717346438; cv=none; b=g26AKZ5bwRLo8xI7fsqx/EPel5dKpWsiI00fPUPZpRbWQeoYqicm9fX9Bb+kGYhBIx4Jw2DvVJXoLlEhzwzOQpIy6sKFvUWnFnn5Wf321W2MBPe4abL0XhpsuKPc+Rr1G+URVBM1RJ5sGQwkUIV8uYLCCa0EKPDdWnv06phzxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717346438; c=relaxed/simple;
	bh=ekooY0k2u40Xrb/QBXJym9d+uZigX4j8Q1vFb7AO1/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBw7KdA3Iv2D4GyBlzYoQ1wBLsUh/iRC+UhTlfPZ2o5myw1dMpZrviwU5vO02jIFgu3tEF3w7phmGZLpfoAOZIku7JbBGWpa4+vCukhNvCZTDEKgr3857yOTIFz9Ss7llWe3KmkaNNQ4qzs2BPpb3JBhRkYadkYsFqk/t09owzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XI6hJc5i; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XI6hJc5i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wM+46XNyhhnly3asZ7mT7mOkF7JgwXvdPkqZq868jKE=; b=XI6hJc5i3t5eYbkv5jc1QVYKCv
	Bjz1HfGW5aRzTUl/cQLrVP/6bSkfcqwg9WcoKOUrVlMq+SLALf7qbIs/ZosXd/tgviq9Ze5c1eGPY
	HprxVlp1nmL5wdFHr67jJw4rV3Od77i58WmrdUUq4TCREX5m8NKBGalTXrnnlLBGpNrmgUVpAuHBY
	Ke+bW/msuyqkSlww6PNq5EaSx8K7c9gqCYfjtKrHeKcM5BdUvB1kpx7/+6reEdjgYH+4ueQZrivHV
	5o0qCKqEmemTm+aLXDJIpzYECDqMS0gLPjXPoNe7NTKsnVoLrklPJSTgfsj4ldf8rZt8gRDzQz/lR
	J+pvzbFw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1sDoFq-005qrX-Nz; Sun, 02 Jun 2024 16:40:22 +0000
Date: Sun, 2 Jun 2024 18:40:20 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: Petr Lautrbach <lautrbach@redhat.com>, 
	James Carter <jwcart2@gmail.com>
Cc: Steve Langasek <vorlon@debian.org>, 
	Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>, James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
Message-ID: <6obaf7iqj2jsm2dvu4gpvym2dihyw5kehr6ygny322tyh5fbka@uvo66lyivom4>
References: <Zc6tzKPsYZRICHya@homer.dodds.net>
 <202402171351.439742DA@keescook>
 <ZdF0no51QNtKq8Ri@homer.dodds.net>
 <Zdrh/euXdvdWlVSp@homer.dodds.net>
 <CAJ2a_DeQFFgo+b6xf3_79bsfsvWeGWOephtgsJTK+RxJ7epG4Q@mail.gmail.com>
 <Zd2IcMMLagkTZGJp@homer.dodds.net>
 <CAJ2a_Df75EDn27iHSg=aAh0ZzRE40SqyanzRkfzv6ETmFiE8ug@mail.gmail.com>
 <Zd7OnevwfxbiJUVj@homer.dodds.net>
 <877cipc5d5.fsf@redhat.com>
 <ZeQuOBwQ2eSbkUAS@homer.dodds.net>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeQuOBwQ2eSbkUAS@homer.dodds.net>
X-Debian-User: zeha

Hi,

* Steve Langasek <vorlon@debian.org> [700101 01:00]:
> On Wed, Feb 28, 2024 at 10:20:22AM +0100, Petr Lautrbach wrote:
> > Steve Langasek <vorlon@debian.org> writes:
> 
> > > Since all of your comments have been about the mechanics of the patch
> > > landing, am I able to take it as agreed that libselinux will add a new entry
> > > point of matchpathcon_filespec_add64@LIBSELINUX_3.6 in the next release, and
> > > the rest is details?
> 
> > Technical detail: next release will be 3.7 therefore I'd expect
> > matchpathcon_filespec_add64@LIBSELINUX_3.7
> 
> Ok, patch updated.

Is there something blocking applying this patch to libselinux?

I cannot see it in the history of selinux.git, so far.

Thanks,
Chris

