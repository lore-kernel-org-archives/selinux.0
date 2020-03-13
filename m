Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F73EC2BB1D
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 13:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE702074B
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 13:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/D1R+zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCMN7x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:59:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35888 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCMN7x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 09:59:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id j14so10196786otq.3
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BdhSxTol4QerlbBd36EUtcklP8eChNg/EP+xT8Gtlcg=;
        b=S/D1R+zGqormk7pmyVEZxEzXSZAvdKi/ynvMHQm84ym7uYLA6tRIAX6qgjc06SRXlR
         vioueSZzLDWXLq+OZjbpyxIZnu2CCaDgtF4s6YqG9fgbPrq4WwciL3/xQf1ki5hBbhyh
         3wFR/xaD6qv8LloFOt+NFzrfCb9Ln/6HJs3E+7Jnj5jhaTbvHE/LmF6Q133ZNqCKvZ7/
         VyVlqFwUGV3rsKEzw87FR8cVLl9B9e+8YEmmQrMhsXQls1ncpYj0zzSKWim003lqSaEn
         AjesHOZxVUgJGZMZ1/Ln44pcQ2ncQpLnwpsL5DwiLaW+SCXMv7Rhczhq+pcM39h8i2ix
         tk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BdhSxTol4QerlbBd36EUtcklP8eChNg/EP+xT8Gtlcg=;
        b=Dkpimj2b89X2jHywaErpLgIS4VLDabOM/7vOJzPzQlis3+UKjbY2ajZ5NOQ13Vts1h
         XQx8gAnZuo+3Hrdw6JMcjNZidSIV9Kx2pCqkTBqMHSRORnwH8DfyS8DYSDCyBshUfHpV
         MtbB4jSvdjHT4SWdzdTwcYaRTHKI/8rwB+on3IhYOSBIlhzMypiWv3B6s1hrNhWj5G+a
         x7ztat5Lwy8XGR3xyKuyXdZYgYj54b/w96koWWD7YhwhIhlL776dn1K+rmR2lhLlFMME
         v5x2U2X9nxnoWIw5J6vk7QcHGo87Ond3Rn0AH2Q4GHkgr9Lqqn6ex6cD+OhwHb0Shhjg
         GdhA==
X-Gm-Message-State: ANhLgQ0BE3jgOvOen2gvUGA+SWdWke8JzIDda5CJeO9tsV7inkmObo+B
        +Rg0siD5JdOb7L6c5T2QH8Hd9Ih0tNtMeqMEfyZCWA==
X-Google-Smtp-Source: ADFU+vvlGoHTf4vwuixWGWlteKqbFZznI3wJWDE5qyKBneStc7moaXp8HQ5PEZBE98pKeM6cwBgaAn7U/Wm5Zbfxau0=
X-Received: by 2002:a9d:7508:: with SMTP id r8mr11153685otk.116.1584107992228;
 Fri, 13 Mar 2020 06:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200313112921.166817-1-omosnace@redhat.com>
