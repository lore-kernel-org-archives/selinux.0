Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8431B317170
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092683; cv=none; b=JtpEpSqoPXMh/CnsoxYQWhjaCZI8p6lRsQP3vk8DfjUcX5s/ghC+yGoSLLT1YMebDWb8RsY/CmaS8crNYJtjN/E65DUHQp6/4LqK0IkvZlwEB3/tlVr9/blgDsre+noc7d4ufBgOXkivIZ43ntcx0wIFuWB17+ESkoOsxyGnNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092683; c=relaxed/simple;
	bh=x8aNi3/tWdHVwLa1aMalEPEFYM4dX0VvR3v0/Qqibgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX9+kmXJFNJwzsQWcQEngiFWBZGi2KVTmLRAN/+NyQE4GTV5uRKmKXBvnngRHgiueDFAviVMXQFrEcYD8rGH8ht9g4y8JvPpgHyyY6x1CbCuA4L6wLTe5eNqO0oi5LRxNpZU944g1X4lgYSKi3IavPjM5ze7itaOURDR1l5aB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=F/ZYeeiY; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="F/ZYeeiY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pPp9aQUYDwWWdPISdMoj7KafPsXh9Tzb8lG293crBqE=; b=F/ZYeeiYdNvKYxriLCFDX8HqLP
	nxBTOzJDvBhjAo9WnXcIvK1DZb1J8srCc6jlk4xMnvMJdDa1RZTY30Xwjms6TppvYT4gY5hNcyr12
	HkQR80MmhgHtEFiPnl2MuvxP4bvBLVub/lWeG4ZAqicmBPcj8lFCyozjbPytwufO4WbltYO+esL6P
	4q5Fdhxc54ZXA7TOu8DMhvtcqgEaOVtXuky1reHi9QQUHEx3mqKlOAMjNR09MxvHKdUMIgIjsdAxI
	Ip6hIVR96K3vEiMPi9ywfuzBvPKVHrS7YN8i+l5rKk3klz71Qa2e9h6tiamfmMEt0Oxy0plkWMIT2
	1CgAOnIA==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11764 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKh8B-0000000381t-03eb;
	Wed, 06 May 2026 21:37:59 +0300
Date: Wed, 6 May 2026 21:37:56 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: libsemanage: why is expand_check integer?
Message-ID: <afuKhEPR1zPlsN1P@14-5A-FC-31-E8-67>
References: <aftvCdG7qZ5TeQhI@14-5A-FC-31-E8-67>
 <CAEjxPJ5PVu=ypZ1coyq5B9kNNFkyE2s2HM2m+fmBSBv=ObxwHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ5PVu=ypZ1coyq5B9kNNFkyE2s2HM2m+fmBSBv=ObxwHg@mail.gmail.com>
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

On Wed, May 06, 2026 at 02:31:23PM -0400, Stephen Smalley wrote:
> On Wed, May 6, 2026 at 12:42 PM Kalevi Kolttonen <kalevi@kolttonen.fi> wrote:
> >
> > Hello!
> >
> > libsemanage/src/conf-parse.y: why is 'expand_check' conf
> > option type 'int' even though it is really a boolean?
> >
> > expand_check:   EXPAND_CHECK '=' ARG  {
> >                         char *endptr;
> >                         long value;
> >                         errno = 0;
> >                         value = strtol($3, &endptr, 10);
> >                         if (*endptr != '\0' || errno != 0 || (value != 0 && value != 1))
> >                                 yyerror("expand-check can only be '1' or '0'");
> >                         else
> >                                 current_conf->expand_check = value;
> >                         free($3);
> >                 }
> >         ;
> >
> > Many other boolean conf options are handled like this:
> >
> > disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
> >         if (strcasecmp($3, "false") == 0) {
> >                 current_conf->disable_genhomedircon = 0;
> >         } else if (strcasecmp($3, "true") == 0) {
> >                 current_conf->disable_genhomedircon = 1;
> >         } else {
> >                 yyerror("disable-genhomedircon can only be 'true' or 'false'");
> >         }
> >         free($3);
> >  }
> >
> > Is it worth converting 'expand_check' to be like this too or
> > is it wrong to break the existing configurations that use '0'
> > or '1' as values?
> 
> We should definitely preserve backward-compatibility for all existing
> userspace configuration files and APIs/ABIs.
> Some of us predate stdbool ;)

Understood. It is just very ugly to have exceptions like this,
overall consistency would be much more beautiful.

Would it be okay to change to change to code to accept
'true' and 'false' while preserving the old config format
too? Or is it just a useless exercise?

br,
KK
