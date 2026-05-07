Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356ED35E92B
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147655; cv=none; b=SejuCThlLp9uCyVf9Yhv3ueU5rcLYJWFQTXxJytORPBIYoePZs9G/ddparF+iEcgjwP8+tl4zqulOyhFNPT9jmbJ8oJCEpv9fBwrvle8bux4vi7TJ9flMTpAhV3PKueM3QgQQcmhZH/D0pPzi5D4vhbKS/LVJFgq+jXMPGVzmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147655; c=relaxed/simple;
	bh=HiXXAN+7k8d7FsScP3gz24vMYHhixho4Z66l/TQ2CwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcUmf2xsp04Gy1KeyZP1EMUrqlPYndJjWnfkZvan40RiTXE82j9wbMoioXRchDGi8JroO1XdyzZ55vS8/P2ck7X/4YPKp8041fHbxiFsOZUG0peKIydWAayUipbO8pGopiqgGR9hBfXn2dF6XW0DD2mLRNeCjxTzWVi6DlAlpAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=e1tUoz/d; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="e1tUoz/d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4nLO63WWY+w3JdPn8NbUSWgLTghcCZZZ3dAcZbYg+zM=; b=e1tUoz/da1ETC1hTs9Rp9quQqW
	WM56f9Cqty2sXboL4UI2/WpEoBkCYilLyTP+en51HDs/G9oBdlc0J+yXyLC4osf1+5VVDIzDT54ZH
	dyx825eKRArIZvF6bS+cjF4/0D2wx8GuklYTMehVIrIoKUiBo8xnJJBgD/MGno5QpdBhw9qgYU+Oy
	PYKsyu9SBnJHLkk8T7Kc91cowrC/SgclR+pTh4fRySu+Niz5GCK+5egQ+qTStDJ6n/Yy20swNsM4f
	G/0+aDJtNgfYDwUnkm948raJGuHqmp7zc3JG1P0qfld1y1pL86kXCUF9f7g7Ci8z066FjLmUELWHe
	skfQuL/w==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11489 helo=2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKvQn-00000006kiK-3Yv6;
	Thu, 07 May 2026 12:54:09 +0300
Date: Thu, 7 May 2026 12:54:07 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux-list <selinux@vger.kernel.org>
Subject: Re: SELinux userspace does not build on Fedora 44
Message-ID: <afxhPzcQkwVErusv@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
References: <afvtC0DVQkt6rtAD@14-5A-FC-31-E8-67>
 <878q9v8sxu.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q9v8sxu.fsf@redhat.com>
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

On Thu, May 07, 2026 at 11:33:49AM +0200, Petr Lautrbach wrote:
> Look at these patches and provide Tested-by if they work for you:
> 
> https://patchwork.kernel.org/project/selinux/list/?series=1086260
> https://patchwork.kernel.org/project/selinux/patch/20260427123304.74899-1-lautrbach@redhat.com/

Yes, applying those 4 patches did the trick. Thanks. Feel free to
add my confirmation.

Tested-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

br,
KK
