Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218347A88D
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946754; cv=pass; b=d6qfxQU4Gpe9U6s7wzjYG4ulRt3jkNS6WcgFb/TW+5kN5AvQ/skM0SG0KnFf7AJtg+B93gp+OhoML5CNSoQcVhuSCmKjY00D3H9KDZhU+i9xGxxql9nDTwloK/m8hTnbsBKuWkhhzEU3nworkM15DD4QmU2rfqTR4nNPcmkc1pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946754; c=relaxed/simple;
	bh=AUe2Gft41bINYBdqk08vVE44C2h4MGUx5lU5V5tc3Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoFE9YtnXW8SVplTkVrbYU7qrbP/XX83FLWhkYLZl8h4/onodmxMeA09hB0H5umrKkPOkjrfOc4p48UBYB3rgmRv0TKPKcv2PLKuyfuzwpFJqkuTQ3rTXaPEadkskBRTGkhcNyBsHiAxAlCAqYdBs3evEo7OFEXb4ymG8PcoMWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BglUxZ+8; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BglUxZ+8"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6ae3faeb9c3so679663eaf.1
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 09:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785946752; cv=none;
        d=google.com; s=arc-20260327;
        b=OQa5JjxAf0lTmQTkzl/KQYgRrFlvLg4igVeDC6MuNljcHFwfH43/513P0t8zBEpzSE
         5WBkFftwt3dbtNw1W7r12mNqVdajOQs2EqdCCueMFk+1OPWFSa4OPbKUiTS3uWyIyWsL
         bTuY8HlF77sB34JYciIPFh98wXid0sm63YZ2UbuoqfT6t+6Z26TVpR5AyDseqZBrfN9N
         oYmiUMFQ5KE/p1N4/ZTvBPbQ3sYyMlYStK9UV1kW/6pstPCLb2qkJYVtAowK2Iw8/s+U
         JwN6SuDLSiRLpWVMId75/1hZrGyLcftxzFVLDNiVWkZoHCxQudF1C5GLYDZSwqUD0b6/
         Is6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AUe2Gft41bINYBdqk08vVE44C2h4MGUx5lU5V5tc3Ss=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=AC/3lQoHevPZ4mr/dwZE0bQhHH4R/aQH6FNdggoAMBb9UnITv9MtfcgpF4RQZ5zT5z
         KPcAkR7VvPa7mdwRY2Bnz5FmpPVGQQQSM7zl8g1K9mdmstwT0/GH9h8VVvpzGbVkR/Fh
         cANKUjnYODeqT1LlSsucXE7ac4NxjwfvXJUZORwx+NDa8j+XoW1D7B3PzzBwTUmppiwW
         0Sj/0A6tA3uAxrfce+ofxjhbHQ28sbsih3flBxfzy9ZdeTvmiDNMP3c+qkI4zjJhITII
         0JzeE8mZfM9dSfI09Jv0CM7oTH1PxXX0W3APwqgdaT6X7MEIQVLADhrPED/dMepA3bYy
         LjNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946752; x=1786551552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AUe2Gft41bINYBdqk08vVE44C2h4MGUx5lU5V5tc3Ss=;
        b=BglUxZ+8D8HwIaYb6MM5mo7Umcb3c3xowZtNBvSiWUP7sx+R86Y10MsHzwTkXcH5oy
         BQt30wyC31jss63rzGgRPC+FClVoIrpLbvjCN2ZJ72rocy7lLpRUD6456KULp9EJuIIn
         3ToDDzFI5LT3+jMamqrvBfiJSuIWJ2jksLvhKPC1EGjLzYcvdzwfSaAU5dXyEPUAQn73
         eyi21vUrnkiQDS4nUKZ2bc+x2C6n0IB4Zx4t/gf+r+cCsJi4p8OOSChUN1opvgM+KId9
         Zqtp8QXbNeWnZ8/+861th4ln8iE6UmRcYnWvJL7HY9kUaQTfAiQ6M8gh3PjDg1088HKh
         FXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946752; x=1786551552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUe2Gft41bINYBdqk08vVE44C2h4MGUx5lU5V5tc3Ss=;
        b=AQihfrWo746k+Gtouem7miRPGl1hDU177EKUNhZbFv0cnej/X9dtebLzGfP2Op3CE0
         CWIacVvwD96AVcvib6XKuW3LQSrDavG8FlkCqPdwHSMh6GGIDiB6HvoxOfASFMETHJXz
         rqO8D+U/uaQDAh79i6ZiDUVTlPyahSEENilR0JDVzm2tNMmZd9Ve2dHrLXaehDoAfPUc
         N3AKWwlYEcIp04cJDYhRj4/x3cxnjrjR3iMd06L0+v7FRjhMSKPCQxgCRwnqllxJKtLF
         ynZl6rH+xnpT+4n5IDdSyp3KYUZvL/3ooo80ZYkZ8Zq5j8t1kNquhPPP86r+24WZfF8P
         JhlA==
X-Gm-Message-State: AOJu0Yw/minsVnivjeQ0F6zKfWDhTZqNV1OC/Ko0Z2eFcxWeNKlmU2+1
	+2EjYOb/kkHDW4XV1+NLeKU4iIGjBs4PK25DJyw8LRUZ2CNWmoUbUCzXzgn8Ier/oj3XLu46cbr
	6HyXu4qEdiiLebLox1o4kn8DHIuehy6c=
X-Gm-Gg: AR+sD112hm/I8Q7FdduBUBqHvOajoUVH6Be1lk+05oG5FWEnioxowKoRhKz0TDBRu7S
	V126iI4IUDManjXbf4AYo8X8CJ8dEWwso401QITtCzsgrJT0dEKqfN5W2b4rn8F7YG797LDZpBQ
	vMnOPet/e52sv53NWPxvUz2xegl7KE+HoXKvny98vTqdqf22Us+McMpxJqzep2/R05yfmqhJGRi
	HWjml7ywNitjqJVinwMb33tVdZKxPqeZ9Zq25ty52Z61lVKkCmYZQ5wGaF66gFEe1P82BHUSJ0t
	UtXoP/oq+2mg2ztg5p9ZJTiElCoicSoeBGoD8MBHl2L84g+F89DZ6EhOFty9gDLXoi8=
X-Received: by 2002:a05:6820:1990:b0:6aa:fe65:4cd1 with SMTP id
 006d021491bc7-6ae97047201mr4114836eaf.36.1785946751778; Wed, 05 Aug 2026
 09:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805152947.15933-1-jwcart2@gmail.com>
In-Reply-To: <20260805152947.15933-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 5 Aug 2026 12:19:01 -0400
X-Gm-Features: AUfX_my-jZqmbarWRPxpAp2DxFMqrGDNJlq2YicBxxrR9TrjHQH52n_n7BiXlvs
Message-ID: <CAEjxPJ5LGriCK9g8HZH4B7paz52c=X7QXV4EnduWFPOR0Uw1rQ@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: Validate any levels that appear in a policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:30=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Policy validation only validates levels for MLS policies, but it
> is easy to create a non-mls policy with levels (just read the
> policy in, change the "mls" field of the policydb to 0, and write
> the policy out). A maliciously crafted non-mls policy could have
> levels that cause an OOB access when processed.
>
> Because of this, validate any levels that appear in any policy,
> even if it is a non-mls policy.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
