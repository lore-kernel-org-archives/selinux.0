Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172763939DB
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591553; cv=none; b=vD6dtI2DGXM4EL6LWJhK4UwHDCOaVfLSgD4jrmE7xoPVu23xV9m9/+Z12OszP6gP5jHjWgVa+eLotS5O2yWCeBlVI5Crn+vTACBhMvSIzaRfDXLeOP8Hvcn5o4+AhHiXnVPL7jT+IiXnEs3Fnsi3pd0TtSCnYEQFrU9LIwTL3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591553; c=relaxed/simple;
	bh=H4attdS9KFcxJ+lqPKZcKlPPcoiI2uDpDsroRyuU6P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn9khzO9exQc5BL+ALVENr/FWtt7Yo6cAacg0eDRsxjTI7PmNDtgM0xL6UzVS73CD5Aayi3bEc0ECPqBnvRbk3izaAn++hjQ+3KX1VGghlKuzhHuhswqjeU79ghKCo+tl3rJkthp1XyuTqdm/ImUtQu+YogR2i3nnnVVjODrHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=iD6icyIA; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="iD6icyIA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m7DIRngG09/mHeSwH8pm00VWJhL3Yg+bPWG0FNaHGqo=; b=iD6icyIAKROFmn1pewcgmMufia
	AMme3hMYF9CyFz/IUNidJnTOx11PF7gtyQhYnDF3symf52cKOpAnWmo8F+2YltV6cRqDhXwseLA70
	rrgyJNxgdXWNDtZwRn2HXeCRfzQHVhnH7agBald0aeEkGrFc/Mg/r6d3y95K7/h92KSnXKPuocAdt
	5Y+x1BfUzAPyqgzROUJLbplFHwpoZeuw1infcZF1YPz4aTGgjxgOPeeSnfXXGbHqY5P0ClYXh7Yfy
	agyOt6n2+K9MEDZi3fNYXnvn5NhmGGtC8cHgLBBoLHIBRBWeFwTrQK61ZNku7oT9F+x4StxeHcMOG
	BA3gP48A==;
Received: from 37-33-136-133.bb.dnainternet.fi ([37.33.136.133]:13323 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wIalR-00000009Ir9-17TM;
	Fri, 01 May 2026 02:25:49 +0300
Date: Fri, 1 May 2026 02:25:46 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] Remove unneeded goto and its label
Message-ID: <afPk-rpwDYq39v1e@14-5A-FC-31-E8-67>
References: <20260430210001.56995-1-kalevi@kolttonen.fi>
 <CAHC9VhT4q5NQ9Q9crSv4SegvJq6uNan_j1xWgppPSgQaCrirsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT4q5NQ9Q9crSv4SegvJq6uNan_j1xWgppPSgQaCrirsg@mail.gmail.com>
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

On Thu, Apr 30, 2026 at 05:59:31PM -0400, Paul Moore wrote:
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> A general rule when submitting Linux kernel patches is to prefix the
> subject line with the subsystem's name followed by a colon, e.g.
> "selinux: ...".  For example, look at the top three patches in the
> selinux/dev branch using 'git log':

Sorry. I have just amended the commit message and resent the patch.

br,
KK
