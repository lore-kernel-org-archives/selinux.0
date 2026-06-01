Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC65382381;
	Mon,  1 Jun 2026 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342439; cv=none; b=V2fXAaoThjskQRN//oeNssFXtBSuoxkRVA0eRashb78RZONjKq/9rn/j602wenC0df2GuV6nvnkLczj8Md+eks97C4nW4Kw/o23NmAgSnQaknsiA5Zpy9iFUCh2c8d3EZjEAtO7zv2g3KTnbC/gdhb6ywmfoQxbrKRhNNpuSBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342439; c=relaxed/simple;
	bh=D1fkIzQZJO47jC7y/OevTQFQuDvcmhOoPQIfTQu2beQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqJHxYnLftBYORoMtCl1XOC31lh2kyUzgjt8JYPnfXyZ32IxETYSiXj/n/Jd7ndyW9OF0GgWIxCa2APlHLHtXq6Oqr3V8D+hRVw2YWfhAGP2CaKn34ZujSOp+ixKynxCDkY2d05PtB/+KBG/oe6e7aMy2B2px/OrPEtpnutdjM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=G3gG00ZV; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="G3gG00ZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1780342426; bh=D1fkIzQZJO47jC7y/OevTQFQuDvcmhOoPQIfTQu2beQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3gG00ZVQUC8388zGT/IntiBJWEv36GQ2xAcD8ZQLpN4P3VZCGWNj49CGcxw6cvhP
	 9OQbpb78za2sNNdbYmR1yyL6ezx7ExiL4JrvgqFk4CanZYxfNgqWQe3wwLMkWfyfSC
	 E7PqSeXs4B9vY8j0W8VfkdXewYz9ApCJeYDrzBeT6zmbTxStuVMBcxvCAljTaedyih
	 vYutv8ggDLiduK4b30nAbUjs402QUl36aH0t59Nt1HD5YJ2jG89yKG9ZfHU8fNGQ+n
	 mNegTTSWRzL42AeELlUf6k7Cn6m6N4cGpLenWnB3Xbheiq6ILtFEYzT/TYQuD1TCfI
	 D76NYGHLt7wfg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id E3C93481; Mon,  1 Jun 2026 14:33:46 -0500 (CDT)
Date: Mon, 1 Jun 2026 14:33:46 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	LSM <linux-security-module@vger.kernel.org>,
	SElinux list <selinux@vger.kernel.org>
Subject: Re: security_task_prctl: why -ENOSYS
Message-ID: <ah3emjW3jOzQEX0/@mail.hallyn.com>
References: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
 <CAFftDdqp8b5n21hdEP6w0-PK+CoG7mmQxgrnhpBLU7-1GZxniw@mail.gmail.com>
 <090a355d-3680-4113-a542-ff3b1c565f58@schaufler-ca.com>
 <CAFftDdqvvqrbm=+XsDdkJHdm12jxK9799_A=Txz6Q5goYC2ALQ@mail.gmail.com>
 <ahoaFz8DMMvWgqL+@mail.hallyn.com>
 <CAFftDdqyTrr=wS2hUT1EvAqVsbegPRh9Y-rH5S3VEpvXbJ6QRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFftDdqyTrr=wS2hUT1EvAqVsbegPRh9Y-rH5S3VEpvXbJ6QRg@mail.gmail.com>

On Mon, Jun 01, 2026 at 02:01:07PM -0500, William Roberts wrote:
> <snip>
> >
> > How about security_task_prctl_allowed()?  (Mirroring security_uring_*)
> >
> > Renaming the existing hook security_task_prctl_handle() also wouldn't
> > be too bad, but that's probably more churn than it's worth.
> >
> 
> Yeah if something else is already done, I'll just copy their
> convention. I went with suffix _check for now.
> 
> Another possible issue that I think other upstream communities may
> have with adding an additional hook, is that there will be two hooks
> in the prctl syscall path,
> I am not sure if that's a show stopper?

It's not a hot path, so I wouldn't think so.
