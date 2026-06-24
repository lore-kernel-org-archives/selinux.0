Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60A372B2F
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334287; cv=pass; b=djI/LdAwPB1bagH/8scaUWH1ZvIb97uYYXbTa11nfrFavIkzSxGFUpu2RWHMiGsaDBs4WCQR2Jr0T4hipDvpfnpMuqEclM7qyHU8JWpOuNrVdfmM7aeIufZSmjxoZYKGWW0lc5XHxUEYpqgT/rprv6EP1zit6qk6CNEYRikllJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334287; c=relaxed/simple;
	bh=7g31X71XMx07JCxOq54ek4E3/yg/CBRXiPCIccPIBNc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SBMljbelOMe4M2ntH7zyd0Zak/w1B9MFZFlP8x+G/sndLcdZnc5BAaWOboSvWKnw82GzIJlTksxfc3ujymO1QDCmyIWvUrHxgENTFN/c1Ohpr43wp15pbdZ6BiutnDVYaYfSDB+63QLzMsLbz7kbfzTyqVBTB3GUxMF0ZU40RKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L99C77qc; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L99C77qc"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8452a597afcso1102245b3a.1
        for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 13:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782334284; cv=none;
        d=google.com; s=arc-20240605;
        b=iSOwTuo8BqGiHysdrn12EaW3QruRz2itRJxPINZs5j6ZDgQmNc8V1y9rto4+LOqdrh
         UC7uWqGp5LJoj/drbGf4F+8V2r06rHKmFHzTlExj9qhblbI1KXfAGA0WMZYkLNbTWrAl
         Rq98qkKUSYh6fesNJ6fa/G1ZI1VfpSGEKHGSd8UX3b+SnM0sH3RlruaJyThFkvHoKUJw
         bgLj2HHYtZo1Sywkg5ROnKHB2bO2N0Si08ZTY+VIzxRlyZmnAp91TEnkQw0/N2APdNlv
         NgVNeXEDrSybHCYqr59Gobix46JwqOI4JyU5SJZb1nqAUZD0V4D9+CNWetLs+GK/quYt
         czgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YZ7Dn0q6IsJO0rZyGkp3ibpHJ9juJ0i6jLLoWgdvIMQ=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=g3hlgi9CmNeyP+xnDm1Tcx1mWoXflCKC2K7xhl3QM9qq6CZO+g5Np8bL7+k3cLIj6s
         7NCg04dipyKTHq1EQF+9I1OhCcP5KOzb9rm+xb+3Bn1ZR4lMoz2T1p9LgrJ3Q8Tg3L0M
         lC5oqnRr9y423oVVMfqizJ7hINXRjlqabuwBgQcVHse+Kr4ycsw6PVgJIWi3rq5yL97Y
         qE0zLP5Yy7OG+24BhQPWb8o0lHRYUj6q0wayraRg9ROcDFlrp2EaWaxIiwpIwTjhWJWx
         k9rkKRfMCjBEqfZsP+e78y8M2tQE0DTqhuOelT++85dKmxWjlCQjZe7aLvYgAzCJTZtB
         3fNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782334284; x=1782939084; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YZ7Dn0q6IsJO0rZyGkp3ibpHJ9juJ0i6jLLoWgdvIMQ=;
        b=L99C77qcitspgYF51qtDOLEMCZtCPxm9qF9bQOnwoi/C6TRwP616CIaCZONvdBzXgr
         bLXyalSZj2FKbv34RdqmYPjCAfmpID2DTmabF0lrRRKIVhvMoPzezHvuiWVpMzwLMB3+
         WcHEO+x33nr94kmNgE+r5Pv+f3bpf+SIGHAUDGJl4CoFQ/5ah5TbkqGgtLEOYM2F5Nyn
         4l4yhYcP0SAkV7xVGpBBvBB+QCcIt/68ME86U4w35SiFZPID5dnNEuMJFd/bbSfiowLS
         8GWY/tU6I7ZXBC+6WWnFVyEYNrpSokxX1PJ0/t2TXtJ9+SjULTuCFtxSaeZLE141A/Pv
         ktdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782334284; x=1782939084;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ7Dn0q6IsJO0rZyGkp3ibpHJ9juJ0i6jLLoWgdvIMQ=;
        b=A5gmQqLQ8nH+7z8o9JJBlXeTW5YpAKEL0RbJ/h3Qc/OfpwQx8SGaMRsJNnmXSxKMmW
         AzqFZVS1xpEwgg2jlLnd7ljXdvtJz3C/CeHhmNcWwAFgnT2/0DUnzxOk1o/ET8l3G2vf
         d2tl8zv1puB+m/zKktzd0HRP9XUfpySHti6OFAEk2z4O2pdC9b+y3tvWD/TDLICPtKzY
         Mwf+34SjlmQSBl2BfP2S9VeTTYka9ESvYzB+/L33j9QQsy9lgeNrKF20LZp7tTuZqOHU
         /abTof1QGa1+IH8p+TN7B6F+WLOqj8egqqA/SKhZvgTCeh1MJQqF33pY67nXfbZzRwsi
         j8kw==
