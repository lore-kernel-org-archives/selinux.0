Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5252C477982
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684600; cv=pass; b=kH6kpFyWgEAlOFqaG1vKDUoKq+3Ai4nWNSX1dXGrZ7MrGdtL4CKFg2JJtWt529G/HFUFDgmAa05UsZGFq5cNP4bT2k7kjx93rFprH4luZbFn0i7lZiyTlybTaSce+sBZKSaTBSeN/1F70/NVRokI1OSeOD6usFFgOH3cGLlZBOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684600; c=relaxed/simple;
	bh=pEleWVvb+qocMx1WFdp/vzXOxHHbBgEJoy9GVdapOQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIppMkhGGq4WFJPX72fjpJ4exguunImpSjmI5XTrPhwduGLGK7hFwrQYR4NY5wsb1AGdRVAmwWWa73cVhhZEaLVzCYWM8V6xMVJMdubDDKe/duxa8lht5Y7wJLwejjSATk6UTIJ3i0LXDR9ZOZ15GHw7b7ssr0h6I4gPq/O+Cfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwI2X+Ih; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwI2X+Ih"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3942e9977a5so26819481fa.1
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 08:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778684597; cv=none;
        d=google.com; s=arc-20240605;
        b=REIS7uP9f0tJetPtHv0Ys9mlDCUrxeus2pxM1XZh1vUHVslObJzenwgQOUbBLtrDOM
         Pj3ksF++vR7dxtsiRPvyj+xL4NKLiBOQsr4+b6pgd5CLa9I53By2rdq/EsRlgs7xjMQX
         mTC2Q4GvLHb30cVlMfSBXXVYj9FzxHQ3l5BQ/6TgGxFbNdOmy36yosAbHzQiyx9NbumR
         1gDOYkQgYdJQfmpnjKPVSbg3xUinFhccMgrFSpawdRbJ6r3efDx0UkqEj9JrIuFBVDGC
         SctB1QptM6Vj139EnXOy2VLaWKiy2ukN7O7gBqYgqSyuWPIis1/grCutgjHWQjyZLQ0j
         WWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YAeYL1QTeZ6EuZ6UB8om7RXpWQcqeAUKT8dJd8gS/+c=;
        fh=+D6xJ6BB9J6NyoJZZl71KoOEMrrFPGwz9kIyEgHHWvo=;
        b=B058RoxngOP6pWbU3PDXTswQsEZo4IqCUC1m2y9/fMh9JhmrVFAYeOPsvfPrFeA16r
         aslrgqDyYnUylYebfzPIBLsRtfS6cz3jndn2uRUF1YneKojviJsF2ODnNztQw3+MKGcr
         NcaFVJQ2SCRBeP1aXCHAu5Ov6gQhWbCZvkOWVJVocTUvhEyvaoncGZkUPeO0j14uWtsk
         qAODAhz0gFnsInTtk/Y8PPcZvl6sbBzX9FaQ1K0Si1Uwg4YM6ZEDgdgVCXtTYlExjkeP
         SQnXxxuRPkgKH+oIlONOb4M6OuodlOt7UE4vMFlMowYKiRKOKNH+PMvXSbMS2A8mhhfq
         +Ktw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778684597; x=1779289397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAeYL1QTeZ6EuZ6UB8om7RXpWQcqeAUKT8dJd8gS/+c=;
        b=PwI2X+IhXw22690KNgiYSWxdkMStK7+jL6bIrl7L6YlMBYhBvc0T/O5ADNZBJZHHHn
         tbbwdEKaNHutRvBEQ/4X4BHmtsIBTWhBsBtvJO5rW9A2kWZVwcLDf+g5qm50NX1ygXps
         io8dZ7CzMDYKSJJhjPn7YidoeIh6nKyGHRtkbvsRQqZxtt5lsWVncChXvWdKJBn2hRY+
         7lfWyZPH9ALrutmLaNwdfgwJZOpfRLboCbNyDj0mQIC+5M77IPyifb7E/8gMhBjRd/8I
         c1qzHBtbFWRUG4qmPtJX820mVmIZkancWk9TRYrsS6993t0T/4eUiTh2PFTUtdNgf/gY
         CNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778684597; x=1779289397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YAeYL1QTeZ6EuZ6UB8om7RXpWQcqeAUKT8dJd8gS/+c=;
        b=FiJRg3r95Wk8Jh2FEQkeBEhfCL+jA6sT5IW9t3FpCiQbqOmjBqcF2VBt/sb3KDyeiP
         PMIWzj5ePRYeLQ99uJLEtDOdWeO7lpa+EL81zfvSIriizjBiCrUIwvb9YS6z4wYJzS8X
         YA/z5Pp4rb3lVd69UCyn7/ULJTAD9HGwGHpWSwUf42dFJeKBxDT1Pg2Ar6rcPUrSSh6z
         Wymdo6kRGBrm5Gj4/DLOBj1H846HH2KGzIZlaEeS3PveZZ8/AMVx+Ia+zJcXML/O3Y9G
         P1xnwn19/aC1SOFxuT62aRa5sG/X4fOH7S9K6hAelFps1VCgsqJGXgrI9X/I/hjisCiu
         gPQw==
