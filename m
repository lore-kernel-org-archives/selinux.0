Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E4510F1
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778198733; cv=none; b=KZsAodPxC5WCNwre1UObiX37jBDzfr8m0G5W5P1qTW9W+jliK/XWrhs1ZbeTl0yKJx/qG1uhbKP1QgXpknXoV1W5h0i+jFJkjIAH8F7PHETbc/jHc4rDD8upmzIhQJrVh1I7jsycyJng87JZudrIMns3JamIA/joznFBFNnPRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778198733; c=relaxed/simple;
	bh=T+r87b802VzbfLlTlb/6x1YnWrH77fqW1thVRsiFQTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBOsIOUzVFMpNQ3KS9fi+/qnaZLj8Nci/kl/u+cBGxA5KNjyIeiyXPpQLRdNnzKztNeu+7Nt3OTwXg2ld+9v9AfT0yqx1DnKc64q9w2Mv53MSI4Pv/ZHWqlLi8RHe1TnW6kLJZ9k72Z7KWUcDWmnbxnhvzdVgPImVHUtzwN6Fzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=cZEmkJvc; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="cZEmkJvc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Je6+GoBY+7CTZRQQSJOYQ520RejN1YPlUd1y0/M8wpk=; b=cZEmkJvc5ADAypgfICGK47GyEk
	c2VPPPyjSsPPPmxhvDUBJOKl5KsoKK4EQ5ZXtPdN1EcI/zutZT7Qe8C1baO7egbY7iZLHjceiPwr4
	++WSVNuReZqwtfcBiIFS+o8WTbC8n1Ert2xYqFf7gwNXBltMr+PNxnzmpIhEYzembYxmsiilsDFPY
	nQmm8HjyNxfoMDZtCjt/RIaem0q5fbQLBjE/53ACtoquF56/Z7+5V5YGW4C9IVZ4Kd2yTwX33cmaS
	vn+JHyycgL5DVRt7ZBXy9oNGQj+wTZ9b0ztD63cLty3cyRVeldJBwOKDi2pVJrNhhU4lUYHwUrv5A
	GMN1Ep+A==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11542 helo=2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wL8if-00000009VyE-3sxF;
	Fri, 08 May 2026 03:05:29 +0300
Date: Fri, 8 May 2026 03:05:27 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] checkpolicy: replace malloc()+memset() with calloc()
Message-ID: <af0ox3uY6I1LQSDp@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
References: <20260507213838.85273-1-kalevi@kolttonen.fi>
 <DICRV1S9SASW.2NQC19L5E71QA@posteo.uk>
 <af0KxyCu_hVF0EuH@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0KxyCu_hVF0EuH@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
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

On Fri, May 08, 2026 at 12:57:27AM +0300, Kalevi Kolttonen wrote:
> On Thu, May 07, 2026 at 09:45:25PM +0000, Rahul Sandhu wrote:
> > On Thu May 7, 2026 at 10:38 PM BST, Kalevi Kolttonen wrote:
> > 
> > This overall looks like a good change. I have a few nit suggestions.
> > 
> > > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> > > ---
> > >  checkpolicy/policy_define.c | 81 +++++++++++++------------------------
> > >  1 file changed, 27 insertions(+), 54 deletions(-)
> > >
> > > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > > index b73de45c..a08cdf59 100644
> > > --- a/checkpolicy/policy_define.c
> > > +++ b/checkpolicy/policy_define.c
> > > @@ -175,12 +175,11 @@ int define_class(void)
> > >  		yyerror("no class name for class definition?");
> > >  		return -1;
> > >  	}
> > > -	datum = (class_datum_t *) malloc(sizeof(class_datum_t));
> > > +	datum = (class_datum_t *) calloc(1, sizeof(class_datum_t));
> > 
> > What is the point of the cast from void * here? I do realize that this is not
> > something that you introduced, but given that said cast is not consistently
> > applied, even in this file, and is a bit pointless, I'd personally say we may
> > as well just drop it whilst we're at it.
> 
> That is *exactly* what I was thinking of, too. I am no C guru but
> I remember learning from somewhere (maybe the old C FAQ?) that it
> is in general a bad habit to cast malloc() and calloc() return
> values because it is at best useless and when erroneous, could
> mask errors.
> 
> It is too late for today, but I will send PATCH v2 later.

I actually did it now: v2 also removes the unneeded casts
of calloc() return values.

> > Also, I am of the opinion that it is preferred to use *foo over sizeof(type),
> > i.e. in this case *datum instead of sizeof(class_datum_t). Whilst this _is_ a
> > purely stylistic change, it does carry some practical benifits too. Namely, if
> > the type of datum changes in the future, one can't accidently forget to update
> > the call to calloc()!
> 
> I know. I will fix those as well later. Thanks for your comments! So happy
> having removed 27 useless memset()s!

I changed my mind about this. I simply do not have the nerve to change
the sizeof() calls because there is always that slight chance of
making a typo or blowing it some other way. I believe the code we are
looking at here is very stable at this point. Changing the sizeof() calls
would yield only theoretical benefits. So I would prefer playing it
safe, but if you feel the need do the fixes, you are welcome to do so.

Now with my PATCH v2, all the changes made are quite mechanical and
we can be confident we will not break the policy compiler.

br,
KK
