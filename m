Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7F247ECE3
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085647; cv=none; b=jMFZrfXlSPxa6dahrdyg2Ce2LiHQ8oeUyscqfyuzxLiidQT2EOGJ3HF76RGSjBshXY7/h9o+9dTNWyWmTeeiOOSVUDA3r/OPZ30T0kj4xh1C5Bv21G5XI98Jd4YKbJ5flYgmBFWVU7rvTbgBTtRF90JSawOfpAuiO0lJ1dYzNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085647; c=relaxed/simple;
	bh=Fjr+dhIKkJfiUEkMpfJZifTT23+GUrKcoHasDDbUpKA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hY0tH/AMLPw2PITYY7tkEUn/biuxlu38DhZN0tGvTN3MQZoQvG+IoJo7QtakGKXtYlF0QYaobUB9aD7p3h4nvhRZ3FpaxPFDLXDD1aI1RSiHAXnX+rOK5D6VeYHfzhvQYKabb9I1R2ZZyl+KVzHonc93lz5BrzQ94hbt95iTc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=nYCWlPCc; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="nYCWlPCc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0GtxaY0joAMga1S7E7qVJs5vqTDgaqd7WDNAGqDso1A=; b=nYCWlPCcube5+w6qfW6Dv1538n
	RjzJSa2EnKj/RDlD7ok1fiuPzvu+tNaxZpfmaHyvXGVRSDAoStGXRfu3SOFz7IpNoFMFK2YZOFHNO
	JtzA+2eX9LI1E4nO7N8xxHU+HyxfSocbx2MqjRrilf5attP1FPfNVU8RTTzVZYzo6wIBDEyz+aIdl
	piwzUxgpjPZEH1oMBXLtAVzeIitoQzyXPe0354ql+ndxZWN5AU+Pfnh3+64Y3MGVy96+ql0yhBV7Z
	+bxPL726hZGOwyWwO10EtwIYih8fiuu3XVutqTpJ2c5bcBCVYHCxHgFyPxTNw0tWEczIviCcfhQ9Y
	FSW2mckA==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11379 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKfIh-00000002RM5-3cde
	for selinux@vger.kernel.org;
	Wed, 06 May 2026 19:40:43 +0300
Date: Wed, 6 May 2026 19:40:41 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Subject: libsemanage: why is expand_check integer?
Message-ID: <aftvCdG7qZ5TeQhI@14-5A-FC-31-E8-67>
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

libsemanage/src/conf-parse.y: why is 'expand_check' conf
option type 'int' even though it is really a boolean?

expand_check:   EXPAND_CHECK '=' ARG  {
                        char *endptr;
                        long value;
                        errno = 0;
                        value = strtol($3, &endptr, 10);
                        if (*endptr != '\0' || errno != 0 || (value != 0 && value != 1))
                                yyerror("expand-check can only be '1' or '0'");
                        else
                                current_conf->expand_check = value;
                        free($3);
                }
        ;

Many other boolean conf options are handled like this:

disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
        if (strcasecmp($3, "false") == 0) {
                current_conf->disable_genhomedircon = 0;
        } else if (strcasecmp($3, "true") == 0) {
                current_conf->disable_genhomedircon = 1;
        } else {
                yyerror("disable-genhomedircon can only be 'true' or 'false'");
        }
        free($3);
 }

Is it worth converting 'expand_check' to be like this too or
is it wrong to break the existing configurations that use '0'
or '1' as values?

br,
KK
