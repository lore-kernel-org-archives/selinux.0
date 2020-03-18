Return-Path: <SRS0=MhFn=5D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A2DC10DCE
	for <selinux@archiver.kernel.org>; Wed, 18 Mar 2020 18:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2B020719
	for <selinux@archiver.kernel.org>; Wed, 18 Mar 2020 18:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1LzXMXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgCRSDE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:03:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44214 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCRSDE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Mar 2020 14:03:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id a49so23721521otc.11
        for <selinux@vger.kernel.org>; Wed, 18 Mar 2020 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wNFpxy8RFCAMLGf5izSt7S54RSG0zgyZt5hyhavnIiI=;
        b=l1LzXMXgnBOkE7Ahwn1J3CYcCnlBM+wY2XEweP3wnsDQbHILcwjP/hVsJwwLfzdovD
         b3Fp0kL8XZW5zb7KINYH0e/xqD09fY+wWMZADOa9XYNlQmvU7ukrFT6VMwAc9SlvzQJJ
         iYKfzwEKE1GQtFi1jUIIqvpXsOK5umHFyvjk68dygte6tvjOXbw7sVPAhLhKfVOKYk4D
         P9RAdz/wZvHbUSvxmchTTpUCBpGRKz6MdHts6U81CnGj9cdeGpbe/zTOjhhEvHcCGbT9
         7yivnF1M3EP13cLgYU4AJjlQfP9YjuBeS9Q406xiHGV2WMSnqxb3Vf3fz9P1Ue99fA+u
         DaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wNFpxy8RFCAMLGf5izSt7S54RSG0zgyZt5hyhavnIiI=;
        b=pDgmMycI6cZtzzAw/2BMG2xmH4U0THAaSK0UgbN8SkkkpzId+UCgEjSg3S28f/dXke
         R2coV15G+XHYelYpxuaLmdjigTrdGNSAHZGK2dCldLoDY7gRSvptgxkH2m7UOIq3tWmv
         IiZmv/dMfTcLjUTOaaKLHyPHY7pDPdCUsqxO3942VP97E6XLVjhbkMRNvr2v0Uy12JUG
         6DsAzTATrFt/VXRkdjsRjVQZ9AzMQlQZay9TFsCz361Y6G60j8xcr71wrdd5h/wpHn41
         avqCvWwhVMe9d0KXKMBsvhGIM27wQ01yQJWc9nKUHRZDnKp9JW4SWUQC2h64oC4Mqh7M
         PXGg==
X-Gm-Message-State: ANhLgQ0ohIo9AZ8l5uzmplTK91PPAvQYXvHFoE75Xelirk+vH4GWd9OI
        BI0RK1XKYhEist5FinOcLbac8mFn7amVAVnXfII=
X-Google-Smtp-Source: ADFU+vsUP6Yn4g0LQd9ui+uELFYKE973Dq+DmTDjYTlXjqxW8CYqstOUHSClthOv0J3R3kf2rIZFhlEsJVpIQAosaiA=
X-Received: by 2002:a05:6830:4008:: with SMTP id h8mr5096620ots.295.1584554578025;
 Wed, 18 Mar 2020 11:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200316095523.335474-1-omosnace@redhat.com> <CAP+JOzSxrhyXDjVUG_vLZygWKYKtqMAd5U3Xj0k=wQsCo9w6ug@mail.gmail.com>
In-Reply-To: <CAP+JOzSxrhyXDjVUG_vLZygWKYKtqMAd5U3Xj0k=wQsCo9w6ug@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 18 Mar 2020 14:04:26 -0400
Message-ID: <CAP+JOzR1tG3mntHeQRLtvMZkRuni2vSEnCTCxJu1XMbk6JEk7A@mail.gmail.com>
Subject: Re: [PATCH v2] secilc: add basic test for policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 16, 2020 at 10:08 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Mar 16, 2020 at 5:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Add a simple test for secilc -O to make sure that it produces the
> > expected output. This might produce some false positives when the output
> > of secilc/checkpolicy changes slightly, in which case the expected CIL
> > will need to be updated along with the change.
> >
> > The test should normally work even with a checkpolicy built from an
> > older tree, as long as it produces the same CIL output, so it uses the
> > checkpolicy it finds in PATH by default.
> >
> > The test policy is taken from an e-mail from James Carter:
> > https://lore.kernel.org/selinux/CAP+JOzTQQx6aM81QyVe0yoiPJeDU+7xE6nn=0UMAB1EZ_c9ryA@mail.gmail.com/T/
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Applied. Thanks,
Jim


