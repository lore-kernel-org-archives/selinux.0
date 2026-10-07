Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F91E345EA3
	for <selinux@vger.kernel.org>; Wed,  7 Oct 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380405; cv=none; b=nyC8h4RkCvcMEjjLsmz3qpdELhPw0T2wmAKmqxgUE0asDDxPeaOORBymVqCyJdJ97CsQL1iBwjPhy+2Xv/sTIwC3iZVcbKoMWOdMnr+oSjMBZlrkjqzDZoASNvEZ9dlRtoG8LscIOxA0To/Z/1NKPwvya3RkRrqkz2NyxAvlQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380405; c=relaxed/simple;
	bh=mSUXmRwKxFONJJlzobTRgUeawo5lghzUz5ZWOEQ8Lg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z4CHwzoTdyQ8RP2d8SlPtWyZCEyx9+y/3t/y0qoWo3Jf2BG77QfYt8TLDbXJ6t/a6iwqBdekPURfjWIV+Cb6RE/TiPXcBilcpBMUhaWgSNocjw2ns12hYbLar94ypq+uPry8dDcXfKC6rHiHfWsjS8WZRLrf4FTFG3tNWi2gN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=Gc2lL6Wd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Gc2lL6Wd"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e61ac64ec3so3104095ad.2
        for <selinux@vger.kernel.org>; Wed, 07 Oct 2026 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1791380397; x=1791985197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E1O1J/Drxyv6FvVCs0IJkljAYuuDM98Ms3pyP+xdftU=;
        b=Gc2lL6WdeD54Brn5edTUtnsgo2+MGHWewnttN6nL+kJSuYIDQvr3Qeo1riCWLV7Ddz
         uYJu16lKEnC4zpQZ24wrzIe/7y87QFah+0FIKURLTU2yoGejMwJ3SzaLbrihwGLyDEAg
         oLFQaUIXRD2rpzU1yQnXAidV/3p7qNkeNRDBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791380397; x=1791985197;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1O1J/Drxyv6FvVCs0IJkljAYuuDM98Ms3pyP+xdftU=;
        b=CbH1uCSojpUQ0iFeQ+Ac16jw1CqYzilSSqjUl9ijvhNK6NMD4C1Rhqa0aJiGgLx4kc
         aoEoU6p39C0+xuvlbFSxl0OkqgYXvzD+dryb/CNbJiNeO76roKItzhflkSmAPnenqH3V
         cOluWvM3mrzWHh4khzM31eWgMz3qZgslk6JxYHhnz9KkPL6w8C4v/S3ADddUE7BRwxEK
         6a3VNSVfqXlIIjCa5uTxuylOV7T6WJLNKw6oiVGhNsOWBAynjbT26bcVlKnHPQGQwX91
         v5poR1HVMVSLq294+1bJ9Uzln7IYyMWvcA6mWoHD+G/MyDmm+KxMYQKpAd1uBneqjLq7
         KOiA==
X-Forwarded-Encrypted: i=1; AKwUvBxQ65tBGUSRUBlKxbcutzLR8EZGBFIGJ2ndetukhND8dYgoCcL1OPrUY4kmMBGfYRYTAKVE5701@vger.kernel.org
X-Gm-Message-State: AFq9FYIzltADvXLGGlQqpQbFgy3So5+htM+Zq1VRx1NLr5X12C0n+14o
	O46bPp26czsG/kRUQXldZhqJ4yMVbt9Xr0LiW7k/KObi/L4VRwcLczMhGi47iFe1fQ==
