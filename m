Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D5A2236E1
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815617; cv=none; b=QH9/054fnn6wtcAUS6THxNEBA/5QqjMyBxlIqX7N9x6cWV8v6OvyoBC3QzIWhwPYG56ZQu8IQXzpJA86YZDobOY1J5dYolSOKZpUny7doqmAxcMQmmaf40TTXDaGTo+c69O+XuAF620JJKot01hHo3U12PAXEx9JC3g4vCX3uo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815617; c=relaxed/simple;
	bh=SnZKxn3/SMbjs4aOcSRemCcoa3UrhMIbtGqm7h9md8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt9adtVPpt9oHQDMaZlLL6BQ6PwjCnIBbSVbO1mvWj5VqJSUQIC4RckG1ckqD8pP6ME9VtezWeytuYmcTUuPPh+ezUroGzNPBJ5ZOfxZ3ZKLAb3QqBoy0c0J60KXnzGrPdd5QW4zjFa32fMrSmMrcKcNJXH+oEBtsPGJsk2S2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3D5ZTQv; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3D5ZTQv"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e854d14bdaso8129005ab.1
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 15:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755815615; x=1756420415; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SnZKxn3/SMbjs4aOcSRemCcoa3UrhMIbtGqm7h9md8s=;
        b=J3D5ZTQv8fb6X0YUBgcYcQASaIY13cXvtB30Opm6bQD8V59DGv5wD1QqXbZ4SLdvTa
         PeWoCR3unJScqdN6+zmE4tDbDyMXuzu0QNZQWmkxaK1k4Mj6zCLDSrxD4DDRLs2eIv3Y
         qqPz8UdFNEflfuFFkfRkIMb6S543crBj+Ft4Ha2eefkPZJ7bJknVgOfYktl7o/3+Oh86
         /kd3vwSKZiItMC8iYSqu8hgigioY1kLNW4m4LjI0a+H5ygvIUhMDPKDajhRaCcSTMq5V
         TxDwyW/Vzk2at3zL9hnZzs95vsaiVgqNn2D+XEs0bhw82aFZC2PqhYP9yfxEOKB5+OKX
         ILyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755815615; x=1756420415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnZKxn3/SMbjs4aOcSRemCcoa3UrhMIbtGqm7h9md8s=;
        b=l1k+kN4/Jxbspsxd2pqJ9LODIQuBM1/T9fKD+zbkJ2xOQAUePykQvtDayOWfSdIXfW
         wcheA971VZiStZv9mIzNqjDSBoSuxhAgUUdjcRVPyV90RSpIBSYYIXfry3DqnylzEixi
         B7QPy2c6fHgAxNd4zCOoGj50INvs/NBRf7fpTFJf7l53ZGU9rvzn0bM7lFUCfTTyWDfR
         LTLBTviMzy/ahUjRvCEF8ZDBLbkapWfG2Gi8Ykazz2lqZ8b3NNSvU9a9ciupcGvABfDb
         PRXoP+QMxwoB1JvkpVceZPHsXLOQiHbteOxx/Pdqshv/8/LG1HZm9Us/P3C/FUjjjkrE
         aCjg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ayaUgQd6BBocZfY6InfpLhqp6hZ7zhnlOt9d+FnBYPTccMlRuJc+hTABFtZ/BUO5OPIq/kOf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/juyzOPEnnr8CW1RoYyQDNt4KZ/gCacf522Zn4NdD2eOge4IF
	O+sB9ogrNcKSROVGU6KWECtnv2w+zwtmmDOQxPH8pKnQ4cOOVFPuZMbJDSzAvSmxIQ==
X-Gm-Gg: ASbGnctmMxgCag4HVvOInIEGpQ8NXkBTtPhttaX37+yZY2MtPmRXLdu8VYSfRuNbcWY
	/N4Sm5wN5E9cOt8afY4S6cBKoq3vsGcoJXOQN3kPTnI0fZsrrEUntOwRkcabDjLh8Oqrpyrjd+C
	gKMZzOweF4xhlgtSJnRY2B07ppsjkKZgtM02JmnIeTW9kshhaWTS38xVFUjzrI8JPs32Tf7u1st
	4my8LVUc1MR3oXlSTh5neOlK4wdVqIjbFdezlPtx27uLKSG8e29WxUxzMMThKAlTzd3labk033V
	Tj2PZUy1WU88IlsdzMqA+6EE9nGHZXqQN93f3cZGFvO13o8HXeNckp0o+385uxzAf7mlQHq+57b
	1kfnKcl7jwRRl72ZPmOzUDuDTXGIyEk1zLP2/6iGYAxSTs5VhX2jmG+olauonCk3GAg==
X-Google-Smtp-Source: AGHT+IEGzbbJOOBIn6TC2Tb+WI7UDDv9xLsePcm3E8uJTuF+vAY06pBGbAB+hdY1ZUNYILsPBsWGow==
X-Received: by 2002:a92:cd88:0:b0:3e5:4816:8bca with SMTP id e9e14a558f8ab-3e921a5d7a2mr20072225ab.12.1755815615067;
        Thu, 21 Aug 2025 15:33:35 -0700 (PDT)
Received: from google.com (189.227.72.34.bc.googleusercontent.com. [34.72.227.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e6a6c3bsm80502205ab.41.2025.08.21.15.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:33:34 -0700 (PDT)
Date: Thu, 21 Aug 2025 22:33:32 +0000
From: Neill Kapron <nkapron@google.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	kernel-team@android.com, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: enable per-file labeling for functionfs
Message-ID: <aKeevPJ0TDcp1T8W@google.com>
References: <20250820212302.2325779-1-nkapron@google.com>
 <CAEjxPJ4Vi9rXXkvPUoS-tjHks_6oevdkhrjvSeX_Rh5VV5gBBw@mail.gmail.com>
 <CAEjxPJ6iFrfVxbRM71b9G0+59L+vxNiJ1mpeXSGwuG_n+D15Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ6iFrfVxbRM71b9G0+59L+vxNiJ1mpeXSGwuG_n+D15Lw@mail.gmail.com>

On Thu, Aug 21, 2025 at 09:03:49AM -0400, Stephen Smalley wrote:
> On Thu, Aug 21, 2025 at 8:59 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Did you confirm that functionfs is safe wrt genfscon-based and
> > userspace labeling, as per:
> > https://github.com/SELinuxProject/selinux-kernel/issues/2

Yes, I believe this is safe - FunctionFS is a filesystem which
exclusively exists in memory. The kernel creates an EP0 file to which
userspace writes usb endpoint descriptors to, and the kernel
sequentially creates the endpoint files for each descriptor.
.create/.link/.rename methods are not supported for the root directory
or any of the file inodes. So userspace can control the number of files
created in this directory, but does not have control of their naming or
anything else.

In Android, we further restrict permissions to the directory and control
endpoint EP0 to specific system processes. Our goal with this patch is
to maintain this restriction, while providing more permissive labels to
the endpoints created by the system process.

> >
> > Also as per that longstanding open issue, we'd welcome patches to
> > generalize the current hardcoded list of filesystem types to
> > instead lookup the filesystem type in the policy to see if it should
> > support genfscon and/or userspace labeling.
>

Unfortunately, that is outside my expertise at this time and I don't
have a solid understanding of how this would be accomplished.

> Also, do we need a new policycap to conditionally enable this new
> labeling behavior to avoid any regressions?
> See the corresponding checks for cgroup labeling and
> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#adding-a-new-selinux-policy-capability

Thanks, I will send a V2 which adds a new policycap for this.
