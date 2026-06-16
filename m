Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84E344D88
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637578; cv=pass; b=l52Sif722AD5YrXjj0xYdQjxJdUha1/9GqQfev+igBmK3RAUOJ7Fi9rCmhrCVvAe7b51y7AU4uhnkrs1W3cxLz2WQ0CEa94CRf+flibeRhvnAAavv4hltqYlNfDBljpg8iSzpSQgqJAflEHgl2mcOPcUHoEdPHWSSxbSzi9cmkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637578; c=relaxed/simple;
	bh=U67Mj9zBHF1qCoLk1Ol2AWRCC0Bz/xNzJz8V7g0gmSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdkqGwbORXlT0TVRLU1xcYKkfaVI5bsKTD1vGoSO6IzccugWb9+XZXo7ifzT1ter30GzFJRdNcPPP0JyciXLAyJptvOIVkQ0cmYMkjXu3NVWRpiAngYc7K60vcE2e3g+CJzPPHP1x1d55o58U23X4o5isN0pdpY2kT8JAmA1hWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS6s3FiL; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS6s3FiL"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-842288702fbso2358411b3a.1
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 12:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781637576; cv=none;
        d=google.com; s=arc-20240605;
        b=frHVZYokOzm8SS5dCM2eNoQ3uyM88icI0t71X46FiysYoqByHvuN5cfd4FYwaTfFU9
         /U1amOWpMwt45uJ98Bx0ir6zaCkLGAika4GNbjDeFD0zf94HxNj+i2TYd/lWLpv7i2po
         wEdKnzhfYEQBvZI7w93+TXpu8ZDwcBHvAHXnP2OVCdjVDFJw52CE/h3ZJQlkmfDSrCY3
         MrR8d3d16joOP5m3P1si2D2OTQLQ7NYhmmA/0zqHiYi1a1dZD5Ysl+rhfGjBH/AL8Tmx
         YjwpxbAgNFRVfkAsGYN7B3lAvzgQNGl2rLvDyaRO4lnmsVaDnoFGArOerpvm3Nl0TMCH
         XIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U67Mj9zBHF1qCoLk1Ol2AWRCC0Bz/xNzJz8V7g0gmSs=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Oh3WdBUSK4m2CVazRnsV062BMU1oAjcxP6sHjBeEsA4kPo1Kb3oolRkm9AQ3widsUA
         uI/VTw2LOjQ0Exsk1YnNnGXxFr+twvC7JNynaKj83Pc8xxCWnnLL/0NTU7qIxh8gFVFp
         YW+knGUEUb7QVgtQ+AwEA4OX6pnBlt7qz4AplT1MnEUj5/uj3k3uX2t8U9VroUsn5qEg
         3o5qkqogOIHbYqhx7c1JWkr8HlgAQpm23iho7G+uRplkhZvQfRqbXaULrv+AHgawQab5
         sLAlXvA3I7TJA9YlDlg1Dj6GugVy5v18bv8Rrau6uDCHssEdo1T1c50VqmkCOh9Rcao0
         dIvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781637576; x=1782242376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U67Mj9zBHF1qCoLk1Ol2AWRCC0Bz/xNzJz8V7g0gmSs=;
        b=OS6s3FiLKl7ieLHTGl3Xo+60AIq1Pw/pqj6KoRLwzOcjQUEaT9n1dWPavjPVVCGAHq
         FlZoSYDfe93/GtdOmOip6XjMF2ptyApSNt9E1JFJGTwN+dh1OV32onVSB1kjY6V/9q+j
         vENnDUdQr3HrOj9veLO7eJXWVmMd0nW/wuTUJj/6PCIgpE5/tnQYcjrNp5qGFl+S3a8Q
         e1Xw7E4DHUvQLktsyWsc46Xx6lzmh5/PJjL7rL91ktknX2hxS7DhR70d086uCyLsiZyq
         TguJFrsqow2laKdIfazwXIzVxGZ9k6qKut20NlMVgn9i42iSGul0JvAK1RH7Qvpf6W+6
         5L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637576; x=1782242376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U67Mj9zBHF1qCoLk1Ol2AWRCC0Bz/xNzJz8V7g0gmSs=;
        b=S9mh8BgnY/mw3ekT5nDGP8fqxI9dE1dAoHzEE6JHSSc0pFyPBTPtePmaFYVykOWswq
         hU1k8IBYv38CtcpfFyQtRpNY3XfyKwHqw3xMcJWPZFXc4Nx4MkIO+QHR8T0RgycZtDN8
         0HIVW0tagxuebLftU1vYFETJ+5W+fzjEC5kTqOduZ0I+2YXYjI10qeaqncqQ2QT/JpqI
         ZehqGOpm5MGUnq++awdPalCMSk+L7xKq7b0jit2wfWxvNHKx+3g/+3CXJ967UI7dSq4Y
         pRTfqWR8UZTrxugP01KCcHs4B5RN670Qnx85rGWW1KSyZAOtt2XgqX6iT5GU/bt2sqA0
         REgA==
X-Gm-Message-State: AOJu0YxO6n6VvYDxZJy6tq0A7Cqmk1eXS0gaaisGuc/9KbILSMo2OR/k
	4ovpzKUl/hLxltd0P+OmDksb2COnGKv2sBtCC3yRczfDf5IGWn/SRErlkIDnZkluqu5U+4XuiJ0
	6RZKqGkX7p8NrjUJMiO0JvegsKJeeXQk=
X-Gm-Gg: Acq92OFaflbQMcpHoQhN4SbxVJTtkCS/Cbey8rISbARI88mfMN7Lm9+YfWLSMq1e7Xg
	tWFPN6sO7B16o/zMWKz48G+LJyJNWfTXcuPQgVt7k4dlB7J8yFz/9+Bqnx3j6vlP2K3ILdHE6dJ
	7cg6aCBIcFGXfMhodz15JMe0HClUYKfIB0l/1mB3/ddfpQE3x3D2GD9J0j3ukfNBXoPdtNE7A4a
	G3QraAYuZFsGRivLL9LNJOtqzgoalE7R9J5AC7XHVkTAgRNTUYU36QU+B9LKYk4jKUqptMPdsGR
	+LOI8xs=
X-Received: by 2002:a05:6a20:ce4c:b0:3b2:86c9:baa5 with SMTP id
 adf61e73a8af0-3b8bf0ba4cfmr532032637.38.1781637576497; Tue, 16 Jun 2026
 12:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616150716.42470-1-jwcart2@gmail.com> <CAEjxPJ7VoDULuU=su_Hz_MDBa+Rgi1_RxgeSCo8Z9qJKeKGd1Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ7VoDULuU=su_Hz_MDBa+Rgi1_RxgeSCo8Z9qJKeKGd1Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 15:19:23 -0400
X-Gm-Features: AVVi8CcJvX73ZC4oKJpV7fFLkacU5855EM9e5VIhrSxGJmSzZZV_Fi5zbD2mwL4
Message-ID: <CAEjxPJ4h5fuLPCxEzvJnsQ-dV-vdX=XvKO-+c7nvmVMTGCZaUQ@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: Check for proper length of addr and mask buffers
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:17=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 16, 2026 at 11:07=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > When creating an ocontext node the addr and mask buffers lengths
> > are not being checked that they are the correct value for the
> > protocol.
> >
> > Verify that the addr and mask buffer lengths are the correct vaalue
> > for the protocol and output an error if they are not.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
