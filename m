Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D89257827
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950131; cv=none; b=jYzBh/a0n1njUmd0idzLitvZAqrrCf75A73iahm1PorFQ79AXt9aBaWcHC/pk9g8CvSuAekwDFPiN0abFOYYJQ81psZyaKCMGQZeuhYzAczBz8qB5Sg+R9lbI8mvj7j3UnIQ9hrc3ikrzhlvB3CThMDuv//GKG8uHMBbTX0yb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950131; c=relaxed/simple;
	bh=IqiwNvYToAAUxHSJwXqJ2M7YtK53qwVAPp2nh7qiMBA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lApP2PeLB19WZZGUIkzh0JbiI512Jnr6tdyWyCfShaI7Ji+Yinva0wuBsCp9yg8vQutQSuFbtkPFP5Sd+cYoMLNlmDXqr15baXhSKt0p6IUT5zLKVa442l5nQOnN3K9IJd+/tyvOuJHOd7/UITQWFP8DLL0/AlmOEnG7NZIdMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cDpDQERP; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cDpDQERP"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9061a795d76so17481446d6.3
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787950129; x=1788554929; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vs5MRRxIdH2T6LNOkXF2Dqs2Ygzp6tZJtYnTu5q/m9o=;
        b=cDpDQERPG2v9VA4diRXLZpti0YQ7nuX/at4DFrQp//1svIj2QZZEaxDrs61r09j6jB
         YNAzgxGZ7RtRCEykgsXA0NujHK8xI4rZZrCcXygj+aGlSjNdpe6fAXetWwmjNmWEmJN7
         1NZ4AGYM2VJFOc6U8+KJm15hiKSCdRHdJGDSyNl40sbg8KSVxhAAz7VrbWwIJECUtcjk
         9Az+WaTdpxrbJYPD1tkA6wAKHjixDkOSen9BdI35pnCk8VEHBlkDQ9Fkuo0oSNLVGNdY
         D9qzix4emtbRF1ZBB6XTpV4Lw1g+XRJZySFC/CIOCIWgTaYpVQUMWIghe/ZIOQAtzJ/K
         DMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787950129; x=1788554929;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vs5MRRxIdH2T6LNOkXF2Dqs2Ygzp6tZJtYnTu5q/m9o=;
        b=qiS4JAtmDVBsuOAVhNN2cQkY75R5YGc6YZbvCcLI8xsK2P4ZPOKKrdG2VIbieij4aW
         1V7gMBcKopJOf5w2iqgle0wRUWH4GK4YnNaAZuQ/U3vCZbMsuG2YLbNjYIe2I/Pw9g8P
         fBfS0+3PeQjQZTl1DZWRqw68ln5H+Z6r3WCqsgOnvUzRZ510MJ3IneSoE0hh+4ksi38d
         rva8+dVBItTR37zYWNS1c3WSMXuze606IYgBlEyx58RbHtfeQPiC53Pey+0rlqnTKfk4
         vXgr/0mv8MFrIVMZF0SHMaa+aEcYWX5F0sXKnZuiAH6rlURW88ttCa1BO8IgtwAqqav6
         smEg==
X-Forwarded-Encrypted: i=1; AKwUvByhNzFQJuLP/FXg/fGnPBf4WGOVlDjAh2qyUhQTnlte03JUZb/tjuVCRdCXh5qfBg+okQEOUrDq@vger.kernel.org
X-Gm-Message-State: AFuF++lTcv4/DoSCY1KRJxg3SKPX7ya4P6f8zHgwEoxf4KorRM2Dk170
	3s/H907JvsXoy3WJ1T9220nlotvzjpNmgX/3V3mVaD86ZOpjve/Nat6EiD9Z4C1AjA==
X-Gm-Gg: AYBFou2rufpMjliqJVO1BwOl/aUJOyS8o/yyIiC+jJuYbNx2Wxri+R+0kJ4jWvPeUn8
	KJ+EzV066rIQRX8MiKz64iXH9i1Kaxa1LA4wpD8+6F3O0vuvz9wGxVLcYXHeZQxzO9S0L/Jf8SL
	UtxZN45J+FP768dzhleg2AmLp67wEc3akPtvj5kpQNTPnYS10fZ4B8bFltINaA6T1wwrPckpAhM
	X2UpVADWwmftS7k7OY+sq/ctCd6P16zGZi302DRSav6veNjOzIvMdbwaisC359jr3Cgarfnjk87
	orZKQc0LVJVhGr7nbMzjTuJc7iN2AY7yp1oWeQbv1Kzm59gOKwEDxjSxpnYA0yKm7YAKHp5p7DS
	zw/hvxRRu8fvol6FhgJGl2Ls5SwhsMp1bBDlAdnuwgDZispXgYykZ2NyettFSley5fAT460+nRJ
	mcM2ItTVo5NYECV65+JG4wAs4rKk8RHQBUk0gpPGp1pi0t63Q/I3vD8eD7aNCx+d7IT/eHcP6sY
	9MySKizueBOkrwNB1LJozsRvJ1iCp5NADo=
X-Received: by 2002:a05:6214:234d:b0:907:c0e1:62e4 with SMTP id 6a1803df08f44-90ce0e5b01fmr118954356d6.9.1787950128822;
        Fri, 28 Aug 2026 13:48:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce44f4ef8sm23440886d6.31.2026.08.28.13.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 13:48:48 -0700 (PDT)
Date: Fri, 28 Aug 2026 16:48:47 -0400
Message-ID: <77960c774f1a659ca33efb7134e24162@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260828_1342/pstg-lib:20260828_1646/pstg-pwork:20260828_1342
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] selinux: remove unused mls_setup_user_range()
References: <20260828202350.110547-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260828202350.110547-1-stephen.smalley.work@gmail.com>

On Aug 28, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> mls_setup_user_range() was a helper for security_get_user_sids(),
> which was removed by commit ad1ac3d740cc6b8 ("selinux: prune
> /sys/fs/selinux/user"). Since mls_setup_user_range() has no remaining
> users, remove it too and any other helpers that only it was using.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/mls.c       | 38 ---------------------------------
>  security/selinux/ss/mls.h       |  3 ---
>  security/selinux/ss/mls_types.h |  3 ---
>  3 files changed, 44 deletions(-)

Nice catch.  Merged into selinux/dev-staging and will be moved to
selinux/dev next week after the merge window closes.

--
paul-moore.com