> > ---
> >
> > v2:
> >  - move test policies to the 'test' subdirectory
> >  - use a simplified test policy supplied by James
> >
> >  secilc/.gitignore            |  2 ++
> >  secilc/Makefile              |  9 +++++
> >  secilc/test/opt-expected.cil | 57 +++++++++++++++++++++++++++++++
> >  secilc/test/opt-input.cil    | 65 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 133 insertions(+)
> >  create mode 100644 secilc/test/opt-expected.cil
> >  create mode 100644 secilc/test/opt-input.cil
> >
> > diff --git a/secilc/.gitignore b/secilc/.gitignore
> > index 2d3ff405..164523b0 100644
> > --- a/secilc/.gitignore
> > +++ b/secilc/.gitignore
> > @@ -7,3 +7,5 @@ file_contexts
> >  docs/html
> >  docs/pdf
> >  docs/tmp
> > +opt-actual.bin
> > +opt-actual.cil
> > diff --git a/secilc/Makefile b/secilc/Makefile
> > index 16640098..d4a1c35a 100644
> > --- a/secilc/Makefile
> > +++ b/secilc/Makefile
> > @@ -13,6 +13,10 @@ SECIL2CONF_OBJS := $(patsubst %.c,%.o,$(SECIL2CONF_SRCS))
> >  SECILC_MANPAGE = secilc.8
> >  SECIL2CONF_MANPAGE = secil2conf.8
> >  XMLTO = xmlto
> > +DIFF = diff
> > +
> > +CHECKPOLICY = checkpolicy
> > +POL_VERS = $(shell $(CHECKPOLICY) -V | cut -f 1 -d ' ')
> >
> >  CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
> >
> > @@ -26,6 +30,9 @@ $(SECILC): $(SECILC_OBJS)
> >
> >  test: $(SECILC)
> >         ./$(SECILC) test/policy.cil
> > +       ./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
> > +       $(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
> > +       $(DIFF) test/opt-expected.cil opt-actual.cil
> >
> >  $(SECIL2CONF): $(SECIL2CONF_OBJS)
> >         $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> > @@ -58,6 +65,8 @@ clean:
> >         rm -f file_contexts
> >         rm -f $(SECILC_MANPAGE)
> >         rm -f $(SECIL2CONF_MANPAGE)
> > +       rm -f opt-actual.cil
> > +       rm -f opt-actual.bin
> >         $(MAKE) -C docs clean
> >
> >  relabel:
> > diff --git a/secilc/test/opt-expected.cil b/secilc/test/opt-expected.cil
> > new file mode 100644
> > index 00000000..73ac9045
> > --- /dev/null
> > +++ b/secilc/test/opt-expected.cil
> > @@ -0,0 +1,57 @@
> > +(handleunknown deny)
> > +(class cl01 (p01a p01b p11a p11b))
> > +(classorder (cl01))
> > +(sid kernel)
> > +(sidorder (kernel))
> > +(mls true)
> > +(sensitivity s01)
> > +(sensitivityorder (s01))
> > +(category c01)
> > +(categoryorder (c01))
> > +(sensitivitycategory s01 (c01))
> > +(typeattribute at02)
> > +(boolean b01 false)
> > +(type tp01)
> > +(type tp02)
> > +(type tp04)
> > +(type tpr1)
> > +(type tpr2)
> > +(type tpr3)
> > +(type tpr4)
> > +(type tpr5)
> > +(typeattributeset at02 (tp01 tp02))
> > +(allow at02 tpr1 (cl01 (p01a p01b p11a)))
> > +(allow at02 tpr3 (cl01 (p01a p01b p11a)))
> > +(allow tp01 self (cl01 (p01a p01b p11a p11b)))
> > +(allow tp01 tpr1 (cl01 (p11b)))
> > +(dontaudit at02 tpr2 (cl01 (p01a p01b p11a)))
> > +(dontaudit at02 tpr4 (cl01 (p01a p01b p11a)))
> > +(dontaudit tp01 tpr2 (cl01 (p11b)))
> > +(booleanif b01
> > +    (true
> > +        (allow tp01 tpr3 (cl01 (p11b)))
> > +        (allow tp01 tpr5 (cl01 (p01a p01b p11a p11b)))
> > +        (allow tp02 tpr5 (cl01 (p01a p11a)))
> > +        (dontaudit tp01 tpr4 (cl01 (p11b)))
> > +    )
> > +    (false
> > +        (allow at02 tpr5 (cl01 (p01a p01b p11a)))
> > +    )
> > +)
> > +(role object_r)
> > +(role rl01)
> > +(roletype rl01 tp01)
> > +(roletype object_r tp01)
> > +(roletype object_r tp02)
> > +(roletype object_r tp04)
> > +(roletype object_r tpr1)
> > +(roletype object_r tpr2)
> > +(roletype object_r tpr3)
> > +(roletype object_r tpr4)
> > +(roletype object_r tpr5)
> > +(user us01)
> > +(userrole us01 object_r)
> > +(userrole us01 rl01)
> > +(userlevel us01 (s01))
> > +(userrange us01 ((s01) (s01)))
> > +(sidcontext kernel (us01 rl01 tp01 ((s01) (s01))))
> > diff --git a/secilc/test/opt-input.cil b/secilc/test/opt-input.cil
> > new file mode 100644
> > index 00000000..5bb6c266
> > --- /dev/null
> > +++ b/secilc/test/opt-input.cil
> > @@ -0,0 +1,65 @@
> > +(handleunknown deny)
> > +(class cl01 (p01a p01b p11a p11b))
> > +(classorder (cl01))
> > +(sid kernel)
> > +(sidorder (kernel))
> > +(mls true)
> > +(sensitivity s01)
> > +(sensitivityorder (s01))
> > +(category c01)
> > +(categoryorder (c01))
> > +(sensitivitycategory s01 (c01))
> > +(typeattribute at01)
> > +(typeattribute at02)
> > +(boolean b01 false)
> > +(type tp01)
> > +(type tp02)
> > +(type tp04)
> > +(type tpr1)
> > +(type tpr2)
> > +(type tpr3)
> > +(type tpr4)
> > +(type tpr5)
> > +(typeattributeset at01 (tp01))
> > +(typeattributeset at02 (tp01 tp02))
> > +(allow at02 tpr1 (cl01 (p11a p01a p01b)))
> > +(allow at02 tpr3 (cl01 (p11a p01a p01b)))
> > +(allow tp01 at01 (cl01 (p11b)))
> > +(allow tp01 self (cl01 (p11a p01a)))
> > +(allow tp01 tp01 (cl01 (p01b)))
> > +(allow tp01 tpr1 (cl01 (p11a p11b p01a p01b)))
> > +(allow tp02 tpr1 (cl01 (p11a p01a)))
> > +(dontaudit at02 tpr2 (cl01 (p11a p01a p01b)))
> > +(dontaudit at02 tpr4 (cl01 (p11a p01a p01b)))
> > +(dontaudit tp01 tpr2 (cl01 (p11a p11b p01a p01b)))
> > +(dontaudit tp02 tpr2 (cl01 (p11a p01a)))
> > +(booleanif (b01)
> > +    (true
> > +        (allow tp01 tpr3 (cl01 (p11a p11b p01a p01b)))
> > +        (allow tp01 tpr5 (cl01 (p11a p11b p01a p01b)))
> > +        (allow tp02 tpr3 (cl01 (p11a p01a)))
> > +        (allow tp02 tpr5 (cl01 (p11a p01a)))
> > +        (dontaudit tp01 tpr4 (cl01 (p11a p11b p01a p01b)))
> > +        (dontaudit tp02 tpr4 (cl01 (p11a p01a)))
> > +    )
> > +    (false
> > +        (allow at02 tpr5 (cl01 (p11a p01a p01b)))
> > +    )
> > +)
> > +(role object_r)
> > +(role rl01)
> > +(roletype rl01 tp01)
> > +(roletype object_r tp01)
> > +(roletype object_r tp02)
> > +(roletype object_r tp04)
> > +(roletype object_r tpr1)
> > +(roletype object_r tpr2)
> > +(roletype object_r tpr3)
> > +(roletype object_r tpr4)
> > +(roletype object_r tpr5)
> > +(user us01)
> > +(userrole us01 object_r)
> > +(userrole us01 rl01)
> > +(userlevel us01 (s01))
> > +(userrange us01 ((s01) (s01)))
> > +(sidcontext kernel (us01 rl01 tp01 ((s01) (s01))))
> > --
> > 2.24.1
> >
