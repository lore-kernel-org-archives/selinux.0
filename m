Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161973C553B
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097214; cv=none; b=Cr+qIr31l3xkA8e6U0/IJZ8zTAZ1FdWVlFY1QVYfYdhgOE/cfBh6zWOgZVLIgySr3dn/oXz2H9t1uLCnNOs49mpMdoGiAX4bxE+cj2TrgF3hEGb18t4JzEzg0Na0Po6G9o+zMF6eHI2YGk5+LW/Y6QAnRFHky+RArxeZK3FKa+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097214; c=relaxed/simple;
	bh=dbuwB8W0NdXjqMe2BxalAKe6Nrz19I5lCClH6Qt2RTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZrNBVL6E5DnPfzEznSGezZSBwxTmQjApAaFlnSeDM3I7h+CX1gY6zN75DhorZKJEBYiInvtOSfs+6tp/WjW7m3xYdQCJd7AnCYH4jQ2ro+hMnPGVwOMwhD6KNSO1ffd0P6+kGfDqDyCsBiKUl7NqnfWW4holW8AGHK6tot4/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=ONXkbLgK; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="ONXkbLgK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7QamzZuG2FEZ8q2qR6L+B2N8xNnQoWE2ZGOxrdOMA3c=; b=ONXkbLgKsgePdNLGUjSK0QF+rr
	JuQ7GJ14xOYdqker4FqdLhGCK5TU9kQsUvGspcM9Aw1OnaOEf/MLYCLUo7PZcfLHMFos+CFtMIZth
	o/Abr/lDk5Gf5mBnis+RjVUc9QPxIIhlyea4aETT0AK3JAfwfMB/PO9ALUKT3PHY1qYoy5ML/6keE
	4Ft4fkRdkQY1UkqxNBI17cGhOPiAwn8xrvkJmBbanBzeelwLfiioiKAHvsaZZCrG6/p/K+kXChq2N
	szTXjk1C3VZilsUBoGSrXoA5259IMWbGW2sbowC79/caWekJeXXta6phVBWMADZKnozwrL+eVGCWI
	y0S/vMvQ==;
Received: from [87.95.76.183] (port=4565 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wXIRJ-00000008A63-1bbd;
	Wed, 10 Jun 2026 15:53:50 +0300
Date: Wed, 10 Jun 2026 15:53:42 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com,
	omosnace@redhat.com, netliomax25-code <netliomax25@gmail.com>
Subject: Re: [PATCH] libselinux: avoid out-of-bounds access on zero-length
 lines
Message-ID: <aileVqzUPbBsNwlo@AA-94-54-42-0F-E2>
References: <20260610122735.5486-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610122735.5486-1-stephen.smalley.work@gmail.com>
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

On Wed, Jun 10, 2026 at 08:27:35AM -0400, Stephen Smalley wrote:
> -		if (buf[strlen(buf) - 1])
> +		if (buf[0] && buf[strlen(buf) - 1])
>  			buf[strlen(buf) - 1] = 0;

While making these changes, I would suggest always using '\0'
instead of plain 0.

br,
KK
