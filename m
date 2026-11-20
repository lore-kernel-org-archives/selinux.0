Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204613;
	b=EQ25mhFrHfUypqj5TshumrXkqDt794IyWPZTa9m9pV8IaBpkpfd3QFTVPZ1R8JUgaJqN
	 d9VTqcqDFwJ7aYX8FE+MzWOm2MtPCjlu+2I9Ar3shOHF7zviCQpyi8FSdWgVRyrIBjQaK
	 Hx17QkUvStavOHHcaj+MUbtQ56i4YDAdyvrvJQ+zQmHFp9DtrX02CANcbxWvtbsOytfeu
	 5X1w/pZV+IEtd98fo5phqT9jKQKLz77kbbojpLFRXbs2sPAPv5i9vKYRdigVqwHf5Cjwl
	 70WvcizjH8SB0m9U3bigsJLh4pCKvpLEEdMiJSaoyMbYN1kWgmh+ooY+vrtDR4ja2Lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aSosBsG7ty7J4fi90dtruity4nSABeBguBYAZvCKnCY=;
	b=1wUt0MGsv9o7inWdLu11FjHsljpl1rMNX3IqnBuDgFVUc6JcSFE0WgZuHSIk1/YGI77g
	 l4725/20YEaOODB+6mQDmYkG2uv4r/zAXOqVlk9EVW0LrbsC1yzvg7Bw4J4q8cYyaORET
	 qJRZ9EWqzzeKM/KBuGmVlvT/wS6o1U30C9BVIU4jUGD1TUGXkU31KyfMXy69P4yZXdd1t
	 tn1A0HKND4pCTEgEzIBx/5ecuz6cNy5gNxJuJ+zvjRBYaJvtGXkGIa+Hnl4SdwB7J1ApA
	 KAk4gJ7JymjmZ3g9lITvCdxNRsUwzQ+pOTvekc6f3AtTxavlc11UwdY6I4gFgP5Fl2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMz0+Evu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8936B606A338
	for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 19:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8936B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMz0+Evu
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67583c777abso1367385d50.1
        for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 11:56:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795204610; cv=none;
        d=google.com; s=arc-20260327;
        b=WZYEusJ0E6zHx/ika0oMbO/qqXc3FBdc7/YjGJdUFdFFzTVZ9Wzv6276VEaFvyXM2+
         DG6hS0umRbjlAJDigx6MStfx00tiK2aD601PUI+Q0RTaDLj3sIVgWi7WZnuh9izkmO21
         Y1KWUxmg397rt8qHb1e6DCKJoOstToyZWHwHQAzDEbUcRgL5eTNjQRK2dM/HOk8m5O6E
         zmuF4+BlwFiuClwEeg8at97mMPFpsqVUDZ/LxmRwckt/TZj7eVZ1krKHW95N2BlUdDkU
         XDDXbpY8Ui0s3kVr3DiiE/rZtKzijTW7bNUxBOzV0yGOvywAw+fvEjOfjEPmA611L/NO
         DaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aSosBsG7ty7J4fi90dtruity4nSABeBguBYAZvCKnCY=;
        fh=QFKa48eN4AZKFIyrSiZk3FCE4nUKAEfyzhRYxfFXB60=;
        b=iiJz//cUD16dut2TEW4Ff4WeU1mYHLPXVSY1aDzL/xZHfMBGwVpjzHnqYBPmiRipsf
         6KH2/0OuBEBW6//Ci9A+Z3aKV5jWkjqX41qmyrQaAm3s5Eng+J0j1AgPW+/Ru13I4+Kf
         t973w8dDcw0M7Llj2GsoT9f1VRIlv0FOf3lEOS66Z8CvDz84ZphEG6zNACT54AAddmUG
         lEjsvQeBUJdJ5vO3mnKXr8PeSgApPGW/EW3QqjGabt0tl/+8RbNiHG5frL0d4uRK8XiY
         Ql4Mhil1Ay+ZSu4vw8CBEPwXDnr2UJsSNumEJ+I5KJbHQ/Z7LFrAqdcZjx3yuUfnMHw/
         LpTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795204610; x=1795809410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSosBsG7ty7J4fi90dtruity4nSABeBguBYAZvCKnCY=;
        b=AMz0+EvuMFiTVGDtTgTT5SQAg8AEq7Iw2Fyb8cSfbRa8sTV5S/UST1JldAQkN/7mMZ
         OiQ696nyS/BVN+dbuhPDJK3KRHirfQaxdJGKVrrB+I1nmJZyBdN38tOshdJcy7EqBjiA
         TdIrAqwGGqMDaqu2dfzmFea4UQ6kMWfgNG0joGWT9r5BNksZkM/CJq3sBioYDRmmq0mc
         ZQlHj1pLausIwxiQLeVq8hNoHCzEMLxBbtnhGf7tX3cuydiwMfPYSlrtVm0ZpcqWrBId
         gsrzFuf6xMxv164UbxAIfdyF9zWc+mwBVWnpGag027TJx7FthhFnkZbrvZ9YTElcpf08
         yPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204610; x=1795809410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSosBsG7ty7J4fi90dtruity4nSABeBguBYAZvCKnCY=;
        b=BGf8w1u8lXmWeGVliepBWPWm16aKVI8fxo6PFqyzqiT+s4BdblExaP9ynGjm7gpN7Q
         e6edcXRmyFw8pRAXHbd7p33OEvITk+GKGdTmnNMhx17seAkwA4XQljkyuqObuI9YxG0M
         faYiBbQtlu3557gx4q58g27PDSkgBEoWwu3C41fJOLFbep5U8ndTehGJ/tLd9GavS55K
         w8np4g04lcUNJ+73EIW8rKCy1A+27JIUxm5H0uISzMPcrFZuplwmBf8wTawaBmYDXNSJ
         QaS9jL4umKpSELcrJSKImDyUrim4YHux9vemCZjra9hJXE40K+P5+JTPHOa/Jbljmo0e
         87YQ==
