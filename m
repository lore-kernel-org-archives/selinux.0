Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7D28507D
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260932; cv=none; b=kdfSX+06WHNwMPMbhS9Q8b/9z9nF47T3gylCJNAIejzChT0IpUZ2NvX1DLMrBSlN7ek5QJn8ZaTR6vPApB/v64saIoEuvYxix50Nc/zkCiJQPfKb8hsDI0lVW3HNDucp3BD4VGO0UPaB3H0Oov+41uQbbFvToLjCWquEG1C6Ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260932; c=relaxed/simple;
	bh=8oXLyT3l6nKMBkScRkhUpQSFqmFmz6Gwp4THcr6nYuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HudLd3NT1AXNuNSOVLITWASTTvs6z5NhtrIL6sRlzS7x/ueOh6IuH3RMABDY1wfqWyg9YTyk6wMCxeZCQXGeoBnce1zCrZD58gfU/l59l57qtpRl+c2uaRHfGIAJv2Hh4JJa1ly1KuxoYsfYG34pfgIuOE935BpjI7VNZBAFU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrUrO7fY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrUrO7fY"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so834996a91.0
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750260930; x=1750865730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2mnV//pTSO5+KXufyFnLo+lja/nCSlN1ZyeCvNsDdM=;
        b=MrUrO7fYVoDI9J1Oyow7XJU/ZUA2SnX+s9vGbbgVJJDilSFbZr25PDFsOy/KywaE4C
         PYCDLuBujjidbigHLoopnBD+qq/FSG6umTg598cvICfIWJ1mT4BEaIR/LO74y7zLRQHq
         oNMyk895ekEOk+Ma/qcUzuBdGMXo/One8P8kOa95+8gYp2DfHVMmVWT3yYyujhRC5H3U
         +nhKW8kFyPpgPmSVO8w7rsmfT1JWirp0aNrYkYi1ctG7aPXYIVJx7jMarzVzUzQrXESt
         5aLiDzuoIPQ5Cr+wmN7qwqA+Ae7wqZwNbc/zAAPFwf6bQx9Neae8x+/Q/oIVxubeW4mP
         iE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750260930; x=1750865730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2mnV//pTSO5+KXufyFnLo+lja/nCSlN1ZyeCvNsDdM=;
        b=jFixjHaG4Niefu0e0RlhuT81KoIeMb/FJqioMXx7WbsJ1Gm+3e/lKqpZU1peASzXiE
         TloXajJTnRmi1VGnZ/HNcfBsEXkZw/IYtKFLq43nNcrLuWLxmqpBipJbQ0dOVO6jlUbw
         8pzdF+0mVwzPdUY062L7c7F99CK2OKDFGM8ifi84U/L63AWAkvjtaEKlPaHHMF6hpV8n
         QI7qAJ7vDtdYDQIYSTxWrbAE9DWAy3CyCw4QOdV64oLSrHz0Mo8lXoCRVbd0soyZzUlZ
         TOOPt5K6VYIfdvJsxapuSpYUNWHqBrkzIOBCsSoL+UTmAFQZrUsf5UIWzb/3Acz9xCva
         ZR8Q==
X-Gm-Message-State: AOJu0Yz+efCqjjJo6lXhMOL3XWMFa9bbPpkt3Kua9RduFpFlPOKHNX5J
	gmzx4kh38+DRTyDUl/MNuJEC7YytRZmOTR5g0LF1wucDw50AFr44T/3KBF+jW1p3a7SvH+f50ja
	NYHW4ABCqE0oLxT+mF0lqupD7utVnQbM=
X-Gm-Gg: ASbGncvzALXQhKBkflmTjUoMZzxnB+TI/yN9X0sah2PZnk4iyMur1FYLhzu8e4wYF39
	ptdIcHShaEwhtCmnaxG5lJarbb9xatgjLMlNf/9aZ2r3zNvu559NBxLWYSYM69SrSht1b9wmag8
	IENmQSQcsnyZ+fwbBIDZU2cJ9svna551g07o2mOh3jrLs=
X-Google-Smtp-Source: AGHT+IE5NwhLCh0BENHW4qgSxiwk6NKeqBAEMy+pFTehuj1Fi3JE2wK5eYKhyIg06wG329Vzx08ppYz1c2uJnd15Yas=
X-Received: by 2002:a17:90b:2dc6:b0:311:be43:f09a with SMTP id
 98e67ed59e1d1-3158abf404dmr29867a91.9.1750260929884; Wed, 18 Jun 2025
 08:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618000423.779510-1-lakarri@microsoft.com> <CAEjxPJ4z+9yEHiq0nRODqFSErDZnqtBxAOQwMzxgH7=BKTvsNA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4z+9yEHiq0nRODqFSErDZnqtBxAOQwMzxgH7=BKTvsNA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 18 Jun 2025 11:35:18 -0400
