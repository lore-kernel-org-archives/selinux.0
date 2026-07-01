Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E73AD524;
	Wed,  1 Jul 2026 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887344; cv=none; b=VSRALUbA65SapZ4WRL9+MvwmPpBzQs+ONcA2kBJaWg4T5n0SrhKn+enNzXZlquiGuL46csgdQa7sktkSYFJvC/3eyJafAF4nsM1BU8O49i481TN/VpLO+ITCavTFkgAgBKtw9wSybmFAjwJQro2FHgEGg+HA/PNW9nVyJrGWVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887344; c=relaxed/simple;
	bh=aRWgvWob32DZXlvd+U9+s+tkpn0U4WqAUFJdwH4jY+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcZ3Xg5H2uy9fE/lSkV9LmoqKopLG02io5DINjw1A1xcBBNwvRnUKO9oCkjx1uEM3DydXQnzy7uXr0qsJm128cpZkgZ8bbU2Q/JZLmRgfbcxaVi4V0PPvVvvpMsgyiYkZlrnqd6L8OASHbZl+2TZECrm2+apS///CcXDOClTV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI91NpoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI91NpoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3261F000E9;
	Wed,  1 Jul 2026 06:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782887343;
	bh=RjEB80gdHXQ8HLvYnrM/mzLumsoz2ua1TVBbhoJleeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MI91NpoDsHCuZusKsNpQ2MwC6vrPxT/7oauKcGLSWPF9cmT22UMcbiFv6v4O58uPP
	 bRwiELIOxcjn8A26IEoUcEkyNUmmmPXWcUhRzMC3TNQtDZTKlZ5njWZBkJKRNJ+Eg9
	 dXj1fP9GL6yVNwI2fBeH3vrk+TXHL69fe6S85+Y88xRKPuSnrM6rqtvmbDQLh+P9VT
	 JV11n49ahkNm4/hbJ8N5cKwdAbOX9Ub+300a5J+m0QovdYsdEHm/5vcMKNvnZiuA9m
	 B+x25fpJQ794+p8R0pPvE31/p4g3nmJGI9uhRvHYOU8TjuAtyR4a9IGrtdKdMMXqyw
	 vxEqTLY/OdnwQ==
Date: Wed, 1 Jul 2026 09:28:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2] selinux: hooks: use kmalloc() to allocate path buffer
Message-ID: <akSzqdSyx2YuM609@kernel.org>
References: <20260630-security-v2-1-560d33c13ee6@kernel.org>
 <akOZERjhp302jhut@kernel.org>
 <CAHC9VhSekkkDajeFxpjAvaRyUnrfThX9hB1MD3aYBhYMCoRcTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSekkkDajeFxpjAvaRyUnrfThX9hB1MD3aYBhYMCoRcTQ@mail.gmail.com>

On Tue, Jun 30, 2026 at 09:01:08PM -0400, Paul Moore wrote:
> On Tue, Jun 30, 2026 at 6:23 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Should have been:
> >
> > Subject: [PATCH v4] selinux: hooks: use kmalloc() to allocate path buffer
> 
> No worries, I just merged the v3 patchset, it applied cleanly.

Thanks, Paul! 

-- 
Sincerely yours,
Mike.