X-Gm-Message-State: AOJu0YzKVWh8yP+mDWlv4pCAcresx/KQg7qfQXhc3mwnTDMTpDZDeehe
	/RV7SxDWhpUBRLLRpgP/QaGYeK3bmJbBPA2/9Y0HvNfbpX3pdLiTtgzZX+SsLKIuQmabQGJ/miB
	cI5znsqQhd0cbBJlhyzm/HqaWijST7gDhNrYI
X-Gm-Gg: Acq92OFfOnsQ1vNlJuHFP66K9lSRUPx7/TeUi/LDkkc7fuYNzF8aAV4HYw+pWK6hyMb
	3lRij9gtmp2FAvl+UHRXpxc4AXtUXXBzaj6boVLSg+MUErUwYy++e9VM7+J1jJjMZrqEkg8fakv
	RRZRnlvnIyRkSyeRB3tNYkF/8sPDkyLm4ws5wGjoctsDtaQqCkws+7rq/io9ASNGI0ZhsWyDnUE
	KFYbdOkapdI/IS2A0kWaJpBm7/aapLPCo31X01/QZYeWdql1NrgPRcaHrVHryB7xT4R8JY3Thve
	bBa9
X-Received: by 2002:a05:651c:4010:b0:38e:8c66:c02e with SMTP id
 38308e7fff4ca-3943837ebcemr19668801fa.4.1778684597204; Wed, 13 May 2026
 08:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413174043.3733803-2-nvraxn@posteo.uk>
In-Reply-To: <20260413174043.3733803-2-nvraxn@posteo.uk>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 May 2026 11:03:04 -0400
X-Gm-Features: AVHnY4JxywGWC58Te4VM1vmy9Wa4jvVHB-pStibiUK-wpCkNVU8HJXM-1eqVp00
Message-ID: <CAP+JOzRZm-j1+SP3cuJ+gA_-b8AxwHqivmyv=rsCw+LjF-Z-zw@mail.gmail.com>
Subject: Re: [PATCH] cil_reference_guide: update specification for valid symbols
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 1:43=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> wro=
te:
>
> Currently, the specification has a very limited character set of valid
> symbols. This does not reflect was libsepol (and by extension secilc as
> well) accepts, as can be seen both in spec_char's definition[1], which
> symbol is comprised of along with digit and alpha, and with some basic
> demonstration (note cil-policy.cil refers to the example CIL minimum
> viable policy provided by the SELinux notebook[2] such that the example
> is not polluted with SID declarations, policy caps, and other fluff):
>
>   carbon ~ # cat <<'EOF' >mytest.cil
>   (filecon /[].@=3D/*-_$%+-!|&^:~`#{}'<>?, any ())
>   EOF
>   carbon ~ # secilc mytest.cil cil-policy.cil
>   carbon ~ # echo $?
>   0
>
> As can be seen above, secilc is perfectly happy to accept a variety of
> characters which are not valid in the specification. Whilst the above
> example does NOT use valid filecon regex, which libsemanage will later
> complain about, that does not matter for the purpose of demonstration:
> a symbol pertains ONLY to what is valid in the language grammar as an
> unquoted string, not what is valid for the filecon statement.
>
> It should be noted as well that this patch drops the backslash symbol,
> '\'. The libsepol definition of spec_char omits it and this can also be
> seen in practice:
>
>   carbon ~ # cat <<'EOF' >mytest.cil
>   (filecon /\. any ())
>   EOF
>   carbon ~ # secilc mytest.cil cil-policy.cil
>   Invalid token '\' at line 1 of mytest.cil
>   Failure adding mytest.cil
>
> As such, no consumers should be impacted by its removal from the spec.
> It also does not seem like a grave omission, so it's probably best to
> just drop it from the spec.
>
> [1] https://github.com/SELinuxProject/selinux/blob/6be1ec3792c11040fd7a3e=
cb1135e54418eb0d57/libsepol/cil/src/cil_lexer.l#L48
> [2] https://github.com/SELinuxProject/selinux-notebook/blob/9888b84b8e76c=
18c6141812d7ffd9b3e2fad6f9e/src/notebook-examples/cil-policy/cil-policy.cil
>
> Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  secilc/docs/cil_reference_guide.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_referen=
ce_guide.md
> index bcd34b68..af883232 100644
> --- a/secilc/docs/cil_reference_guide.md
> +++ b/secilc/docs/cil_reference_guide.md
> @@ -93,7 +93,7 @@ Definitions may be repeated many times throughout the p=
olicy. Duplicates will re
>  Symbol Character Set
>  --------------------
>
> -Symbols (any string not enclosed in double quotes) must only contain alp=
hanumeric `[a-z A-Z] [0-9]` characters plus the following special character=
s: `\.=3D/-_$%@+!|&^:`
> +Symbols (any string not enclosed in double quotes) must only contain alp=
hanumeric `[a-z A-Z] [0-9]` characters plus the following special character=
s: `` [].@=3D/*-_$%+-!|&^:~`#{}'<>?, ``
>
>  However symbols are checked for any specific character set limitations, =
for example:
>
> --
> 2.53.0
>
>
