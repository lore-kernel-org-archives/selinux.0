Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554523CB
	for <selinux@vger.kernel.org>; Tue, 26 Mar 2024 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485731; cv=none; b=sMHDTGA8LlOv1RczFITKnt/iQl4lr+51v2o0lFAuQLB2BphfBsblKAbOdDwCxoMuWZhTOCKeqze4kpqj15fOOtvrclFhyVFlr+0rgZA1jodFI5JStyYXc5Aw2hmynFhGbxR5MM0ICrtNmmi1VrZXRyRjOZ1k1cO3sbmp/2Gdn4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485731; c=relaxed/simple;
	bh=vh1A8OrMRYeLT3872Oz/e5YixZaZUTnYa+237JO+dQE=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Subject:References:In-Reply-To; b=QQW0HvGX9H/mmBu6wfwpAOQdejt2WP7vmYY3aEEZdchoNpQwIIDHqkq2hCLvkSFiCUTXAi0qXYDMsDSmfGVu2miVAhWKZyJuqalBD8yAAapa+aJhk1T7Obmerg304BqJA62fDWNOduILQrvtvkmycm2ZNO4ZOmegqiRlRxaPr9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Bzvo+mND; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bzvo+mND"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6918781a913so48928076d6.3
        for <selinux@vger.kernel.org>; Tue, 26 Mar 2024 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711485729; x=1712090529; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QvyrjjNtAtR0EBTZmobaPZt23sMSuMsDkZ8UZ0l5DKI=;
        b=Bzvo+mNDd4dHyWR9o79K9fgcaLnVtYYzuNtYYAyufe3yWQ54hMe0QfGN2lrNGjHwZ+
         Dj2zxNNoH1Smd1y/nQ51T8Ai0yuhg38dz+7AZ3VR0LOl2AJQgn8CBemOc2jL+NMi7qy5
         0Bvc1VpAMBWOj4vcOO10r2XcZMMBo2mQ2KPzfWGFpWybJwgZYgtJhNcDG1QDRBNViFfu
         +SeqtgYb+FoFxR3C2KrSp/DCsxzPJksBiW38dtE9UYOAGJ9RRceOHjdqMmfxb9HhvYip
         dBvgy8K8B5AKOIp09h7GK38SWK4OMXMe6iMcOn3cZCO5XZgDoW0WMeRa/i6DuZmqGAqg
         Y8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485729; x=1712090529;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvyrjjNtAtR0EBTZmobaPZt23sMSuMsDkZ8UZ0l5DKI=;
        b=D69MGf5mGj4jIOWbHHdqKxedVvHCT3Amy8//Ec7sGcmIXqShc7hF0TG5l0Bsjwbvmt
         PiZE7gTqyU2PIvqmbO2Eup2lagC27Hfm+XEx6W0GEW1ETRMVEvslYbUugiKK84W44dNg
         mW8NPCgxW5MN5fGPuI5nLHDWEvll1Lrqt44RyitU1uKH/QzRc/YxkxzjlmumLR7bLaW3
         GOPFmdro2ixV59kEZRoAw0iShjgtKo8kkXrvtVM6oNi8rkbiKgXDbdQrA9fOWdQRy4kL
         dYoywPOgEytPrWI7iiFEZffr2c3ybAgJePD4iDQCygnl/rh27gPuQ6t1jrmWgzVNCMIM
         qp6A==
X-Gm-Message-State: AOJu0YyrTDPDYQq4sxdgoud5iIWzcK37JkUfpPBQ0M/nxy2cz7bg/qMU
	DIiKxRIQ2T5z0x6vkWGswXc3HSjMS6stVLyyUZhk9l8hT3HXQt6QSD5fNRdoWiblZ+5YCdgWAP8
	=
X-Google-Smtp-Source: AGHT+IHzuwodAlcTWWhS3SnJC9szguZ9ijfKpFGlFo8Ktvn1jRnpD1klqsYDfo05ih2Bm+CbieGHNg==
X-Received: by 2002:ad4:5969:0:b0:691:4425:c7a3 with SMTP id eq9-20020ad45969000000b006914425c7a3mr729221qvb.53.1711485728701;
        Tue, 26 Mar 2024 13:42:08 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id gi9-20020a056214248900b006962b97c97asm5570610qvb.135.2024.03.26.13.42.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:42:08 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:42:07 -0400
Message-ID: <8b302186f4c9a2ef1165cde418b92583@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: improve error checking in sel_write_load()
References: <20240305031221.492421-2-paul@paul-moore.com>
In-Reply-To: <20240305031221.492421-2-paul@paul-moore.com>

On Mar  4, 2024 Paul Moore <paul@paul-moore.com> wrote:
> 
> Move our existing input sanity checking to the top of sel_write_load()
> and add a check to ensure the buffer size is non-zero.
> 
> Move a local variable initialization from the declaration to before it
> is used.
> 
> Minor style adjustments.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/selinuxfs.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)

Merged into selinux/dev.

--
paul-moore.com
