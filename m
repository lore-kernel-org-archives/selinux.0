Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C977C0015E
	for <selinux@archiver.kernel.org>; Fri, 21 Jul 2023 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGUPxM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjGUPw7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jul 2023 11:52:59 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BF035B1
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 08:52:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56fff21c2ebso23099417b3.3
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689954742; x=1690559542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLdyN88FQWhMZ3amGoguxXDBeaogWiisc7Frlw/2Im0=;
        b=N7yEpGmB58AtXfDZyVgeKKzoT9111JQbJKd8jyYP1970YWVMRV+Ga3ahkQT8yGjnVU
         QuzB5b9IVfzrhp01KeqUgkAN7htrPwQ0bKDg4vzCjTHVSjPG/L4XUrlGKaMxcl2DhLIo
         TdEhkRWbNcxZ9ENqFHOOuDA5P27g+mzj8ZEic+HxLvg/vFZRNKTDQ9/XMsrk05C1IVFR
         NgSzJP7a0kwMiVtW+/wr0qxiBOE0YeaZEt0zB/D9lGhDXd2J7Zk6+ZK7EyQ3cSdBV+4A
         HtPAb+hyCdz5B7Y3lnthV/a3og6ASE0ArZuoTEyAIJDL4OLeXxSAo6VBf1so6lt5EqFg
         wCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954742; x=1690559542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLdyN88FQWhMZ3amGoguxXDBeaogWiisc7Frlw/2Im0=;
        b=XZzuKz6WK+I9eB6/uH5XJRI2n9JtYVFrMRePO2NiygFFIRpi0Sh1xxCgYXxWDWaNoz
         Mx8DPX19UuGwMvGTum+3Ow9nwo8vfpnWMbigt8Jd+QUkocLpV+8vnOQEVZhzSsulFbhg
         mfgC+jyOTJTugjouAmY3g8AXrlDJ4P+h9wgH0plAh4LcmCIpMZnZozQFfziN4N49VL5k
         hTlvDAeo+io357W4VBI7zeFBtC2LYIxmzVE/Ve4Wob5sHPx+VRm5aFwg4tdjZU6An6gz
         v9ofEyPaBj38ejuiYB8l7HcX2muhZjDVMnNINhzlmSWEQuJQj5r699vJd53V3pgsqm0v
         eycA==
X-Gm-Message-State: ABy/qLZyybBxKQuBZKGmIrqbzCk/DtZ1cjCXHbDsI9BzhxqJsuHqqeAQ
        5Obs7wFz8iDIvJrloQYEgOqIj7sxUEu41uvTotCXSrAxSe++fKQ=
X-Google-Smtp-Source: APBJJlESF4Iw0omILWr2KPJSz/nFYkpQ9Cwg56N47Vo9moAR0BwRYfo+vXoxNsnpNZRf5DKqNNvhO4HoLb6FP/YLLs8=
X-Received: by 2002:a0d:f847:0:b0:577:2fda:f181 with SMTP id
 i68-20020a0df847000000b005772fdaf181mr416806ywf.44.1689954740749; Fri, 21 Jul
 2023 08:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230720203116.316250-2-paul@paul-moore.com> <242c259961bbcc16752b1ec3165ae1794becb8f8.camel@redhat.com>
In-Reply-To: <242c259961bbcc16752b1ec3165ae1794becb8f8.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Jul 2023 11:52:10 -0400
Message-ID: <CAHC9VhS+4rOJPD2JUnWsk0VMdc+DC+3zXJUWyFkfHHNpvWkvhg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a 0/NULL mistmatch in ad_net_init_from_iif()
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 21, 2023 at 3:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
> On Thu, 2023-07-20 at 16:31 -0400, Paul Moore wrote:
> > Use a NULL instead of a zero to resolve a int/pointer mismatch.
> >
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202307210332.4AqFZfzI-lkp=
@intel.com/
> > Fixes: dd51fcd42fd6 ("selinux: introduce and use lsm_ad_net_init*() hel=
pers")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6f53fa71fbdb..5194f12def97 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -246,7 +246,7 @@ static void ad_net_init_from_iif(struct common_audi=
t_data *ad,
> >                                struct lsm_network_audit *net,
> >                                int ifindex, u16 family)
> >  {
> > -     __ad_net_init(ad, net, ifindex, 0, family);
> > +     __ad_net_init(ad, net, ifindex, NULL, family);
> >  }
> >
> >  /*
>
> Oops, my fault! Thanks for fixing it!
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

I just merged this into selinux/next, thanks.

--=20
paul-moore.com
