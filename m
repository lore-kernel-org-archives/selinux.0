Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892C2C0261
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634913; cv=none; b=sEuGV9um+grpziZcMCcPo55HhSacKmDa+Ba9MryjqG+Np204QIJTuTXx65m3+bx3nzfw+a8IYvd3iY4vqqw1B5OEl0Z97YPyPQPtTHHou2zPBgZhQ8pAjvrDYG0I5KMXIO3jZC8dhlHevniT6j/XmHixNGLJM0cg1IU0h6yRU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634913; c=relaxed/simple;
	bh=9fKpchIdlWClCJdVC0hS3MDffbcZ81BPM1S+LD8cddU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFGTyjQ7XC48B7l70i2kCHGMCe9WDWKEG7K6ega7SKB7SQtkMmycjnz0JP4vPcrVQ3pubHabBkbW3mcL1OGoPESZ54bvtrqxX6erl+KPcZ0kZ1FcYeeYTDyZJ/974Hz432JJtUC5d9vDTQ3lxlpi6c0elS6vkHK3bidKYHu2LJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=mOeRAecC; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="mOeRAecC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qlBO0UwASGMLjYGUzdTifKCw/N4D+N5JNssN5Y2050o=; b=mOeRAecC1oMKlKC8YLmGI8HBSZ
	At3PtQ69WlGNkUZpnGuxRZOpdzaKzDBxp5kRV7kI1QyWtVTu8hS5PMEKq8tLdGlMYTDRCB2xAggl6
	5IuPR32zMLNtRqGKfeZBHRQBwzUbqSqwO+2jdjjy9IRTuWFNglpCuayzTDK3sJSsqQ4HBlv4J5vof
	ioXWYG9RkPktNfwjo+JlP302+Ox4ioAOdJTeUyC5JMVOjgne7VcOLFbftcgVbWdJZlyEaFwrqYOEf
	fcHnAqd6Ifd/3gmoTUn8nTxeJ9KWMadg0GfB9GuB0naVEOfSY0d0jUjSs90F0beb3HUkmEGVm7cRY
	MZ1sPbLg==;
Received: from [87.95.76.183] (port=4293 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wZYcy-00000000cg0-0wG2;
	Tue, 16 Jun 2026 21:35:09 +0300
Date: Tue, 16 Jun 2026 21:35:07 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: About SELinux userspace AVC
Message-ID: <ajGXWxFgbeS0zfZx@AA-94-54-42-0F-E2>
References: <ajGNgKCKVcmvVUeJ@AA-94-54-42-0F-E2>
 <CAEjxPJ7HfVS2iUOLztp1VGn0hQ9+4Jr=BMwTY0y_ZzEnwHKVcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ7HfVS2iUOLztp1VGn0hQ9+4Jr=BMwTY0y_ZzEnwHKVcA@mail.gmail.com>
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

On Tue, Jun 16, 2026 at 02:04:33PM -0400, Stephen Smalley wrote:
> On Tue, Jun 16, 2026 at 1:53 PM Kalevi Kolttonen <kalevi@kolttonen.fi> wrote:
> >
> > Hello!
> >
> > When going through the SELinux userspace code base,
> > I found out that AVC is available in userspace too.
> >
> > Just curious, does anyone know if there are many
> > applications that use this feature? As far as I know,
> > most of the AVC decisions happen in the kernel side.
> 
> It is used by a variety of applications in both Linux and Android.
> Sometimes indirectly via the newer selinux_check_access(3) API.

I am trying to see which apps could make use of it, but on
my Fedora 44 installation the number seems pretty small:

~ $ rpm -qa|wc -l
5930
~ $ rpm -q --whatrequires libselinux
setools-console-analyses-4.6.0-5.fc44.x86_64
setools-console-4.6.0-5.fc44.x86_64
cronie-1.7.2-16.fc44.x86_64
openssh-10.2p1-10.fc44.x86_64
shadow-utils-4.19.0-7.fc44.x86_64
mcstrans-3.10-1.fc44.x86_64

But I am not sure whether I am doing the right query here.

br,
KK
