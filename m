Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87605B672
	for <selinux@vger.kernel.org>; Tue, 13 May 2025 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174121; cv=none; b=TWsjOQ0SvnQySFJXSk25neR4rbNnaIwt7trG1U+kM5NW8SjpvRXNrdGLrsUpTDhBcLjN88UcwptcCCUhg7MjVsi1DFX3IG6mD7esFJDNk+B7GNpRr00PJG0YKTCFijtTzEyF2xEiDBKa3k42Phi3bemLQCVCM7x9tVigvWf+OjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174121; c=relaxed/simple;
	bh=wWutKFdGD4JxE1NRtENq2baEg+jpIUc0gGtgmz3iqUE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LNqBY4mL9WC0bC4vt/uxarxia5PNFbv3UJGlGJbVy0vZVzYAQRDKgLYxSc5n1b3AVHoaTss1YvR+DfqbLi2NtmB2E9C0Whv20MpTNJ66s3eEMZCO4JtHlEutiE9q6WQ0ydZ/PGPhn1k9Ooje4oxqJTN31GwtU9q/wYwoWNXDSvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=nTl+lDc+; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="nTl+lDc+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HfjCzePszMrBU7ZboZDbLz3Xj3/jSyGMJAF1e+FjKQA=; b=nTl+lDc+uV8lNnG2ILWruN9r1O
	VKo1yGJaBZIFBWBdOZ5O5E+vbKv6BULiDlINOxvRWSB3pkE5WVItyo6zcio/g06AbvxNYUkuHEqsR
	KuW/durfsWil3WMxivPGGxcMBgE+6vvEJ3gXryclohqE/TX5EFEGcllZ7BgHOYLp5aUJVikpHtd+e
	NRTWTyPCSxOV8Zn3phZD05jVy+rAsru2M9xOgz6Mo+vM5dkBHLbdkLyVQ1gUV+3oAlUhhIdfjgTRi
	WgSt2/v/LLWFYnzelhE5MdFgQkIQJ5b24Fh0FTEG5B3RZ1a/SG2LPnOFR6x2rAz3e/5P+tiYSL7GZ
	4fwnBqJw==;
Received: from 87-95-117-63.bb.dnainternet.fi ([87.95.117.63]:23774 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uExng-0000000G8xZ-01Ro
	for selinux@vger.kernel.org;
	Wed, 14 May 2025 01:08:36 +0300
Date: Wed, 14 May 2025 01:08:34 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux-list <selinux@vger.kernel.org>
Subject: github.com/SELinuxProject/selinux has outdated info
Message-ID: <aCPC4v42Q00FDExs@14-5A-FC-31-E8-67>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello!

The SELinux project page:

  https://github.com/SELinuxProject/selinux

has outdated information concerning mailing
list subscription. It is still in the old times
of Majordomo and should be updated. Thanks.

br,
KK
