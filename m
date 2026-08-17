Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF114B0491
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984195; cv=none; b=TZgIkZCzzXhp4ECcW/vn0vQyahoT4lDaHyj/STXvF5Dep6RrfRPb9aje4yPEu4VAPZa23X2uKY28VN9xYofpS7Gha6dLxnpxOC8x4sTehoDB0ID9R5Z1JCCxERpYFOezNLHJZULwkPGmWXa3+vLyk+G2KzXOtvbfvfeTspoS+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984195; c=relaxed/simple;
	bh=xDMAJmy0gbrzM0wJGRld3yMSFvep7ljY1wRGjG/jmBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE/JHYxiE0gqgm7/rxQ2hnM9R1b1sedOmfsz7knFDxWUHkhxPPN2sD8dK+q4YBLEbn4mGn0ozX7bR/42aFQz6h8BACYmVjaHz+1aQe0Nl4O/4Ud+hLr1ikPa6oLEnHZVfNc0wagvi5legPLUfBNZI2J6Tq8258Gy7j89pHnrev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=UhyYNKih; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="UhyYNKih"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xDMAJmy0gbrzM0wJGRld3yMSFvep7ljY1wRGjG/jmBk=; b=UhyYNKihe2Q89oHqBwSgtkD4CJ
	6DETPpVYAlp/NcEFef7UNER4So/GTKdrllnmh3mSjlBbaqSpo8xUOdFXuHeYwQ53HQB4WqGl/IkQy
	UWAyaU//qnhlPVr+rm+LmH/Tq2Y00rDEeG3KA4BvfKM2H8OMqnToonRRSugfsHzvvR21n4RJ4CQvj
	ZYTGdDZp8txLiTQcpkKdrtebTl4/kbv2S8eM8JKhjQ8sMhMILQkyNQ1i5UA4ocGQwyHXlfzpVK6gC
	uomNdA/bpdLMfrIeM5veZpal+VHccCsacqvjp2TyScnBBDu4/7CxtipsCdHwKI6HRwGr5hy/QwPlC
	p+yjX0ww==;
Received: from [37.33.224.119] (port=33918 helo=AA-94-54-42-0F-E2.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1ww0DY-0000000Ftqd-1kRY;
	Mon, 17 Aug 2026 19:29:43 +0300
Date: Mon, 17 Aug 2026 19:29:41 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] libsepol: use bool instead of int in validation functions
Message-ID: <aoM29Zl_a5VU1HiE@AA-94-54-42-0F-E2.local>
References: <20260814230432.53831-1-kalevi@kolttonen.fi>
 <CAEjxPJ7diECpC9H+ceKZwZzDVXQ9bbn5R37P+uD8JnpBe3jVyQ@mail.gmail.com>
 <CAEjxPJ6AH+PyS5v80_Q6v3Gx3AOmb3r1X=hnGf5pan=wGHbygQ@mail.gmail.com>
 <CAEjxPJ6NGxMic8PVrHZX6OtUMewp+WSfqsc2KDLso5=nKdUHng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ6NGxMic8PVrHZX6OtUMewp+WSfqsc2KDLso5=nKdUHng@mail.gmail.com>
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

On Mon, Aug 17, 2026 at 09:58:27AM -0400, Stephen Smalley wrote:
> One last reason to not apply this patch: it makes the code less
> consistent, not more, since as you said, you don't convert all the
> functions to reduce the scope of the change. I'd rather keep it
> consistent.

I never claimed this patch would achieve more consistency. The
basic idea was just to make it explicit that these validation
functions are essentially boolean in nature: either the validation
succeeds ("true") or not ("false"). So using int seems wrong.

But I do get the point that it is cleaner to have all the
functions have the same return type. I consider it one of the
design errors of C language that it did not have boolean type
right from the beginning. It is what it is, though.

br,
KK
