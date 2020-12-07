Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE27C1B0D9
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 13:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B8A23436
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 13:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgLGN1q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgLGN1q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 08:27:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6077EC0613D2
        for <selinux@vger.kernel.org>; Mon,  7 Dec 2020 05:27:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k10so11463890wmi.3
        for <selinux@vger.kernel.org>; Mon, 07 Dec 2020 05:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNtIb2HwnB5qX7myOiuKWZvIsd8wGJEPwdi4MF4dwzA=;
        b=VB+93RPQQ3FP4QfqkG8EYoKNlkHz+r0CDCMGT/3F4PzOGMqovGlCs9XV96IBa5qSc8
         8LYWc3Gw1k/xGWwydpGdS4fTbTBy4C9axOg3ruEXH8aZGVZGu1bL8Z6rcGMGYqIixsX2
         vtHStN48F8FExWqHzXZ8u4j2iYp32EX9h284wriWWYpst10aPz5iP933cZqTaPBtnM+u
         Kx9iS+CHPpbE7Ww9iHPOMqu7aqRl5+nA2EyvSqZZEnyntANnq8b/ZkTlV7mX9Mpoklbf
         BUwnuXWp2B+5GPhc6n2/zngkAlLamNJsuLduYIEr5z8US369KG/XOdtdvxTi12Bx+B4j
         Zf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNtIb2HwnB5qX7myOiuKWZvIsd8wGJEPwdi4MF4dwzA=;
        b=EgLCg78ZUVRC+9/SXuJCrHO7tip8dkenuFndpBi3OQLDETwCCaXhk1XZ0ojS2B7PWY
         HyuMee1j1/gFoXZGqjTFm6R8WHAH+5iH0LBrWMPGCLbnX3RVsQXzdspBb6R3dX+539WM
         FRygnwrYeju6kjrISF7NkkutDJdzz0Mg5isTsBhBmB+UGU8/t+9qRStBNKRzu18ho6T0
         OoxVuxa2clSld1tJB380mpf57HzQEXS+oIIUZzb28y5JS4GTkfSjCHETGr1OT5Aty+21
         38dG1oWWZGUPy+D1sfLMsCIZVdthFnhT0vNV2gUNE8gpZfrilNsp/VHLmwqgujn+qTSH
         Rf4Q==
X-Gm-Message-State: AOAM533B93Gos//ill3N7RO9Bc1gD9stkTKWMZviMEyC3OhbIFD+cEGs
        ifPvxcfr77k/UFFLrVSeSCBq3JNUIgeAwFqIfC+ceg==
X-Google-Smtp-Source: ABdhPJy/nIBwjbnqBDHZH7awdh/8+8KLoUuuIgjxoPxegg0EcVCVDzKkKouVYYFCAiSTo1jYpevjwbZaZxYFW9VoBGY=
X-Received: by 2002:a1c:1bcc:: with SMTP id b195mr6291001wmb.131.1607347623947;
 Mon, 07 Dec 2020 05:27:03 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcjCFYiyMfqa=X__X6g0U0143U5Fd-xGaKJgGNabFUpr7w@mail.gmail.com>
 <858c9383f7c75e1e39bafaeab6388cd6af902c4f.camel@btinternet.com>
 <CAP2OjciTWXRsYWw9VtOJGUOGj9B35HMXBHF94O6Qc=csg5=Spw@mail.gmail.com>
 <e82841a8b652f4b4b697ba1e417fdac56f443adb.camel@btinternet.com>
 <CAP2OjchJjMo8zMVvHk-_esu-53E0=367yV8cuZtwQwubi7+q=Q@mail.gmail.com> <0b58a502b5036e8b92b274068fbea53ca915992e.camel@btinternet.com>
In-Reply-To: <0b58a502b5036e8b92b274068fbea53ca915992e.camel@btinternet.com>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Mon, 7 Dec 2020 18:56:52 +0530
Message-ID: <CAP2Ojcg7DgQsEHJP3TZj=Q9NjZjqb3ugw+D2UYC4qmqt-PcZWw@mail.gmail.com>
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

Thanks for sharing the inputs .
Will try the monolithic suggestion & share the observation

- This system doesn't have any selinux policy running .
   So i am adding the refpolicy to sdk rootfs

-  I tried some further debugging & can confirm below discrepancy as
   mentioned in ( point-4 ) below with  PKG=refpolicy &
ROOT=/tmp/custom-embedded-rootfs


1) The task of MAKE INSTALL-SRC  is properly executed at required
     /tmp/custom-embedded-rootfs/etc/selinux/refpolicy/src/policy  properly
        ${MAKE} -C ${PKG} install-src DESTDIR=${ROOT}

2) Does the task of MAKE CONFIG  is properly executed at required
     /tmp/custom-embedded-rootfs/etc/selinux/refpolicy/src/policy  properly
        ${MAKE} -C ${ROOT}/etc/selinux/${PKG}/src/policy conf DESTDIR=${ROOT}