X-Gm-Features: AX0GCFvM_KNRtmKP_R8k8TTVdGefNYKEmV_vx-HZHEwhtGKJandcOxMFwy9OCLM
Message-ID: <CAEjxPJ4yfnRdGqw8ErM9WSv_MWH+TNmXfd-uFsanpt_V-Ai5WQ@mail.gmail.com>
Subject: Re: [PATCH] Expect Key error for module_load test in lockdown mode
To: Sindhu Karri <klsssindhu@gmail.com>
Cc: selinux@vger.kernel.org, Sindhu Karri <lakarri@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 10:51=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 17, 2025 at 8:04=E2=80=AFPM Sindhu Karri <klsssindhu@gmail.co=
m> wrote:
> >
> > From: Sindhu Karri <klsssindhu@gmail.com>
>
> Move your subject line here to the patch description, replace your
> subject line with something like:
> [PATCH testsuite] tests/module_load/test: handle kernel lockdown correctl=
y
>
> > Signed-off-by: Sindhu Karri <lakarri@microsoft.com>
> > ---
> >  tests/module_load/test | 38 ++++++++++++++++++++++++++++++++++----
> >  1 file changed, 34 insertions(+), 4 deletions(-)
> >
> > diff --git a/tests/module_load/test b/tests/module_load/test
> > index 98c5946..de3812b 100755
> > --- a/tests/module_load/test
> > +++ b/tests/module_load/test
> > @@ -25,10 +25,40 @@ BEGIN {
> >      plan tests =3D> 17;
> >  }
> >
> > +# Read current lockdown mode
> > +my $lockdown_mode;
> > +if (open(my $fh, '<', '/sys/kernel/security/lockdown')) {
> > +    my $line =3D <$fh>;
> > +    close($fh);
> > +
> > +    if ($line =3D~ /\[([^\]]+)\]/) {
> > +        $lockdown_mode =3D $1;
> > +    } else {
> > +        warn "Warning: Could not determine active lockdown mode, assum=
ing lockdown mode is 'none'.";
> > +        $lockdown_mode =3D "none";
> > +    }
> > +} else {
> > +    warn "Warning: Cannot read /sys/kernel/security/lockdown, assuming=
 lockdown mode is 'none'.";
> > +    $lockdown_mode =3D "none";
> > +}
> > +
> > +print "Current lockdown mode: $lockdown_mode\n";
>
> Would remove this debugging output.

Also, please run perltidy on the test script and ensure that
tools/check-syntax runs cleanly.

>
> > +
> > +# In cases 1 and 5,
> > +# In lockdown integrity mode, the expected error code is 129 i.e. Key =
is rejected by the service error
> > +# In lockdown none mode, no error is expected.
> > +$expected_pass =3D ($lockdown_mode eq 'none') ? 0 : 129;
> > +
> > +# In cases 4 and 8,
> > +# In lockdown integrity mode, the expected error code is 129 i.e. Key =
is rejected by the service error
> > +# In lockdown none mode, the error expected is 13 i.e.  EACCES
> > +$expected_fail =3D ($lockdown_mode eq 'none') ? 13 : 129;
> > +
> > +
> >  print "Test finit_module(2)\n";
> >  $result =3D system
> >  "runcon -t test_kmodule_t $basedir/finit_load $v $basedir setest_modul=
e_request";
> > -ok( $result eq 0 );
> > +ok( $result >> 8 eq $expected_pass );
> >
> >  # Deny capability { sys_module } - EPERM
> >  $result =3D system
> > @@ -43,12 +73,12 @@ ok( $result >> 8 eq 13 );
> >  # Deny system { module_request } - EACCES
> >  $result =3D system
> >  "runcon -t test_kmodule_deny_module_request_t $basedir/finit_load $v $=
basedir setest_module_request 2>&1";
> > -ok( $result >> 8 eq 13 );
> > +ok( $result >> 8 eq $expected_fail );
> >
> >  print "Test init_module(2)\n";
> >  $result =3D system
> >  "runcon -t test_kmodule_t $basedir/init_load $v $basedir setest_module=
_request";
> > -ok( $result eq 0 );
> > +ok( $result >> 8 eq $expected_pass );
> >
> >  # Deny capability { sys_module } - EPERM
> >  $result =3D system
> > @@ -63,7 +93,7 @@ ok( $result >> 8 eq 13 );
> >  # Deny system { module_request } - EACCES
> >  $result =3D system
> >  "runcon -t test_kmodule_deny_module_request_t $basedir/init_load $v $b=
asedir setest_module_request 2>&1";
> > -ok( $result >> 8 eq 13 );
> > +ok( $result >> 8 eq $expected_fail );
> >
> >  SKIP: {
> >      skip(
> > --
> > 2.33.8
> >
