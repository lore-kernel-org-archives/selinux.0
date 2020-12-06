Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6987C433FE
	for <selinux@archiver.kernel.org>; Sun,  6 Dec 2020 16:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F4D2312E
	for <selinux@archiver.kernel.org>; Sun,  6 Dec 2020 16:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgLFQby (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Dec 2020 11:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgLFQbx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Dec 2020 11:31:53 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35085C0613D1
        for <selinux@vger.kernel.org>; Sun,  6 Dec 2020 08:31:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f190so11485920wme.1
        for <selinux@vger.kernel.org>; Sun, 06 Dec 2020 08:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KybOmhft39OWzeCGqsCVIYAiznSxa7vSi3FRvFCdLms=;
        b=uSQL1cYCHA8pb0IBZ4nw7SBhsbZ8DfEODC6OBBGCwvNIbAYTzBMuH/EWggViySFX49
         gNZVXhG8CiVluVUYrvGvgN5GvoHBa8bgSRmqrZS1yOB5RDxRc6ZXpEBwS1+1EGrF6zHv
         KnQlY4zqKm1HtIv5DgEMkiasOZkU6BklYd1MMbNjN4ieePcw0K5aVahSa8VOkOs9jTKT
         SoR27LBjmGeNpocr8MIV0sscyfYKpxUd39QA5npkW36g3PdG8y068PwGvfaxX0paSIIZ
         dWTryTi2FIuR8nnbDf3MxKvjl7fBpv67EVd6+wUEFos6OknOkovBlKrYqQDh+7u7xRpW
         IY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KybOmhft39OWzeCGqsCVIYAiznSxa7vSi3FRvFCdLms=;
        b=E3ME1T1OWOP/ZRuVTnBS141vRx+jSNZn0M8I22Aga36iwvHs2EGZ+gKNMZRLECyjgH
         xfIvk2lJtkP6lg4aEj7fT/isJnjuLLQ6+IG2A50X1wnGqhR5h4KZo3p21fxqEsemj5Cc
         zb37NDFq9xCXmzVs3yFy/0qMvXHgDAmLHGgcrRvt9olwpW3wShzda4oMlLL3sxGDu5fd
         gNVtOm1NB/BxDCog1lAkNu79kQHtDHbxT8SFdLkSFl3tGoXqwnZeA4Y44+UzA1FfP/9D
         OQekRx91vSGeRJDvv4o0S7ZukDN5TzUvh1praQmbo/uXdfqqfiQhYtByiYjSkqgriBvx
         NJaw==
X-Gm-Message-State: AOAM533tYKil2TkR40/QRRbktzz9i2n9ZUmRrNwW2gmKhOJpM51fPZT+
        OnUtFDw7ioPt+xSvIMmPbbqSlVWtG3YMzPuFv/P5KQ==
X-Google-Smtp-Source: ABdhPJxp87fdGJixtU2VMR/tqkJ7j3sr/UDX+OBFdIedXOKWCOpviyloyGLo4Emtr8iBKe/hoHmHJqbogAFVpE/4gl4=
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr14232893wme.99.1607272270549;
 Sun, 06 Dec 2020 08:31:10 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcjCFYiyMfqa=X__X6g0U0143U5Fd-xGaKJgGNabFUpr7w@mail.gmail.com>
 <858c9383f7c75e1e39bafaeab6388cd6af902c4f.camel@btinternet.com>
In-Reply-To: <858c9383f7c75e1e39bafaeab6388cd6af902c4f.camel@btinternet.com>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Sun, 6 Dec 2020 22:00:59 +0530
Message-ID: <CAP2OjciTWXRsYWw9VtOJGUOGj9B35HMXBHF94O6Qc=csg5=Spw@mail.gmail.com>
Subject: Re: How is policy.31 created from modules under /usr/share/selinux
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux-refpolicy@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Richard ,

Thanks for replying back.

1) The policy.31 binary is not getting  created at:
  /etc/selinux/refpolicy/policy/policy.31

2) Using the verbose of makefile I can see that the semodule command
is reached .
   But even in verbose mode , I can't see any action / command message
   shown for policy.31 being created.
   Hence I am trying to understand how the final policy.31 file is
being created .

3) Below are the files being created under /etc/selinux :
   refpolicy/contexts:
   customizable_types  default_type      initrc_context
removable_context  userhelper_context      virtual_image_context
   dbus_contexts       failsafe_context  lxc_contexts
securetty_types    users                   x_contexts
   default_contexts    files             openrc_contexts
sepgsql_contexts   virtual_domain_context

   refpolicy/policy:

   refpolicy/src:
   policy


4) Below are the files being created under /usr/share/selinux/refpolicy/include/
   admin      apps      build.conf           global_tunables.xml
kernel.xml  roles      services      support  system.xml
   admin.xml  apps.xml  global_booleans.xml  kernel
Makefile    roles.xml  services.xml  system

Any pointer of probable aspect which can cause such error as I am
trying to understand
how policy.31 binary is created from individual modules

Thanks ,
Ashish




On Sun, Dec 6, 2020 at 8:59 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Sun, 2020-12-06 at 00:49 +0530, Ashish Mishra wrote:
> > Hi All  ,
> >
> > Good Morning .
> >
> > I am following the SELINUX NOTEBOOK & trying the same at my end .
> >
> > - The refpolicy modules are copied at /usr/share/selinux/refpolicy
> >    i can see around 400+ modules there .
> >    But can senior member' s please help me understand how is the
> >    /etc/selinux/refpolicy/policy/policy.31  created using the modules
> > available at
> >    /usr/share/selinux
> >    The command i followed :
> >                 $ make install-src
> >                 $ make conf
> >                 $ make load ( tried even $ make install )
> >                 $ make install-headers
> >
>
> Just to be clear (as you didn't state whether the binary policy file
> was built at all), if you run these commands:
>
> mkdir refpol
> cd refpol
> git clone https://github.com/SELinuxProject/refpolicy.git
> Edit build.conf file to requirements (e.g. NAME = refpolicy etc.)
> make install-src
> cd /etc/selinux/refpolicy/src/policy
> make conf
> make load
> make install-headers
>
> The policy binary file should now be created at:
>   /etc/selinux/refpolicy/policy/policy.31 (or .32 if Fedora 33)
> True ??
>
> To add a new module (that will rebuild the binary policy file) you can
> install the new *.te *.if and *.fc files in a directory and run from
> that directory (you will need to ensure /etc/selinux/config has
> SELINUXTYPE=refpolicy set):
>
> make -f /usr/share/selinux/refpolicy/include/Makefile load
>
> This Makefile basically reads the build.conf file, uses checkmodule to
> build the *.pp file, then semodule to add to store and build the binary
> policy (also using the prebuilt /usr/share/selinux/refpolicy/*.pp
> files).
>
> I've just tried this on Fedora 33 with no problems.
>
> Note: While running through example this I noticed an error in the
> Notebook - the Reference policy does not have a contibute section, I'll
> send patch to remove:
>
> Add the contibuted modules (policy/modules/contrib)
> git submodule init
> git submodule update
>
> >
> > - This can help me to debug an issue where i am trying to get selinux
> > of my custom
> >    distro where all the make command are successfully executed but
> > the policy.31
> >    is not getting created
> >
> > - I can even see the "include" folder also getting created for make
> > install-headers
> >
> > Any pointers will be helpful or please let me know if i am missing
> > any
> > aspect here .
> >
> > Thanks ,
> > Ashish.
>
>