X-Gm-Message-State: APuU4Z8aO3ZPDon4li3bnXLBdd1d+yv/3YLaix7xD/QR7ThpmpBBlGFh
	S0K1tvbdwdW/8xnMtCjneBrinMMM9wk3chTFf7rANexdZjUjuiQjwatndVISXjZau6iFoG0Zdl8
	fqincmuBcTRh2t2mU8GebX4pYEmIiPBLXWyJ5hZk=
X-Gm-Gg: AZFdTZe9Gshxk3kAuyJrQfybOnK2bzfiPjEydG2ZoFXV+mal8PLuzLlU9JKq9vbKPXF
	w0HezKBmNqNJ4QXHQHB1ItxgvHCkodmaYLs/z5T4XksDCDTignP3MKkwzBcWffD92/q0aoXqJlx
	oQK1D55wb/djZk8lmzrIm/tBmOKKr5z2XAlNQv5WzJhj4MC7wcqArQD9AeIrjn73xVBwzfexI2W
	Hfko08RfqQdPugv6nQU9D6JH4ylRXl2GNCR4kkSVjbg8S32q1pHR+8UbSrDdjrWUI/bnNZysDSs
	AIXms57pVQg07Xcxr+BLK2o+GujJO6a9izMw/X10zShZPA1nL052eKzygAgsHOPXrWIPvcNKx1x
	77p9pCzLubF2E/3ax4Ki/p5zQMzV4+a1sFW+d8Sb2I2dPq80Geq2x87CkCDTUvos+GHrLaY2kFT
	rBsQ6t5swZmmHS9kRSp1jvX8zTBUTybkz0JLmbEwWV5UCfyymeQwxRmBcm3A==
X-Received: by 2002:a05:690e:c86:b0:67d:bcce:d615 with SMTP id
 956f58d0204a3-67dec41f405mr2539469d50.10.1795204609499; Fri, 20 Nov 2026
 11:56:49 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120165005.37638-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261120165005.37638-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 20 Nov 2026 14:56:37 -0500
X-Gm-Features: AclHuK-CY4ru_UgtV0iKHLvNwpGtwGwy3efIXegd77w55s9s1P1G9cNW3PSjHpA
Message-ID: <CAEjxPJ6ekXG8t0ub0ojN3zvY5rRLCsd_0+AXkMgn6gEhkZg+Yw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/tests: clear loader environment without env -i
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 11:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The test-downgrade mkdir was run under env -i so that a host mkdir
> linked against libselinux does not abort under Asan when
> LD_LIBRARY_PATH points at the freshly built, instrumented
> libselinux. On hosts where coreutils is a single multi-call binary
> linked against libselinux (e.g. Ubuntu 26.04), env itself now loads
> the instrumented libselinux and fails the same way before it can clear
> the environment for mkdir.
>
> Clear LD_LIBRARY_PATH and LD_PRELOAD with shell assignments on the
> mkdir command instead; the shell links against neither. Drop the
> now-unused ENV variable.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This change is unnecessary given this change to the build-userspace action:
https://lore.kernel.org/selinux/20261120182758.38923-3-stephen.smalley.work=
@gmail.com/T/#u
so I won't bother applying this one.
We can drop this hackery from the Makefiles entirely with the
build-userspace action change but that can come as a follow up change
after 3.12 is released.


> ---
>  libsepol/tests/Makefile | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
> index a47b452d..45e094ce 100644
> --- a/libsepol/tests/Makefile
> +++ b/libsepol/tests/Makefile
> @@ -1,4 +1,3 @@
> -ENV ?=3D env
>  M4 ?=3D m4 -E -E
>  MKDIR ?=3D mkdir
>  EXE ?=3D libsepol-tests
> @@ -61,14 +60,19 @@ clean:
>         rm -f $(policies)
>         rm -f policies/test-downgrade/policy.hi policies/test-downgrade/p=
olicy.lo
>
> -# mkdir is run in a clean environment created by env -i to avoid failing=
 under ASan with:
> +# mkdir is run with the dynamic loader environment variables cleared to =
avoid
> +# failing under ASan with:
>  #
>  #   ASan runtime does not come first in initial library list;
>  #   you should either link runtime to your application or manually prelo=
ad it with LD_PRELOAD
>  #
> -# when the source code is built with ASan
> +# when the just-built, instrumented libselinux is in LD_LIBRARY_PATH and=
 the
> +# host mkdir links against libselinux. Shell assignments are used instea=
d of
> +# env -i because env may itself link against libselinux (e.g. single-bin=
ary
> +# coreutils implementations) and then fails the same way before it can c=
lear
> +# the environment.
>  test: $(EXE) $(policies) test-conditional-count
> -       $(ENV) -i $(MKDIR) -p policies/test-downgrade
> +       LD_LIBRARY_PATH=3D LD_PRELOAD=3D $(MKDIR) -p policies/test-downgr=
ade
>         ../../checkpolicy/checkpolicy -M policies/test-cond/refpolicy-bas=
e.conf -o policies/test-downgrade/policy.hi
>         ./$(EXE)
>
> --
> 2.56.1
>
