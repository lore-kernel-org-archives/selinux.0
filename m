Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC814EC55
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350126; cv=none; b=FCeBTJPN04bcJUyw1ajxBrenbBC9eAkJuiSXeb6mDh8zEhhhfVV4sqNe+YEnBul+SUPuGmU+P101vHVt+W8S4Prf5TdFNsVw3paduBJbHg8qh2XSXkkntOVwIRFTJZixbLz/DnSjHMWdB3dEcz7rKwXWGgCf5ZrtPkBgh8m/m7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350126; c=relaxed/simple;
	bh=FsepWrXP28decJzHy+s7O3Dg9Jci0wYGK0NWKJP0TLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+maKvX+aehJ13JvOE6PShI6dVmmLunfeMDFR4jd63J9gw0p4OM+a9+z+PivOeZyV0gR5wvkqfAnX0RlqiEH0xroqfTnishyNMeVM1y7aYiG9TgqSp6edriQSQWxq8RfIO+dV6D1snqyuYPfCyq6gDldgRAMxtifWj5FxjsiJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=NQTOnG77; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="NQTOnG77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1731349656;
	bh=FsepWrXP28decJzHy+s7O3Dg9Jci0wYGK0NWKJP0TLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NQTOnG77Z/F4lYMl6XPvPVsMdfHaEJLH6nJ20UkteqAbXOioo2Xfmxdn/bLZQbSsy
	 VI3p/HYUftd57sB1+gsVMZ0QfMG8kuYtM7P6Hmu5OBqFY7pWzL1kfOVNSccQlEma2t
	 fP0zW9DKtBgCG9m8h6aqtt+Rfu+QYcMR7rDra1xE=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id CBC0EDF59D;
	Mon, 11 Nov 2024 19:27:36 +0100 (CET)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Ian Pilcher <arequipeno@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Subject: Re: Allow rule not having any effect?!
In-Reply-To: <3df128ad-cd76-4fea-a905-60d7f02ca4ee@gmail.com> (Ian Pilcher's
	message of "Mon, 11 Nov 2024 11:30:08 -0600")
References: <3df128ad-cd76-4fea-a905-60d7f02ca4ee@gmail.com>
Date: Mon, 11 Nov 2024 19:27:36 +0100
Message-ID: <87pln18w2v.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Pilcher <arequipeno@gmail.com> writes:

> I'm either missing something incredibly obvious, or something really,
> really weird is going on.
>
> I have a policy module that includes this rule.
>
>   allow runcp_t etc_t:file { create write setattr };
>
> And I can see that the rule is loaded.
>
>   $ sesearch --allow -s runcp_t -t etc_t -c file -ds -dt
>   allow runcp_t etc_t:file { create setattr write };
>
> Nonetheless, I am still getting this denial.
>
>   type=AVC msg=audit(1731345803.780:3765): avc:  denied  { create } for
>   pid=289668 comm="cp" name="config"
>   scontext=system_u:system_r:runcp_t:s0
>   tcontext=unconfined_u:object_r:etc_t:s0 tclass=file permissive=0

I suspect cp is called with -a when copying that "config" file.
It tries to create the file with an identity other than its own
(unconfined_u versus system_u) and object identity changes are
constrained by identity-based access control.

echo '(typeattributeset can_change_object_identity runcp_t)' >
mytest.cil && sudo semodule -i mytest.cil

The above should lift the object identity change constrain.

>
> AFAICT, this makes no sense at all.
>
> Any ideas?

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
