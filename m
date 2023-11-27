Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlFOj4oX"
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9B8D4D
	for <selinux@vger.kernel.org>; Mon, 27 Nov 2023 12:51:12 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c2139492d9so2742026a12.0
        for <selinux@vger.kernel.org>; Mon, 27 Nov 2023 12:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701118272; x=1701723072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njkGqo32VkbByQFfzEOA79iy+U1vD3E0DNnX01S/r7o=;
        b=WlFOj4oXsXXzRye9DytriAK8jfJFY0k1S/oYlZa+L+QqGcTU6RRdTqlxDptFE0Olj4
         q7bfQwVUoq7ym+i/yjsSgO7D1Pv0DvPgRZt5DdI2ytWKkMD96+H7yWfxgots5Edgm93R
         uRKrNiF4gLnLt6DmpMOPhDOHhdxxCCz1wPn5CRrAen7ANR20iVtT4cQykwT0nVGD8+2h
         /KR8WVnsZqweUaXAE6lh4uifO7+CXGiRQ6msEcl66c/gbLDrl03d5KK1ljiKwPYIc4ua
         b0Dx1fWks3sEZSj5WSRoiQMzyFqAkDpPLA15Z15DT7vM0zVXfzBqG3yaH9rKq/F6bcQz
         UmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701118272; x=1701723072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njkGqo32VkbByQFfzEOA79iy+U1vD3E0DNnX01S/r7o=;
        b=MWC1qJPMf7aiv6Dl6zZZN4VyLHh6vCKxo4T9haOC9Lodkwl7sowOzMscvvkujz8CBL
         tuI6hO+DFB4ydn0EnB8hXR+5rFaQBhfO6Ju3KqSxE9FXaxm6WQq5kqNU+7MPKYWVQY99
         iB6ygVU7QSIe+qVeoaxhneE3+Be9/qVLcN81xCOPzEj6/2WhozgyPIhvHbMR18xf3rYr
         QcrLn+s/1mJh+2n7t35jqN3I4P9uABlkaiZnagWEdbBPNBs2bjPT875H/7+58/d3P5p2
         K9HvUmlrQo7HKt0IJDlBjF4Nu46VRsk1sH9hBCFb06bl7ovGr38+i4S5xvJgkZJsv3bA
         qWxA==
X-Gm-Message-State: AOJu0YxhhLLn/boKqDd9Kw1YK574Sxbc3DuFHGyl9pvzxoYTiNH96/BV
	+DC0PlymU8tFrCzz3L9XqFN9RzPaZvA5/jxjN7M=
X-Google-Smtp-Source: AGHT+IHm7ba941PAsFv08pu8ChAtoF0uC+LIqtrdqvLBnI/x7fq4H9r5Mp6slLte/tkWi9mToaJaKFfq8QRyJN0tBLc=
X-Received: by 2002:a17:90b:3907:b0:27c:ed8e:1840 with SMTP id
 ob7-20020a17090b390700b0027ced8e1840mr12054763pjb.10.1701118271596; Mon, 27
 Nov 2023 12:51:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127173534.1080-2-alanwandke.linux@gmail.com>
In-Reply-To: <20231127173534.1080-2-alanwandke.linux@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Nov 2023 15:51:00 -0500
Message-ID: <CAEjxPJ7yi4vs16bKaxErYNd4tDRE1O3Utn73tApNsFdy1pa17Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] defconfig: add NF_TABLES dependency for
 netlink_socket tests to pass
To: Alan Wandke <alanwandke.linux@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 12:36=E2=80=AFPM Alan Wandke <alanwandke.linux@gmai=
l.com> wrote:
>
> In order to support the NETFILTER_NETLINK protocol, either NF_TABLES or I=
P_SET must be enabled.
> Neither are strict dependencies in Kconfig. Fix this by enabling NF_TABLE=
S in the defconfig.
>
> Before:
>   ./netlinkcreate: socket(AF_NETLINK, SOCK_DGRAM, netfilter/12): Protocol=
 not supported
>   not ok 3
>   # Test 3 got: "256" (./test at line 25)
>   #   Expected: "0"
>   #  ./test line 25 is: ok( $result, 0 );
>
> After:
>   ok 3
>
> Signed-off-by: Alan Wandke <alanwandke.linux@gmail.com>

Looks like we could enable it via a number of different config options
but we need NF_TABLES regardless for the secmark tests in inet_socket
and sctp to run, so adding that to the defconfig makes the most sense.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/defconfig b/defconfig
> index 2783c01..47938c1 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -55,6 +55,7 @@ CONFIG_IPV6_GRE=3Dm
>  CONFIG_SCSI_ISCSI_ATTRS=3Dm
>  CONFIG_NETFILTER_NETLINK=3Dm
>  CONFIG_CRYPTO_USER=3Dm
> +CONFIG_NF_TABLES=3Dm
>
>  # Overlay fs.
>  # This is enabled to test overlayfs SELinux integration.
> --
> 2.42.0
>