X-Gm-Gg: AYBFou1bJUyTXsYI/I8c8uXyFufdOmHppbP+9wdeK8J+0AKmgelwK7v3hI02PUBP8yn
	2+z7s5kzPNRiDMiKGfJFD+Izxz0Z+b/Cg5KsMR9DHngEPPcEqeY/UfBWbWsGLQXNKdjP3Yi2kMb
	+btelsUYg1QliesgE8bv24kXb9XeoyjbdZY3bX9rsBKC9rM3RJlX0XE/74N6hrws56GpDr4+4DR
	uvvGBYlghSBI0wq2zhhLXVaoALIuJgz356ntUrIyjs5f9AT2echDbDs/fYs7kQLR30GWNhpiAW3
	PQDHH71eEi8QFYqSnaiQdeqq904x+P91Ipe3uIHfAndeUtPiv9l6DesfJF5WULp/yMEcwsZAI6X
	Y+K8Jp1ynu1wKS+cEBb0+QXA0D9jcxZZoOCHk0X9smMDyuCW6BY5dv5ZpR+ASGQtV3fwryRd90i
	IbmqtbOB3awatMEY2NRjIXkhAbAXb5Mf6SCxiEG/+myt2ifLu93umPTCetNKe1jC0tZw7rYOhs5
	nPqhwhEhEym/y50GUtxkwqVErc0h47NwZuOuV4P1iM=
X-Received: by 2002:a17:903:4b08:b0:2d7:f0:896b with SMTP id d9443c01a7336-2e6003883b5mr21074345ad.13.1791380397287;
        Wed, 07 Oct 2026 06:39:57 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:1bef:dc06:8ab2:b604? ([2601:145:c282:5650:1bef:dc06:8ab2:b604])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6046fe3a7sm11089735ad.23.2026.10.07.06.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 06:39:55 -0700 (PDT)
Message-ID: <795f9c25-e48c-405b-98f2-3f9fff192883@ieee.org>
Date: Wed, 7 Oct 2026 09:39:53 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH userspace 00/17] libsepol: add public API for policy
 introspection
To: jan janasek <jjanasek@redhat.com>, selinux@vger.kernel.org
References: <20261006130215.128405-1-jjanasek@redhat.com>
Content-Language: en-US
From: "Christopher J. PeBenito" <pebenito@ieee.org>
In-Reply-To: <20261006130215.128405-1-jjanasek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 9:01 AM, jan janasek wrote:
> Hi all,
>
> This series adds a public, stable libsepol API for read-only
> introspection of a loaded/compiled policydb: iterators and
> accessors for types, roles, users, classes/permissions, booleans,
> conditionals, AV rules, MLS/category sets, contexts, ocontexts
> (initial SIDs, fs/port/node/... contexts), filename transitions,
> range transitions, role rules, permissive types and policy
> capabilities, plus a small "record" layer that snapshots the above
> into owned, independently-freeable structures.
>
> This is the first time this series is posted to the list; it was
> developed and self-reviewed out-of-tree against an older base and
> has just been rebased onto current upstream/main before this
> posting (see "Testing" below for what that rebase involved).
>
> Posting this as RFC because it adds a sizeable new public ABI
> surface and I would like design-level feedback before going through
> a full review cycle. Specifically:
>
>   - Is libsepol the right place for this, or would a separate
>     library be preferable?
>   - Does the record/iterator split (snapshot "record" structs vs.
>     zero-copy iterators) make sense as a general shape for this kind
>     of API, and are the naming conventions reasonable?
>   - Is the libsepol.map.in symbol-versioning approach in patch 17
>     acceptable for a surface this size?
>   - Is landing this as one 17-patch series reasonable, or would
>     maintainers prefer it split into smaller, independently
>     mergeable increments (e.g. per policy-object family)?
>
> Motivation
> ----------
> SETools (https://github.com/SELinuxProject/setools) and other
> policy-analysis tools currently reach into libsepol's internal,
> unstable headers (policydb.h, hashtab.h, ebitmap.h, ...) to walk a
> loaded policydb, because there is no supported public way to do
> this. That couples those tools tightly to libsepol's internal data
> structures and breaks whenever those structures change. This series
> gives such consumers a real, documented, ABI-stable surface instead,
> without exposing anything from policydb.h directly.

I reviewed this from the user (SETools) perspective, and it looks very 
promising. In the iterators, I'd request functions for getting the 
length from the iterators, as I use that many times to get counts of 
types, roles, etc. A reset function would be nice to have too, but not a 
big deal to go without.


-- 
Chris PeBenito