X-Gm-Message-State: AOJu0YwegtwFnVEB1rr1U8ksJMhckeAcB9VwE6VuMmhqA9TxxUfA/6uB
	Y0yH0FNg6lpqBA8FALJdFaVFLbzO7j6sBwG9MXuNtLdEd2x6PmsJ0WFacs62Dk0h/me8IBXmqjN
	MsLc0osGWjOoqgQT9gBbmotMqmKJ05EpMaRepyB0G53tgMjFKUsml+/Tz
X-Gm-Gg: AfdE7cnoYVy/PrlC/ULNnnOxDIw4mQeXMBeCAMuFDNXZFMxg7ouYyUH+ZsK7GqoiaoO
	1p/zWOIS+7crRd1YpR5TT2eRbaAQXUNIyWzJxutGmZkZhcHvNIojX8YihrlydE5TGfpyTvpCGDi
	uMkcHbYMgqAcz3m5BzDsWe5FanNtw0Agi2mZs2XDWlvSjU/kwHfyJuurcI9WqODE46yCT5Ouj6S
	KQ8z0bdfdQQ49QqZ0LsTcBMaoi0d8BeqjwHTj+vnd8nOMCW1Q6smyaoVkCD0B2PEd9DNTN4
X-Received: by 2002:a05:6a00:2d07:b0:845:39dd:f773 with SMTP id
 d2e1a72fcca58-845624575famr27592673b3a.7.1782334283915; Wed, 24 Jun 2026
 13:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Jun 2026 16:51:11 -0400
X-Gm-Features: AVVi8CdQsS0Ussg38UzurJ-_mc_f0IuMYllpZ4bVYyTz64ZAkQA0mJ6ijkVuOZ8
Message-ID: <CAHC9VhTCXEpJVnWuy36_XzKjmkBRaqwjDPfqZFiWd2aYcEntgw@mail.gmail.com>
Subject: ANN: Sashiko reviews coming to the selinux mailing list
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As some of you may have noticed, last month I enabled Sashiko reviews
of SELinux kernel patches posted to the mailing list via the
sashiko.dev instance (link below).

* https://sashiko.dev/#/?list=org.kernel.vger.selinux

Now with a better understanding of the review results, I just
submitted a PR to send those review results directly to the mailing
list (PR link below).  The results will still be available via the web
UI for those who prefer that interface.  While it is hard to guess
when this change will go into effect, it seems reasonable that we
should see reviews on the mailing list something within the next few
weeks.

* https://github.com/sashiko-dev/sashiko/pull/292

Unfortunately Sashiko only covers kernel patches at this time, there
is no way to enable reviews of the userspace patches.

For those unfamiliar with Sashiko, it is an "an agentic Linux kernel
code review system" that leverages Chris Mason's LLM prompts (link
below) to review kernel patches.

* https://github.com/masoncl/review-prompts

Let's try this for a month and see how it goes; if we find it
disruptive, we can revisit the Sashiko configuration.

-- 
paul-moore.com
