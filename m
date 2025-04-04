Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2862E62C9
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758255; cv=none; b=IwEYNONVvjgqF5JuGPJe3yKNgmqLaogW4JCSkI3Eyy54rppAXwI7AVu1q+rG86ri946QkSe/0ov8XqZ/Ycu3a9mOvQWPbHRDyd0cV2cQH2PBHukm0YigewlVPmW4AyCLzoYyRyuBEfsfWMF9jpVjkYVmCkMUrsx26BEF69JSb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758255; c=relaxed/simple;
	bh=GUxyfbiGIx8fpHFWbBFy8tgnV3GBBkm+wq7pgMcsCQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLeKELnbx2cRZDmTaAKlj1uZkDQgwMovUo7HL8lar8PTgdYi0eTWelVdkm1h0AnIbGml3RXlMsogQPnf6Hmxs4F+VXx8626HkPs7zfzgTpQ0SQ/XEENf8zlbfrinUEUjoFi5kUKsmg9l6j2zxQvUhCPLSYtupX37TzK4HVD8JLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nP6Xqcrv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nP6Xqcrv"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f09f2b3959so7572a12.0
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743758252; x=1744363052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/EOyBsAvODbLKkXqQhvvjIxc3vOVzYFv77wWiy6v0sw=;
        b=nP6XqcrvxnebvK/Iz3Xw1Ezl5MTMkay6FcPc90PwqbckGXLtaVsAC0BazzMEAWqOZq
         se4QzaZS0RoepxlJqg3QsLVI1CevZuxS/wvJyEqxdz+fi7Q7PvVN/GyEtys1CQF7TXD5
         LKdstv0gyKO69iZSDgx1/G3ewnLtObH0UkErceEKtUOFM/l9nKHI3kwqx4t9HPVnaq8d
         gJQRDsghX30urPaxYgQI0q5ku4RQoQFmuZzqpudppI4A5a3VF/a8fn/Za7uVy5KMcebS
         nDD2e9P5E5JYOdxi9/eg2JCLD+dpvO+KhyZ1Vw1/aQm3EGM9shAqALLE476ONNQLyloC
         /CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743758252; x=1744363052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EOyBsAvODbLKkXqQhvvjIxc3vOVzYFv77wWiy6v0sw=;
        b=Cur+qDXbuJiOFSr0rNvaA15HIq5LjUqfMiM5OhfA9iiVW8EBIPmSegFZHv6cU1PnEa
         VN69HvTWt5clMueBJCBKBlHcFbuK1TMRbplA7f0ijaYRFS1nsGZQJDw/qD2nfmVA9pau
         eqFz1CJw0jKPwcmU5g94nWxQnIpegZ/e6vDZBDXw3e2aUrIzXZyF6l91WCn18xwkxm+i
         NLLgrmnkAVtYB1CMLP63ivte93rOwZrvsYW/SkL8OxgMyVJSGEZcjzQdfpX1cQnYiyFo
         R7tyAmeRk84uGyclA5FWaEwsfNH6Q+QakolSFKpPHkus7spy7IEqPN+4PihyQysXFAPV
         ox8w==
X-Gm-Message-State: AOJu0YxWKXhbG6zm/z3wk+FudDNd0bPYb21cyMqK67+6FmgyCw6v3yun
	9jp5ORDNLHeDccSQ5enXKYkLVXuckyATj6F8bVujriPOiw7PDhxyQ5S+cS6jzCvBs7tfIDHnvjt
	tuK09Rki7vV41GY4rXZnrP+cpI/eV9V+HVGC8
X-Gm-Gg: ASbGncsVq5tplOUfFMF4kzwIUgsr9NrvUtfne/90W2gQHIIdqUu2QYDK7EF9H3SZPmh
	4nvhvgJH4Ni3o0cGOA3U/DaKhXTcPogyerdd2O5mBDGpBLwpybxQY5X5IyMIhJyS7G07JjQLNT2
	KsfPD4bJ5nOpqQk3FcKtz3I1ohOQ==
X-Google-Smtp-Source: AGHT+IEr5yrJepCQWBv6gBDkP8/HVEC8vuY1bofRMbrPnd5Ha7lB6TYLjdqt5MWxBLlxtNSVITs+ghqZ6Gzw/4w24e4=
X-Received: by 2002:aa7:dd12:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5f0b69de046mr60789a12.7.1743758252085; Fri, 04 Apr 2025
 02:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402010146.898864-1-inseob@google.com> <CAP+JOzS-ickvHYEPokm3oTSqyEbJrbhZseHPR5N1Oda2po1btw@mail.gmail.com>
 <CA+QFDKn6JdzWX8ROiLmtAM-VnGZC0Mizttj6rXQ3otbjF9i=2Q@mail.gmail.com>
In-Reply-To: <CA+QFDKn6JdzWX8ROiLmtAM-VnGZC0Mizttj6rXQ3otbjF9i=2Q@mail.gmail.com>
From: Inseob Kim <inseob@google.com>
Date: Fri, 4 Apr 2025 18:17:20 +0900
X-Gm-Features: ATxdqUEyX59oKGdHhXCN3Z--yALJU8RtdO14kdrG05R1_97IIClK4MeN0gpBYqg
Message-ID: <CA+QFDKn9f+oJg+Ddm=tYCbeugYhqEAqWCQjHDX3WWxL5zM4qrQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] libsepol: Print line markers also for allow rules
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"

While working on this change, I also found that
checkpolicy/policy_scan.l is a little broken.

#line[ ]1[ ]\"[^\n]*\" { set_source_file(yytext+9); }
#line[ ]{digit}+        {
 errno = 0;
 source_lineno = strtoul(yytext+6, NULL, 10) - 1;
 if (errno) {
   yywarn("source line number too big");
 }
}

It assumes that the line marker with a filename always starts with
"#line 1 ...", but it isn't always the case if the file is
preprocessed and the very first line is skipped. We may want to fix
the rule like:

#line[ ]{digit}+[ ]\"[^\n]*\" { set_source_file(yytext+6); }
...
void set_source_file(const char *name)
{
// name points to "(number) (filename)".
// assign both source_lineno and source_file appropriately.
}

Let me apply that to my next patchset too.


-- 
Inseob Kim | Software Engineer | inseob@google.com
