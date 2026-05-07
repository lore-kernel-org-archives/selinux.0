Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F2344DAC
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191053; cv=none; b=JG80c0dbe+2FRk8gLEdXRMFs2f4Vgega5Wd34NjN5V33SQRwaq9jrAIhmL3d21muyy3wyf8WyPaxte9ZzUHlqYt6GAD7NcttjRjUlZmY4zNztU6fa75dBokVbPn5lfdRW4BrJF2/7fWNNX5xzHoqHnWk/34y7dVAIKw1sAwiYcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191053; c=relaxed/simple;
	bh=dx9wt4/2UWaHYDIRFU8ySMrs6km8qsGjbnZNLbRrMck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvUf6+i0jO5phamlrKlDtGzgFTBxA7RyjF5YLHajCIbeAaqWMur8IwVyS+lEpqd33E5ZgO6XJbrYck8Ips02Y2IRyPjAyIDPPKgLTlOtcuON6bXX//+nosP9aQLLJjv1AdYn94zCRpZlO+bnqgf7h/fvL2gipPHUryj3d8VAHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=uLeGUFCx; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="uLeGUFCx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uGow9Ed0DKFy4S/e4a+r6jXDOkMdtFutGrQj3nJcejY=; b=uLeGUFCxQryEh8KVtzJyHvQtq9
	bE0jm7JazvTWf/Y17zw4eaEuGhL35X5HXMzDcSFpE4J/6ADYyQU4Slu9bycIowc0+q/BS4pVvwkQ8
	cmYmof2ygtQJMJf6U8xf9Xxxdgx/5ejValmSCrfrB2aa2bpUMotBL79FPuLzedIsB83lyXvToXjai
	xVqFyHnOxiPuP9Sgih5IFYmeLDkcGua0BKLVdVhjtuETiCscw5xrfLkXIESGymFzqJu6PtmN3Bd0F
	I60MUl4mRbf2F1lAk5SzNI7QSeh1Q647i1QUuEXnePM9x02b5J0q63Rg2a/jatzyNgdldw3epCPhk
	i4k3VL3Q==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11316 helo=2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wL6in-000000097Rn-41AS;
	Fri, 08 May 2026 00:57:29 +0300
Date: Fri, 8 May 2026 00:57:27 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] checkpolicy: replace malloc()+memset() with calloc()
Message-ID: <af0KxyCu_hVF0EuH@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
References: <20260507213838.85273-1-kalevi@kolttonen.fi>
 <DICRV1S9SASW.2NQC19L5E71QA@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DICRV1S9SASW.2NQC19L5E71QA@posteo.uk>
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

On Thu, May 07, 2026 at 09:45:25PM +0000, Rahul Sandhu wrote:
> On Thu May 7, 2026 at 10:38 PM BST, Kalevi Kolttonen wrote:
> 
> This overall looks like a good change. I have a few nit suggestions.
> 
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> > ---
> >  checkpolicy/policy_define.c | 81 +++++++++++++------------------------
> >  1 file changed, 27 insertions(+), 54 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index b73de45c..a08cdf59 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -175,12 +175,11 @@ int define_class(void)
> >  		yyerror("no class name for class definition?");
> >  		return -1;
> >  	}
> > -	datum = (class_datum_t *) malloc(sizeof(class_datum_t));
> > +	datum = (class_datum_t *) calloc(1, sizeof(class_datum_t));
> 
> What is the point of the cast from void * here? I do realize that this is not
> something that you introduced, but given that said cast is not consistently
> applied, even in this file, and is a bit pointless, I'd personally say we may
> as well just drop it whilst we're at it.

That is *exactly* what I was thinking of, too. I am no C guru but
I remember learning from somewhere (maybe the old C FAQ?) that it
is in general a bad habit to cast malloc() and calloc() return
values because it is at best useless and when erroneous, could
mask errors.

It is too late for today, but I will send PATCH v2 later.

> Also, I am of the opinion that it is preferred to use *foo over sizeof(type),
> i.e. in this case *datum instead of sizeof(class_datum_t). Whilst this _is_ a
> purely stylistic change, it does carry some practical benifits too. Namely, if
> the type of datum changes in the future, one can't accidently forget to update
> the call to calloc()!

I know. I will fix those as well later. Thanks for your comments! So happy
having removed 27 useless memset()s!

br,
KK
