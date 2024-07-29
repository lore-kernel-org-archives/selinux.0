Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9735146580
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264715; cv=none; b=AMD0ZyCiiK26XAk1Xt8aNIamqHY97wvIjxXjt2bO+f5PTRtTz0cX+taIbyI8qSBknSfAHX7LNxICAe3YaUXyGfJS6fqNS0+giJY6uI2zcCqcfAPHZ9fbsX9HneCzcNvL0ec+CbO1FWslB61a8D2WOWmYjIqz3cvO27Q1uVm6Bwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264715; c=relaxed/simple;
	bh=5XljznZlMeHI+6oJqQ2gKh9Qyxo1HA7sHnNYTvsdBnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoxAFgCLoXwhCzyVakc6SC5oTNso3C7ZxvHy1Nr0UAxMb9i919Tg5BkSYFBzEwZji2Bou2N9qY7WMokWuBk4DHlmXMAQJkonv16eh8aLZy9itP9qR+dUOuT/pwOgEU0qshP/bG2ZZjEf1PngW41UZmNSaXGWw1QrvwqDSuJ5GzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMqCN3lL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMqCN3lL"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cd1661174cso2082056a91.0
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722264713; x=1722869513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5orItssSn6koBq8aYvuhr/bCqZez3n3bly1QssOC+I=;
        b=AMqCN3lLPA1t/metVlrDbympQMzBDs5EvoYUKbhVNI7Ohh4vEm8w9YXD86BVmWanQL
         b0WH7jmqupiPe+mY9lHmX3RDzvtqvDO6KyYevxN5P4I6FW8zBHFGAaJh5BXCSvG4rwlS
         EQtvW9NHCoh6L6ZPz9zR0pjX5bZhtB7SHpyjGQyEon5/PpVFvK64ZVPmWdmW+A2RCByK
         A4RHH5zYN0SPti/OPuqa6uiusXf2Ot2uHmtzhjckdTTXpZLDbIY7iwos3LigAbxd5QG6
         BfmYq9U2GGJvdB8PuSV06LV4BMxiHkNqVIEw1izS1Tn7gUi5oc4GmK3EeHo46H2IZgqf
         QIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264713; x=1722869513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5orItssSn6koBq8aYvuhr/bCqZez3n3bly1QssOC+I=;
        b=IY3GWWW/I0EhIudGoLikaZLEkyoI1OQHNPZ6f2g72tOE9XkInD6A5cG1okx/3vr81o
         6kMGi10ywyOPz+mlRqtoSdNRH+vVBq+sC+x3g6YB/+YeyBZKuJJR2JHo6tOziWhkLuf3
         LvwnUJO3QAuH/v+IljeiTlxRRovDRR1JIMHC+du9TqURhSmXIWYGwHO6z0Akx0lNXYFb
         CYmCJxKXC70u+azlXo4XPS1uai+yiN2ksPbEXShVvSB+mQvEelwgYpAVaiaK4flfU0EU
         WIaZc2mh+Ae4Tvf7QswPer4f7WJeUjAG1obyIZV459rAfklCkNuERtUEBzW2GsbmMzi2
         BB7Q==
X-Gm-Message-State: AOJu0YxWfu7hnq/6NXfST4GSSQfM1nOZthJJ27DNZotaOm1OiWA07KfK
	VmoSa+t/KQ7Wcufx7fSvxtIkeycP8hNSKFRTzgyg2W446sHZVogYachQmaiMPFoanFufzrh+mC3
	AFy22XcUHAILvPyyzzu1DWXoNm477Vg==
X-Google-Smtp-Source: AGHT+IExpsCJOfoIJTJ+Di5RGQIeF33Ol9zNX69+3WqrLCWYlMOIEJrVZBj0n26YFkOfl/xDaog/tfgc91lk8nIy02g=
X-Received: by 2002:a17:90b:4b4f:b0:2cd:2f63:a447 with SMTP id
 98e67ed59e1d1-2cf7e831837mr5765886a91.36.1722264712938; Mon, 29 Jul 2024
 07:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEeCnGzRMiiDZKaDgnX_dqpeK5rM=aO5zBZ6frWJT4WQj5cVEQ@mail.gmail.com>
In-Reply-To: <CAEeCnGzRMiiDZKaDgnX_dqpeK5rM=aO5zBZ6frWJT4WQj5cVEQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jul 2024 10:51:41 -0400
Message-ID: <CAEjxPJ6VQB6XVEa9k0brDZNPVN2RRNqHd7ZQaZN2CM2K8ZrHkg@mail.gmail.com>
Subject: Re: UnicodeDecodeError: utf-8 on python semanage -i import
To: Allan Oepping <allan@intellipay.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 1:19=E2=80=AFPM Allan Oepping <allan@intellipay.com>=
 wrote:
>
> Importing a .pp file with the python semanage -i option generates a "Unic=
odeDecodeError: utf-8" on an up to date Rocky 9 distribution.
>
> packages:
>
> policycoreutils-python-utils-3.6-2.1.el9.noarch
> python-unversioned-command-3.9.18-3.el9.noarch
>
> The open() in SetImportFile needs the binary "b" option to open the file =
in binary mode, as the .pp file is not in utf-8 format:

Did you mean to use semodule -i? That's how one imports a policy module.
Also, patches should be -p1 appliable and include a Signed-off-by: line.

>
> --- /semanage~ 2024-07-01 10:29:20.000000000 -0600
> +++ /semanage 2024-07-01 10:54:30.520312298 -0600
> @@ -122,11 +122,11 @@
>  class SetImportFile(argparse.Action):
>
>      def __call__(self, parser, namespace, values, option_string=3DNone):
>          if values and values !=3D "-":
>              try:
> -                sys.stdin =3D open(values, 'r')
> +                sys.stdin =3D open(values, 'rb')
>              except IOError as e:
>                  sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str=
(e)))
>                  sys.exit(1)
>          setattr(namespace, self.dest, values)
>
> patch also attached.
>
> Thanks,
>
> Allan Oepping