3)  The task till copying *.pp files to
      /tmp/custom-embedded-rootfs/usr/share/selinux/refpolicy/ is proper

 4)  Further debugging I can confirm that the final binary (policy.31)
seems to be
      using HARD-CODDED location of /etc/selinux instead of what is
being passed as DESTDIR.
     The policy.31 is created not at custom-embedded-rootfs location.

      Due to this :
        - policy.31 is created in /etc/selinux/refpolicy/policy/policy.31
          instead of what i was expecting at
/tmp/custom-embedded-rootfs/etc/selinux/refpolicy/policy/policy.31
          as DESTDIR=${ROOT}  and i do get *.pp at the expected
location of /tmp/custom-embedded-rootfs/etc/selinux/refpolicy/src/policy
                 ${MAKE} -C ${ROOT}/etc/selinux/${PKG}/src/policy load
DESTDIR=${ROOT}


Will try the pointers you suggested .
Please do let me know if any input / suggestion / feedback on (
point-4 ) above.
Apologies if i am missing any obvious / well-known aspect of selinux
refolicy project here.

Thanks ,
Ashish











<richard_c_haines@btinternet.com> wrote:
>
> On Mon, 2020-12-07 at 06:51 +0530, Ashish Mishra wrote:
> > Hi Richard ,
> >
> > 1) There are approx 426 *.pp files being created under
> > /usr/share/selinux/refpolicy
> >     Attached is the log , which contains the list of files .
> >
> > 2) I can confirm the stages till semodule
> >
> > 3) This is a custom Linux SDK 4.x series BSP on which i am trying to
> > get the refpolicy
> >      installed .
> >
> > 4) Any pointers to verify if make load is happening as expected or
> > https://github.com/SELinuxProject/selinux installation
> >     Because i am not observing any error here during make -v .
> >
> > I am trying to look at the probable cause / pointers to debug the
> > missing policy.31 file here.
> > Any inputs will be helpful .
>
> Have you tried building a monolithic policy as this does not use
> semodule (uses checkpolicy). Just change the build.conf 'MONOLITHIC =
> y'
> Building this on a clean system does not build/install the
> /usr/share/selinux/refpolicy modules so quite simple build.
> You could also set 'OUTPUT_POLICY = <ver>' to build a lower version
> binary policy (e.g. 21).
>
> Otherwise (running out of ideas):
> 1) Is this already a working SELinux system (e.g. do you have the
> 'targeted' or 'mls' policy installed)
> 2) When 'make load' gets to semodule, what errors do you see.
> 3) When semodule builds it installs a policy store (default) at
> /var/lib/selinux/refpolicy. Do you have this when you build a modular
> policy ?
>
>
> >
> > Thanks .
> > Ashish
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > On Sun, Dec 6, 2020 at 10:45 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > >
> > > On Sun, 2020-12-06 at 22:00 +0530, Ashish Mishra wrote:
> > > > Hi Richard ,
> > > >
> > > > Thanks for replying back.
> > > >
> > > > 1) The policy.31 binary is not getting  created at:
> > > >   /etc/selinux/refpolicy/policy/policy.31
> > > >
> > > > 2) Using the verbose of makefile I can see that the semodule
> > > > command
> > > > is reached .
> > > >    But even in verbose mode , I can't see any action / command
> > > > message
> > > >    shown for policy.31 being created.
> > > >    Hence I am trying to understand how the final policy.31 file
> > > > is
> > > > being created .
> > >
> > > You will not see a reference to 'policy.31' when running semodule.
> > > It
> > > just takes the large list of modules and its store id, the rest is
> > > magic (the default name is 'policy', the version is derived from
> > > the
> > > policy-version= entry in the semanage.conf file or the kernel
> > > default).
> > > It then adds the policy binary file to:
> > >
> > > /etc/selinux/<SELINUXTYPE>/policy/policy.<ver>
> > >
> > > Where <SELINUXTYPE> is the policy store id that should match the
> > > /etc/selinux/config SELINUXTYPE= entry when loading the policy.
> > >
> > > For example when I run 'make -d load' I see (cutdown):
> > >
> > > Loading configured modules.
> > > /usr/sbin/semodule -s refpolicy -i
> > > /usr/share/selinux/refpolicy/base.pp
> > > -i /usr/share/selinux/refpolicy/abrt.pp ......
> > >
> > > BTW what distro/version are you using as I use Fedora 33 that by
> > > default generates an '/etc/selinux/refpolicy/policy/policy.32'
> > > binary
> > > file.
> > >
> > > >
> > > > 3) Below are the files being created under /etc/selinux :
> > > >    refpolicy/contexts:
> > > >    customizable_types  default_type      initrc_context
> > > > removable_context  userhelper_context      virtual_image_context
> > > >    dbus_contexts       failsafe_context  lxc_contexts
> > > > securetty_types    users                   x_contexts
> > > >    default_contexts    files             openrc_contexts
> > > > sepgsql_contexts   virtual_domain_context
> > > >
> > > >    refpolicy/policy:
> > > My initial thought is that 'make load' is not being called or
> > > something
> > > is wrong with
> > > 'https://github.com/SELinuxProject/selinux' installation
> > >
> > > >
> > > >    refpolicy/src:
> > > >    policy
> > > >
> > > >
> > > > 4) Below are the files being created under
> > >
> > > Are there any *.pp files under:
> > > /usr/share/selinux/refpolicy
> > >
> > > If not again looks like 'https://github.com/SELinuxProject/selinux'
> > > installation problem checkpolicy/checkmodule ??
> > >
> > > > /usr/share/selinux/refpolicy/include/
> > > >    admin      apps      build.conf           global_tunables.xml
> > > > kernel.xml  roles      services      support  system.xml
> > > >    admin.xml  apps.xml  global_booleans.xml  kernel
> > > > Makefile    roles.xml  services.xml  system
> > > >
> > > > Any pointer of probable aspect which can cause such error as I am
> > > > trying to understand
> > > > how policy.31 binary is created from individual modules
> > > >
> > > > Thanks ,
> > > > Ashish
> > > >
> > > >
> > > >
> > > >
> > > > On Sun, Dec 6, 2020 at 8:59 PM Richard Haines
> > > > <richard_c_haines@btinternet.com> wrote:
> > > > >
> > > > > On Sun, 2020-12-06 at 00:49 +0530, Ashish Mishra wrote:
> > > > > > Hi All  ,
> > > > > >
> > > > > > Good Morning .
> > > > > >
> > > > > > I am following the SELINUX NOTEBOOK & trying the same at my
> > > > > > end .
> > > > > >
> > > > > > - The refpolicy modules are copied at
> > > > > > /usr/share/selinux/refpolicy
> > > > > >    i can see around 400+ modules there .
> > > > > >    But can senior member' s please help me understand how is
> > > > > > the
> > > > > >    /etc/selinux/refpolicy/policy/policy.31  created using the
> > > > > > modules
> > > > > > available at
> > > > > >    /usr/share/selinux
> > > > > >    The command i followed :
> > > > > >                 $ make install-src
> > > > > >                 $ make conf
> > > > > >                 $ make load ( tried even $ make install )
> > > > > >                 $ make install-headers
> > > > > >
> > > > >
> > > > > Just to be clear (as you didn't state whether the binary policy
> > > > > file
> > > > > was built at all), if you run these commands:
> > > > >
> > > > > mkdir refpol
> > > > > cd refpol
> > > > > git clone https://github.com/SELinuxProject/refpolicy.git
> > > > > Edit build.conf file to requirements (e.g. NAME = refpolicy
> > > > > etc.)
> > > > > make install-src
> > > > > cd /etc/selinux/refpolicy/src/policy
> > > > > make conf
> > > > > make load
> > > > > make install-headers
> > > > >
> > > > > The policy binary file should now be created at:
> > > > >   /etc/selinux/refpolicy/policy/policy.31 (or .32 if Fedora 33)
> > > > > True ??
> > > > >
> > > > > To add a new module (that will rebuild the binary policy file)
> > > > > you
> > > > > can
> > > > > install the new *.te *.if and *.fc files in a directory and run
> > > > > from
> > > > > that directory (you will need to ensure /etc/selinux/config has
> > > > > SELINUXTYPE=refpolicy set):
> > > > >
> > > > > make -f /usr/share/selinux/refpolicy/include/Makefile load
> > > > >
> > > > > This Makefile basically reads the build.conf file, uses
> > > > > checkmodule
> > > > > to
> > > > > build the *.pp file, then semodule to add to store and build
> > > > > the
> > > > > binary
> > > > > policy (also using the prebuilt
> > > > > /usr/share/selinux/refpolicy/*.pp
> > > > > files).
> > > > >
> > > > > I've just tried this on Fedora 33 with no problems.
> > > > >
> > > > > Note: While running through example this I noticed an error in
> > > > > the
> > > > > Notebook - the Reference policy does not have a contibute
> > > > > section,
> > > > > I'll
> > > > > send patch to remove:
> > > > >
> > > > > Add the contibuted modules (policy/modules/contrib)
> > > > > git submodule init
> > > > > git submodule update
> > > > >
> > > > > >
> > > > > > - This can help me to debug an issue where i am trying to get
> > > > > > selinux
> > > > > > of my custom
> > > > > >    distro where all the make command are successfully
> > > > > > executed
> > > > > > but
> > > > > > the policy.31
> > > > > >    is not getting created
> > > > > >
> > > > > > - I can even see the "include" folder also getting created
> > > > > > for
> > > > > > make
> > > > > > install-headers
> > > > > >
> > > > > > Any pointers will be helpful or please let me know if i am
> > > > > > missing
> > > > > > any
> > > > > > aspect here .
> > > > > >
> > > > > > Thanks ,
> > > > > > Ashish.
> > > > >
> > > > >
> > >
> > >
>
>
