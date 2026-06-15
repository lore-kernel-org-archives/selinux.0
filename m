Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137840B6EE
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541721; cv=none; b=ouGQP4VTOx31mnbAyf6OofnHEU/eJ2EnzPOBzjbFeiXOZ2ctnezbdWJvlyGUq7cSQDlD8Pazvd1DXRjaGJuglknY0DH+Mt2F+lNrtoUJ6s+N1xZl7Y4HMpcK/NvvETaf4wY+pD8plTg/T093c37gEqaar9E90mgm7CHOfP84FGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541721; c=relaxed/simple;
	bh=i1hU/40Im+Uy9PW1u3/vOJEgwa4l+QsWhxXQy302ERA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdkk6hoQ6EfpB9I8XFUQHW20QWjorN/I1zI7RVzWgyVXfgXhlbwloHA57id09kkYwaiAgpyQ+bFvTdmV4Tkz2WYLTlnh0sYkQrD2e2JNLwiWx7Hvbwe5XSM3zyAkVS9KvM3T/oocck4xrSgITBit8oqqN7NEJNDnUy1uqNP0e70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=MF2TT/Cd; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="MF2TT/Cd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r6HSQsgBJCq1z0VbNPmsmQsceH01qpZov6K+lJcTNwk=; b=MF2TT/CdjGsWoaKSWCUA8T56fE
	JaznSL4Nnf4hlks3UJruIwWTySTbNO0tmw46+giRttIuYB7v7F/s9hUT7pY3Y7TsVSyOD+ZgpPjgO
	YzAuU86+I87zw/LxXjqWfxwiECbAwDl3Y+0F2BKgGwXvIaumcvQWjWWev0Tk7P7qkmi1GFp536vrL
	aD1FLviCHAH9Pouy8Aw8ni53HZ9SJrRi0HTDJrNMRPbPQS8AqC8HqusokPAWRIloIKFTyoeXyS9Mj
	4zjSfQh8G7XPQpF6qZXjKtyQgjv/ucgOZSef2fzOTbibAL+YfE8ezflP7bhJ5L6sxj+7CfKDFcvTJ
	UrM2+k7g==;
Received: from [87.95.76.183] (port=4343 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wZANq-0000000DJ0d-0abP;
	Mon, 15 Jun 2026 19:41:57 +0300
Date: Mon, 15 Jun 2026 19:41:55 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] mcstrans: use bool instead of int
Message-ID: <ajArU8qNUFmU3O4d@AA-94-54-42-0F-E2>
References: <20260614171548.21200-1-kalevi@kolttonen.fi>
 <CAEjxPJ53xXqyB0jhXLxkOZKjuaWidQTHdYKOHE6AbomX=bnTTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ53xXqyB0jhXLxkOZKjuaWidQTHdYKOHE6AbomX=bnTTQ@mail.gmail.com>
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

On Mon, Jun 15, 2026 at 12:16:24PM -0400, Stephen Smalley wrote:
> On Sun, Jun 14, 2026 at 1:16 PM Kalevi Kolttonen <kalevi@kolttonen.fi> wrote:
> > -static volatile int restart_daemon = 0;
> > +static volatile bool restart_daemon = false;
> 
> I think this actually needs to be volatile sig_atomic_t in order to be
> async-signal-safe.

Yes, I guess it was just wrong. I have just sent a new patch
to address this but forgot to mark it v2.

br,
KK
