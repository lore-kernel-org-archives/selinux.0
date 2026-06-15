Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDD3F8EBE
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543501; cv=none; b=Ynh26iwbuM1FeyPKV7k935mCB2DNm+eL0J5zNptwumKadlwWwexHfFph2EdgDxTpLBms1WgYhX1NJc0oYCiqeTEpEXllRlhfa6Ukb5RV6TmTgS+i5qsuCldPCSkVERQ0e82T5l+jzHWiEAs4gCnYryjqcmIIswOyigTYH+i97GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543501; c=relaxed/simple;
	bh=PaVj2iL5jNzoxgHgjYeWHRCa6/kRpHcP//7H9D/A+3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgb4M/up/28QqZkw41AplEZs0tieygyUo7t8rqOFzRqHiYtd6q+T/Cu7x0Um2jXAIr80MzN2snTN2wOvnawMKzWNyij/YszuI0OMj9GqJHuHQjoOMlGm7YD5ZB874VGcpZtVJUD+hQv7lg6YyIreQj25JvxrtJjJ3m+ANaDZ+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=uEFq8YkX; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="uEFq8YkX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j3PMvM1XAFqllQnx5XEmuiGg6BQUT0HXfhJ0ic7x7aU=; b=uEFq8YkX3NXqCXDaTIjx0LE13i
	VwIEKk4pWNYaFLwYiOdGmuAshnhKYjb/amYfYd3hIGzqUKXJmrHW2f5J0yORTomzlb2huOEEbLo/j
	tqT848Aot7kgcZ6MY1ZnMWrNGrGD2UuSjh+fsPaV4JFIAp34uOu6VWx48lQLKbOST2MGLZyCMDgk6
	b0ZOU0DKSxDO3ILNqjvJJehZLseKyiyv/8YsrIP2njw0O8ijfrPHJnhnbTiQm6ltpneEPjGXr/hb7
	DyW7P72QFjHjWmEtFXcyQiPuYvG5HQmbouU0Zj+8g4nbn+mSc2m8oUiLXIo/S0DAmeSUn6v3ZJmM+
	lrInUrPw==;
Received: from [87.95.76.183] (port=4096 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wZAqY-0000000DQ0L-47r0;
	Mon, 15 Jun 2026 20:11:38 +0300
Date: Mon, 15 Jun 2026 20:11:36 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] policycoreutils: use bool instead of int
Message-ID: <ajAySI0DK8a86hJf@AA-94-54-42-0F-E2>
References: <20260614162323.18730-1-kalevi@kolttonen.fi>
 <CAEjxPJ6C7ST4B6Xuq1dvE7Bx7EuZ1NVzh6yE7w0VRziXKHORiQ@mail.gmail.com>
 <CAEjxPJ58UmimfTz9VhOVbUyGEyGWA7G5SfVs1iRf03-Fnfe9sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ58UmimfTz9VhOVbUyGEyGWA7G5SfVs1iRf03-Fnfe9sQ@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Mon, Jun 15, 2026 at 01:01:07PM -0400, Stephen Smalley wrote:
> On Mon, Jun 15, 2026 at 12:58 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Sun, Jun 14, 2026 at 12:23 PM Kalevi Kolttonen <kalevi@kolttonen.fi> wrote:
> > >
> > > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> 
> By the way, note that several of your patches had exactly the same
> subject line even though they were modifying different files or
> components; it would be better to either combine them into one patch
> (if a single logical change) or use a different leading prefix to
> indicate what they modify.

Yes, that is admittedly not so good. I was going through the
source file by file so that is why the similar patches were
not combined under s ingle one. I will try to be better in
the future but I have already deleted all the local branches
that I used to generate the patches.

br,
KK