In-Reply-To: <20200313112921.166817-1-omosnace@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 13 Mar 2020 10:01:13 -0400
Message-ID: <CAP+JOzQmr1McXTO49xw60MvLy-4tE9QfSFYj-B+5HXHa=QqB3A@mail.gmail.com>
Subject: Re: [PATCH] secilc: add basic test for policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 13, 2020 at 7:30 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Add a simple test for secilc -O to make sure that it produces the
> expected output. This might produce some false positives when the output
> of secilc/checkpolicy changes slightly, in which case the expected CIL
> will need to be updated along with the change.
>
> The test should normally work even with a checkpolicy built from an
> older tree, as long as it produces the same CIL output, so it uses the
> checkpolicy it finds in PATH by default.
>
> The test policy is taken from an e-mail from James Carter [1] (converted
> to CIL). I have low creativity, so I encourage others to come up with a
> better alternative as a follow-up :)
>
> [1] https://lore.kernel.org/selinux/0480cc58-a4f4-bd0f-9edb-f2befe546578@tycho.nsa.gov/
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  secilc/.gitignore       |   2 +
>  secilc/Makefile         |   9 +++
>  secilc/opt-expected.cil | 139 +++++++++++++++++++++++++++++++++
>  secilc/opt-input.cil    | 169 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 319 insertions(+)
>  create mode 100644 secilc/opt-expected.cil
>  create mode 100644 secilc/opt-input.cil
>
> diff --git a/secilc/.gitignore b/secilc/.gitignore
> index 2d3ff405..164523b0 100644
> --- a/secilc/.gitignore
> +++ b/secilc/.gitignore
> @@ -7,3 +7,5 @@ file_contexts
>  docs/html
>  docs/pdf
>  docs/tmp
> +opt-actual.bin
> +opt-actual.cil
> diff --git a/secilc/Makefile b/secilc/Makefile
> index 16640098..12df982b 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -13,6 +13,10 @@ SECIL2CONF_OBJS := $(patsubst %.c,%.o,$(SECIL2CONF_SRCS))
>  SECILC_MANPAGE = secilc.8
>  SECIL2CONF_MANPAGE = secil2conf.8
>  XMLTO = xmlto
> +DIFF = diff
> +
> +CHECKPOLICY = checkpolicy
> +POL_VERS = $(shell $(CHECKPOLICY) -V | cut -f 1 -d ' ')
>
>  CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
>
> @@ -26,6 +30,9 @@ $(SECILC): $(SECILC_OBJS)
>
>  test: $(SECILC)
>         ./$(SECILC) test/policy.cil
> +       ./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin opt-input.cil
> +       $(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
> +       $(DIFF) opt-expected.cil opt-actual.cil
>
>  $(SECIL2CONF): $(SECIL2CONF_OBJS)
>         $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> @@ -58,6 +65,8 @@ clean:
>         rm -f file_contexts
>         rm -f $(SECILC_MANPAGE)
>         rm -f $(SECIL2CONF_MANPAGE)
> +       rm -f opt-actual.cil
> +       rm -f opt-actual.bin
>         $(MAKE) -C docs clean
>
>  relabel:
> diff --git a/secilc/opt-expected.cil b/secilc/opt-expected.cil
> new file mode 100644
> index 00000000..49e1c2a5
> --- /dev/null
> +++ b/secilc/opt-expected.cil

This file should be in secilc/test/

> @@ -0,0 +1,139 @@
> +(handleunknown deny)
> +(class cl01 (p01a p01b))
> +(class cl02 ())
> +(class cl03 (p03a p03b))
> +(class cl04 (p04a p04b))
> +(class clx (ioctl))
> +(classorder (cl01 cl02 cl03 cl04 clx))
> +(classcommon cl01 cm01)
> +(classcommon cl02 cm02)
> +(common cm01 (p11a p11b))
> +(common cm02 (p22a p22b))
> +(sid kernel)
> +(sid security)
> +(sid unlabeled)
> +(sidorder (kernel security unlabeled))
> +(defaultuser cl01 source)
> +(defaultuser cl02 source)
> +(defaultuser cl03 source)
> +(defaultrole cl01 source)
> +(defaulttype cl02 target)
> +(defaultrange cl03 target low-high)
> +(mls true)
> +(sensitivity s01)
> +(sensitivity s02)
> +(sensitivity s03)
> +(sensitivityorder (s01 s02 s03))
> +(category c01)
> +(category c02)
> +(category c03)
> +(categoryorder (c01 c02 c03))
> +(sensitivitycategory s02 (c01 c03))
> +(sensitivitycategory s03 ((range c01 c03)))
> +(mlsconstrain (cl01 (p01a)) (and (dom h1 h2) (domby l1 h1)))
> +(mlsvalidatetrans cl02 (or (eq l1 l2) (eq t3 tpo)))
> +(mlsvalidatetrans cl02 (or (eq l1 l2) (incomp l1 l2)))
> +(mlsvalidatetrans cl02 (or (eq u1 u2) (eq t3 tpo)))
> +(policycap network_peer_controls)
> +(policycap open_perms)
> +(typeattribute at02)
> +(boolean b01 false)
> +(boolean b02 true)
> +(type tp01)
> +(type tp02)
> +(type tp03c)
> +(type tp03p)
> +(type tp04)
> +(type tpo)
> +(type tpr1)
> +(type tpr2)
> +(type tpr3)
> +(type tpr4)
> +(type tpr5)
> +(type tpx)
> +(typebounds tp03p tp03c)
> +(typeattributeset at02 (tp01 tp02))
> +(typepermissive tp01)
> +(allow at02 tpo (cl02 (p22b)))
> +(allow at02 tpr1 (cl01 (p11a p01a p01b)))
> +(allow at02 tpr3 (cl01 (p11a p01a p01b)))
> +(allow tp01 self (cl01 (p11a p11b p01a p01b)))
> +(allow tp01 tpo (cl02 (p22a)))
> +(allow tp01 tpr1 (cl01 (p11b)))
> +(allow tp03c tpo (cl03 (p03a)))
> +(allow tp03p tpo (cl03 (p03a p03b)))
> +(allow tp04 tpx (clx (ioctl)))
> +(auditallow tp01 tpo (cl01 (p01a)))
> +(dontaudit at02 tpr2 (cl01 (p11a p01a p01b)))
> +(dontaudit at02 tpr4 (cl01 (p11a p01a p01b)))
> +(dontaudit tp01 tpo (cl01 (p01b)))
> +(dontaudit tp01 tpr2 (cl01 (p11b)))
> +(allowx tp04 tpx (ioctl clx ((0x1234))))
> +(auditallowx tp04 tpx (ioctl clx ((0x9911))))
> +(dontauditx tp04 tpx (ioctl clx ((0x9922))))
> +(typetransition tp01 tpo cl01 tp02)
> +(typemember tp01 tpo cl02 tp02)
> +(typechange tp01 tpo cl03 tp02)
> +(typetransition tp01 tpo cl04 file01 tp02)
> +(rangetransition tp01 tpo cl01 ((s02) (s02)))
> +(rangetransition tp01 tpo cl02 ((s02) (s03 (c01 c02))))
> +(booleanif b01
> +    (true
> +        (allow tp01 tpr3 (cl01 (p11b)))
> +        (allow tp01 tpr5 (cl01 (p11a p11b p01a p01b)))
> +        (allow tp02 tpr5 (cl01 (p11a p01a)))
> +        (dontaudit tp01 tpr4 (cl01 (p11b)))
> +    )
> +    (false
> +        (allow at02 tpr5 (cl01 (p11a p01a p01b)))
> +    )
> +)
> +(role auditadm_r)
> +(role object_r)
> +(role rl01)
> +(role rl02)
> +(role rl03c)
> +(role rl03p)
> +(role secadm_r)
> +(roletype rl01 tp01)
> +(roletype rl01 tp02)
> +(roletype rl02 tp02)
> +(roletype rl03c tp03c)
> +(roletype rl03p tp03p)
> +(roletype object_r tp01)
> +(roletype object_r tp02)
> +(roletype object_r tp03c)
> +(roletype object_r tp03p)
> +(roletype object_r tp04)
> +(roletype object_r tpo)
> +(roletype object_r tpr1)
> +(roletype object_r tpr2)
> +(roletype object_r tpr3)
> +(roletype object_r tpr4)
> +(roletype object_r tpr5)
> +(roletype object_r tpx)
> +(roletransition rl01 tpo cl01 rl02)
> +(roleallow rl01 rl02)
> +(user us01)
> +(userrole us01 object_r)
> +(userrole us01 rl01)
> +(userlevel us01 (s01))
> +(userrange us01 ((s01) (s03 ((range c01 c03)))))
> +(constrain (cl01 (p01b)) (not (and (eq t1 tpo) (neq u1 u2))))
> +(validatetrans cl02 (or (eq u1 u2) (eq r1 r2)))
> +(sidcontext kernel (us01 rl01 tp01 ((s01) (s03 ((range c01 c03))))))
> +(sidcontext security (us01 rl01 tp01 ((s01) (s02))))
> +(sidcontext unlabeled (us01 rl01 tp01 ((s02 (c01 c03)) (s03 (c01 c03)))))
> +(fsuse xattr fs01 (us01 rl01 tp01 ((s01) (s01))))
> +(fsuse trans fs03 (us01 rl01 tp01 ((s01) (s01))))
> +(fsuse task fs02 (us01 rl01 tp01 ((s01) (s01))))
> +(genfscon fs04 / (us01 rl01 tp01 ((s01) (s01))))
> +(portcon udp 1000 (us01 rl01 tp01 ((s01) (s01))))
> +(portcon tcp 2000 (us01 rl01 tp01 ((s01) (s01))))
> +(portcon dccp 3000 (us01 rl01 tp01 ((s01) (s01))))
> +(portcon udp (1001 1009) (us01 rl01 tp01 ((s01) (s01))))
> +(portcon tcp (2001 2009) (us01 rl01 tp01 ((s01) (s01))))
> +(portcon dccp (3001 3009) (us01 rl01 tp01 ((s01) (s01))))
> +(netifcon if01 (us01 rl01 tp01 ((s01) (s01))) (us01 rl01 tp02 ((s01) (s01))))
> +(nodecon (10.0.0.1) (255.255.255.0) (us01 rl01 tp01 ((s01) (s01))))
> +(nodecon (fc00::1) (fc00::ffff) (us01 rl01 tp01 ((s01) (s01))))
> diff --git a/secilc/opt-input.cil b/secilc/opt-input.cil
> new file mode 100644
> index 00000000..8951360b
> --- /dev/null
> +++ b/secilc/opt-input.cil

Same for this one. It should be in secilc/test/

I can trim these policies and make them smaller. I'll send you smaller versions.

Thanks,
Jim
