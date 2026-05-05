Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F44963D2
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010218; cv=none; b=S6DDBcsh59T0k4ZjbScqzaM6vqILC9vX2aKaNIXubSTP8+IzknnNHG2LH+EqQ3VyolXXZQOCjDpVbTyk0YVwL9EmqXoWenIxYDg1iupum4zH6mBY34e+jZL0hG+XFwMAMmy/1otws8VnMstGnVboPzWNp/a7f/WV/+tqAHR6wxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010218; c=relaxed/simple;
	bh=cZS2qHqEDzlrUJP4qRHmW/Bc4U1dAUzGJXp0VxP8SvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWKswG0QrCYnE9AG1xYkUdI8BpD5zom9a31lgtP2uTlhQ8NqKlce2m1MLxKv1aTZT57r9Lfpripv7k/lI1HKKscIZRbzqmvopYahl0DQz2DbzBQSuY7Dov1S8s42/44qgHrzjecDUAe8xsbQs4f1c0XHDJjpWR4kNjMbtQcpUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=dTfAujEX; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="dTfAujEX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cZS2qHqEDzlrUJP4qRHmW/Bc4U1dAUzGJXp0VxP8SvM=; b=dTfAujEXUUMf10TDdqx0wrOdCv
	WxdPFq41RTQ4S2T+wwAWTZT16zUXHbOhrxtZ+0ZU3nK0LBvUO0epXc3lH4hUfkw1snpn3Jp9n5eVi
	bGQytP28je2hIi9m5OLxGceMWn8i6w0w9l1zihAsHbTJEwre6gA5WHdq8SMcpZ+b5UV3PA3Mx13Ug
	OrujX55j6pBUxJtq3FCkuqYzRVdH2G/bms6R58kVVLROJQFYe5qWh012hp9jn4Kcy8Vux9Gjd3dgC
	BoyOvu2ryjF31MMCW4INtwD0GgN9jFBOVPH0v8aHXM7pQ6+Fg4PQj23SVZPbJQ+ztE/ZOsblD1y/u
	BrWuqA2A==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11597 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKLfz-0000000EG71-2L4U;
	Tue, 05 May 2026 22:43:27 +0300
Date: Tue, 5 May 2026 22:43:21 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com,
	omosnace@redhat.com, paul@paul-moore.com, perfinion@gentoo.org
Subject: Re: [PATCH] libselinux: restorecon: revisit pinning files to avoid
 TOCTOU issues
Message-ID: <afpIWa5ezvPiFpIv@14-5A-FC-31-E8-67>
References: <20260505185017.18428-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505185017.18428-1-stephen.smalley.work@gmail.com>
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

On Tue, May 05, 2026 at 02:50:17PM -0400, Stephen Smalley wrote:
> +static int have_proc;

Just a minor suggestion, I would prefer 'bool' here.

br,
KK
