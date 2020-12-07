Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78714C433FE
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 01:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D4B22CF6
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 01:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgLGBWR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Dec 2020 20:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbgLGBWR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Dec 2020 20:22:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05DAC0613D1
        for <selinux@vger.kernel.org>; Sun,  6 Dec 2020 17:21:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z7so11173611wrn.3
        for <selinux@vger.kernel.org>; Sun, 06 Dec 2020 17:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BgAF/v3dXay0x/HwbK/fUdSbkzZe1qvK2qeaNdgdEs=;
        b=oM8IV3cK9fRV5ZKRTT3PExwFs/qZgBKPkltDDf8IhNElg0sfFOTwbO/kB6I5w4SHUN
         mtNHV4snddaAFBkwwK4q4X6dS3HlhzqJAy4hom/2CbuUDUAGXXv8SUjgzA9J9BkkOn4d
         YFs2gmi7IkpGzv8YCbdQENUUNcd7YS9h3JRcAgCge/dx/LQWakLNdhNwAQOqolRvMipO
         PsxiJII4l1+KYKEJun9A/gKM8YIcNr6uq3eXmIZ4ZtKTdJrHcdln6QE3r8h44aab/nbW
         x2e/TsR7QrtuFreaFdXuavC+sNz8Xw3fk9jzOFC+LLVZWgR7FR5Sf7axZUzuzFcdTPCW
         ckuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BgAF/v3dXay0x/HwbK/fUdSbkzZe1qvK2qeaNdgdEs=;
        b=VGxa3Vul7tyaD7UQPg7c3GmrfkcNCWk2Yo270V+IRE1Ot9EhvWndzBIDbxBkfMaXfE
         FK80SpIbwhcY4IqYD4EZFP40jTvMOUOmlVOhRPEziv4axQ3XwrO2y5LG9Xjx++q4gIng
         XZ1ptY23hQtvm/eubZj5Gsr40/YFvngGyMoHhndKKnod1FqZSEkkuv5j7WMykYAZ2w3K
         brPvENNU7O9ftbAxnhYsKIyX6d5xtq0VaxffjlykKMLg4KZg9rjLSJbAk9qxWeQgD6sY
         MfmAI/HYl0AjgGU5Xg/oweDgHVMiMDNXSrp6lYcMYaQhNL4ZjoYMuZk6r5tdnVi7UQKo
         DoYA==
X-Gm-Message-State: AOAM530yDpxzkfth8e2g/t99AJQnfezFEJ/WRZmKs4iZGB/2KXnGOTGZ
        m/LIM+0+XHd972NvLUgjWzcxeWtsdqcUEvxihHqMvA==
X-Google-Smtp-Source: ABdhPJysEgUyPl/PWezHHiw+dwCSttCv8aRrwvZ4zOj3yunsIdGVaGJa9//kc9XaAcfDJouLUN61MJ386HU4MVFsmUA=
X-Received: by 2002:adf:df08:: with SMTP id y8mr454890wrl.278.1607304093038;
 Sun, 06 Dec 2020 17:21:33 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcjCFYiyMfqa=X__X6g0U0143U5Fd-xGaKJgGNabFUpr7w@mail.gmail.com>
 <858c9383f7c75e1e39bafaeab6388cd6af902c4f.camel@btinternet.com>
 <CAP2OjciTWXRsYWw9VtOJGUOGj9B35HMXBHF94O6Qc=csg5=Spw@mail.gmail.com> <e82841a8b652f4b4b697ba1e417fdac56f443adb.camel@btinternet.com>
In-Reply-To: <e82841a8b652f4b4b697ba1e417fdac56f443adb.camel@btinternet.com>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Mon, 7 Dec 2020 06:51:21 +0530
Message-ID: <CAP2OjchJjMo8zMVvHk-_esu-53E0=367yV8cuZtwQwubi7+q=Q@mail.gmail.com>
Subject: Re: How is policy.31 created from modules under /usr/share/selinux
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux-refpolicy@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000083246c05b5d5a590"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--00000000000083246c05b5d5a590
Content-Type: text/plain; charset="UTF-8"

Hi Richard ,

1) There are approx 426 *.pp files being created under
/usr/share/selinux/refpolicy
    Attached is the log , which contains the list of files .

2) I can confirm the stages till semodule

3) This is a custom Linux SDK 4.x series BSP on which i am trying to
get the refpolicy
     installed .

4) Any pointers to verify if make load is happening as expected or
https://github.com/SELinuxProject/selinux installation
    Because i am not observing any error here during make -v .

I am trying to look at the probable cause / pointers to debug the
missing policy.31 file here.
Any inputs will be helpful .

Thanks .
Ashish











On Sun, Dec 6, 2020 at 10:45 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Sun, 2020-12-06 at 22:00 +0530, Ashish Mishra wrote:
> > Hi Richard ,
> >
> > Thanks for replying back.
> >
> > 1) The policy.31 binary is not getting  created at:
> >   /etc/selinux/refpolicy/policy/policy.31
> >
> > 2) Using the verbose of makefile I can see that the semodule command
> > is reached .
> >    But even in verbose mode , I can't see any action / command
> > message
> >    shown for policy.31 being created.
> >    Hence I am trying to understand how the final policy.31 file is
> > being created .
>
> You will not see a reference to 'policy.31' when running semodule. It
> just takes the large list of modules and its store id, the rest is
> magic (the default name is 'policy', the version is derived from the
> policy-version= entry in the semanage.conf file or the kernel default).
> It then adds the policy binary file to:
>
> /etc/selinux/<SELINUXTYPE>/policy/policy.<ver>
>
> Where <SELINUXTYPE> is the policy store id that should match the
> /etc/selinux/config SELINUXTYPE= entry when loading the policy.
>
> For example when I run 'make -d load' I see (cutdown):
>
> Loading configured modules.
> /usr/sbin/semodule -s refpolicy -i /usr/share/selinux/refpolicy/base.pp
> -i /usr/share/selinux/refpolicy/abrt.pp ......
>
> BTW what distro/version are you using as I use Fedora 33 that by
> default generates an '/etc/selinux/refpolicy/policy/policy.32' binary
> file.
>
> >
> > 3) Below are the files being created under /etc/selinux :
> >    refpolicy/contexts:
> >    customizable_types  default_type      initrc_context
> > removable_context  userhelper_context      virtual_image_context
> >    dbus_contexts       failsafe_context  lxc_contexts
> > securetty_types    users                   x_contexts
> >    default_contexts    files             openrc_contexts
> > sepgsql_contexts   virtual_domain_context
> >
> >    refpolicy/policy:
> My initial thought is that 'make load' is not being called or something
> is wrong with 'https://github.com/SELinuxProject/selinux' installation
>
> >
> >    refpolicy/src:
> >    policy
> >
> >
> > 4) Below are the files being created under
>
> Are there any *.pp files under:
> /usr/share/selinux/refpolicy
>
> If not again looks like 'https://github.com/SELinuxProject/selinux'
> installation problem checkpolicy/checkmodule ??
>
> > /usr/share/selinux/refpolicy/include/
> >    admin      apps      build.conf           global_tunables.xml
> > kernel.xml  roles      services      support  system.xml
> >    admin.xml  apps.xml  global_booleans.xml  kernel
> > Makefile    roles.xml  services.xml  system
> >
> > Any pointer of probable aspect which can cause such error as I am
> > trying to understand
> > how policy.31 binary is created from individual modules
> >
> > Thanks ,
> > Ashish
> >
> >
> >
> >
> > On Sun, Dec 6, 2020 at 8:59 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > >
> > > On Sun, 2020-12-06 at 00:49 +0530, Ashish Mishra wrote:
> > > > Hi All  ,
> > > >
> > > > Good Morning .
> > > >
> > > > I am following the SELINUX NOTEBOOK & trying the same at my end .
> > > >
> > > > - The refpolicy modules are copied at
> > > > /usr/share/selinux/refpolicy
> > > >    i can see around 400+ modules there .
> > > >    But can senior member' s please help me understand how is the
> > > >    /etc/selinux/refpolicy/policy/policy.31  created using the
> > > > modules
> > > > available at
> > > >    /usr/share/selinux
> > > >    The command i followed :
> > > >                 $ make install-src
> > > >                 $ make conf
> > > >                 $ make load ( tried even $ make install )
> > > >                 $ make install-headers
> > > >
> > >
> > > Just to be clear (as you didn't state whether the binary policy
> > > file
> > > was built at all), if you run these commands:
> > >
> > > mkdir refpol
> > > cd refpol
> > > git clone https://github.com/SELinuxProject/refpolicy.git
> > > Edit build.conf file to requirements (e.g. NAME = refpolicy etc.)
> > > make install-src
> > > cd /etc/selinux/refpolicy/src/policy
> > > make conf
> > > make load
> > > make install-headers
> > >
> > > The policy binary file should now be created at:
> > >   /etc/selinux/refpolicy/policy/policy.31 (or .32 if Fedora 33)
> > > True ??
> > >
> > > To add a new module (that will rebuild the binary policy file) you
> > > can
> > > install the new *.te *.if and *.fc files in a directory and run
> > > from
> > > that directory (you will need to ensure /etc/selinux/config has
> > > SELINUXTYPE=refpolicy set):
> > >
> > > make -f /usr/share/selinux/refpolicy/include/Makefile load
> > >
> > > This Makefile basically reads the build.conf file, uses checkmodule
> > > to
> > > build the *.pp file, then semodule to add to store and build the
> > > binary
> > > policy (also using the prebuilt /usr/share/selinux/refpolicy/*.pp
> > > files).
> > >
> > > I've just tried this on Fedora 33 with no problems.
> > >
> > > Note: While running through example this I noticed an error in the
> > > Notebook - the Reference policy does not have a contibute section,
> > > I'll
> > > send patch to remove:
> > >
> > > Add the contibuted modules (policy/modules/contrib)
> > > git submodule init
> > > git submodule update
> > >
> > > >
> > > > - This can help me to debug an issue where i am trying to get
> > > > selinux
> > > > of my custom
> > > >    distro where all the make command are successfully executed
> > > > but
> > > > the policy.31
> > > >    is not getting created
> > > >
> > > > - I can even see the "include" folder also getting created for
> > > > make
> > > > install-headers
> > > >
> > > > Any pointers will be helpful or please let me know if i am
> > > > missing
> > > > any
> > > > aspect here .
> > > >
> > > > Thanks ,
> > > > Ashish.
> > >
> > >
>
>

--00000000000083246c05b5d5a590
Content-Type: text/plain; charset="US-ASCII"; name="usr-share-selinux-refpolicy.txt"
Content-Disposition: attachment; filename="usr-share-selinux-refpolicy.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kidvcb2p0>
X-Attachment-Id: f_kidvcb2p0

L3RtcC9faG9tZV9vY3Rlb25fbGludXhfZW1iZWRkZWRfcm9vdGZzLXJvb3Rmcy91c3Ivc2hhcmUv
c2VsaW51eC9yZWZwb2xpY3k6KCkgOjogbHMKYWJydC5wcCAgICAgICAgIGNsYW1hdi5wcCAgICAg
ICAgICAgZmFrZWh3Y2xvY2sucHAgIGpvY2tleS5wcCAgICAgICAgbXJ0Zy5wcCAgICAgICAgICAg
IHByb2NtYWlsLnBwICAgICBzZW5zb3JkLnBwICAgICAgICAgdHpkYXRhLnBwCmFjY291bnRzZC5w
cCAgICBjbG9jay5wcCAgICAgICAgICAgIGZjb2UucHAgICAgICAgICBrZHVtcGd1aS5wcCAgICAg
IG10YS5wcCAgICAgICAgICAgICBwc2FkLnBwICAgICAgICAgc2V0cmFucy5wcCAgICAgICAgIHVj
c3BpdGNwLnBwCmFjY3QucHAgICAgICAgICBjbG9ja3NwZWVkLnBwICAgICAgIGZldGNobWFpbC5w
cCAgICBrZHVtcC5wcCAgICAgICAgIG11bmluLnBwICAgICAgICAgICBwdGNob3duLnBwICAgICAg
c2V0cm91Ymxlc2hvb3QucHAgIHVkZXYucHAKYWNwaS5wcCAgICAgICAgIGNsb2dkLnBwICAgICAg
ICAgICAgZmluZ2VyLnBwICAgICAgIGtlcmJlcm9zLnBwICAgICAgbXlzcWwucHAgICAgICAgICAg
IHB1YmxpY2ZpbGUucHAgICBzZXVuc2hhcmUucHAgICAgICAgdWxvZ2QucHAKYWZzLnBwICAgICAg
ICAgIGNtaXJyb3JkLnBwICAgICAgICAgZmlyZXdhbGxkLnBwICAgIGtlcm5lbG9vcHMucHAgICAg
bmFnaW9zLnBwICAgICAgICAgIHB1bHNlYXVkaW8ucHAgICBzaGliYm9sZXRoLnBwICAgICAgdW1s
LnBwCmFpY2N1LnBwICAgICAgICBjb2JibGVyLnBwICAgICAgICAgIGZpcmV3YWxsZ3VpLnBwICBr
ZXlib2FyZGQucHAgICAgIG5jZnRvb2wucHAgICAgICAgICBwdXBwZXQucHAgICAgICAgc2hvcmV3
YWxsLnBwICAgICAgIHVuY29uZmluZWQucHAKYWlkZS5wcCAgICAgICAgIGNvbGxlY3RkLnBwICAg
ICAgICAgZmlyc3Rib290LnBwICAgIGtleXN0b25lLnBwICAgICAgbmVzc3VzLnBwICAgICAgICAg
IHB3YXV0aC5wcCAgICAgICBzaHV0ZG93bi5wcCAgICAgICAgdW5wcml2dXNlci5wcAphaXNleGVj
LnBwICAgICAgY29sb3JkLnBwICAgICAgICAgICBmcHJpbnRkLnBwICAgICAga2lzbWV0LnBwICAg
ICAgICBuZXRsYWJlbC5wcCAgICAgICAgcHhlLnBwICAgICAgICAgIHNpZ3Jvay5wcCAgICAgICAg
ICB1cGRmc3RhYi5wcAphbHNhLnBwICAgICAgICAgY29tc2F0LnBwICAgICAgICAgICBmc3Rvb2xz
LnBwICAgICAga25vdC5wcCAgICAgICAgICBuZXR1dGlscy5wcCAgICAgICAgcHlpY3F0LnBwICAg
ICAgIHNsb2NhdGUucHAgICAgICAgICB1cHRpbWUucHAKYW1hbmRhLnBwICAgICAgIGNvbmRvci5w
cCAgICAgICAgICAgZnRwLnBwICAgICAgICAgIGtzbXR1bmVkLnBwICAgICAgbmV0d29ya21hbmFn
ZXIucHAgIHB5em9yLnBwICAgICAgICBzbHBkLnBwICAgICAgICAgICAgdXNiZ3VhcmQucHAKYW1h
dmlzLnBwICAgICAgIGNvbnNvbGVraXQucHAgICAgICAgZ2FtZXMucHAgICAgICAgIGt0YWxrLnBw
ICAgICAgICAgbmlzLnBwICAgICAgICAgICAgIHFlbXUucHAgICAgICAgICBzbHJucHVsbC5wcCAg
ICAgICAgdXNibW9kdWxlcy5wcAphbXR1LnBwICAgICAgICAgY29uc29sZXNldHVwLnBwICAgICBn
YXRla2VlcGVyLnBwICAga3VkenUucHAgICAgICAgICBuc2NkLnBwICAgICAgICAgICAgcW1haWwu
cHAgICAgICAgIHNtYXJ0bW9uLnBwICAgICAgICB1c2JtdXhkLnBwCmFuYWNvbmRhLnBwICAgICBj
b25zb2xldHlwZS5wcCAgICAgIGdkb21hcC5wcCAgICAgICBsMnRwLnBwICAgICAgICAgIG5zZC5w
cCAgICAgICAgICAgICBxcGlkLnBwICAgICAgICAgc21va2VwaW5nLnBwICAgICAgIHVzZXJkb21h
aW4ucHAKYXBhY2hlLnBwICAgICAgIGNvcm9zeW5jLnBwICAgICAgICAgZ2VvY2x1ZS5wcCAgICAg
IGxkYXAucHAgICAgICAgICAgbnNsY2QucHAgICAgICAgICAgIHF1YW50dW0ucHAgICAgICBzbW9s
dGNsaWVudC5wcCAgICAgdXNlcmhlbHBlci5wcAphcGN1cHNkLnBwICAgICAgY291Y2hkYi5wcCAg
ICAgICAgICBnZXR0eS5wcCAgICAgICAgbGlibXRwLnBwICAgICAgICBudG9wLnBwICAgICAgICAg
ICAgcXVvdGEucHAgICAgICAgIHNtc3Rvb2xzLnBwICAgICAgICB1c2VybWFuYWdlLnBwCmFwcGxp
Y2F0aW9uLnBwICBjb3VyaWVyLnBwICAgICAgICAgIGdpZnQucHAgICAgICAgICBsaWJyYXJpZXMu
cHAgICAgIG50cC5wcCAgICAgICAgICAgICByYWJiaXRtcS5wcCAgICAgc25tcC5wcCAgICAgICAg
ICAgIHVzZXJuZXRjdGwucHAKYXB0Y2FjaGVyLnBwICAgIGNwdWNvbnRyb2wucHAgICAgICAgZ2l0
b3Npcy5wcCAgICAgIGxpZ2h0c3F1aWQucHAgICAgbnVtYWQucHAgICAgICAgICAgIHJhZGl1cy5w
cCAgICAgICBzbm9ydC5wcCAgICAgICAgICAgdXVjcC5wcAphcHQucHAgICAgICAgICAgY3B1ZnJl
cXNlbGVjdG9yLnBwICBnaXQucHAgICAgICAgICAgbGlrZXdpc2UucHAgICAgICBudXQucHAgICAg
ICAgICAgICAgcmFkdmQucHAgICAgICAgIHNvc3JlcG9ydC5wcCAgICAgICB1dWlkZC5wcAphcnB3
YXRjaC5wcCAgICAgY3Jvbi5wcCAgICAgICAgICAgICBnbGFuY2UucHAgICAgICAgbGlyY2QucHAg
ICAgICAgICBueC5wcCAgICAgICAgICAgICAgcmFpZC5wcCAgICAgICAgIHNvdW5kc2VydmVyLnBw
ICAgICB1d2ltYXAucHAKYXN0ZXJpc2sucHAgICAgIGNyeWZzLnBwICAgICAgICAgICAgZ2x1c3Rl
cmZzLnBwICAgIGxpdmVjZC5wcCAgICAgICAgb2F2LnBwICAgICAgICAgICAgIHJhem9yLnBwICAg
ICAgICBzcGFtYXNzYXNzaW4ucHAgICAgdmFybmlzaGQucHAKYXVkaXRhZG0ucHAgICAgIGN0ZGIu
cHAgICAgICAgICAgICAgZ25vbWVjbG9jay5wcCAgIGxsZHBhZC5wcCAgICAgICAgb2JleC5wcCAg
ICAgICAgICAgIHJkaXNjLnBwICAgICAgICBzcGVlZHRvdWNoLnBwICAgICAgdmJldG9vbC5wcAph
dXRobG9naW4ucHAgICAgY3Vwcy5wcCAgICAgICAgICAgICBnbm9tZS5wcCAgICAgICAgbG9hZGtl
eXMucHAgICAgICBvZGRqb2IucHAgICAgICAgICAgcmVhZGFoZWFkLnBwICAgIHNxdWlkLnBwICAg
ICAgICAgICB2ZGFnZW50LnBwCmF1dG9tb3VudC5wcCAgICBjdnMucHAgICAgICAgICAgICAgIGdw
Zy5wcCAgICAgICAgICBsb2NhbGxvZ2luLnBwICAgIG9pZGVudC5wcCAgICAgICAgICByZWFsbWQu
cHAgICAgICAgc3NoLnBwICAgICAgICAgICAgIHZob3N0bWQucHAKYXZhaGkucHAgICAgICAgIGN5
cGhlc2lzLnBwICAgICAgICAgZ3BtLnBwICAgICAgICAgIGxvY2tkZXYucHAgICAgICAgb3BlbmNh
LnBwICAgICAgICAgIHJlZGlzLnBwICAgICAgICBzc3NkLnBwICAgICAgICAgICAgdmlydC5wcAph
d3N0YXRzLnBwICAgICAgY3lydXMucHAgICAgICAgICAgICBncHNkLnBwICAgICAgICAgbG9nYWRt
LnBwICAgICAgICBvcGVuY3QucHAgICAgICAgICAgcmVtb3RlbG9naW4ucHAgIHN0YWZmLnBwICAg
ICAgICAgICB2bG9jay5wcApiYWNrdXAucHAgICAgICAgZGFlbW9udG9vbHMucHAgICAgICBnc3Nw
cm94eS5wcCAgICAgbG9nZ2luZy5wcCAgICAgICBvcGVuaHBpLnBwICAgICAgICAgcmVzbWdyLnBw
ICAgICAgIHN0b3JhZ2UucHAgICAgICAgICB2bXdhcmUucHAKYmFjdWxhLnBwICAgICAgIGRhbnRl
LnBwICAgICAgICAgICAgZ3Vlc3QucHAgICAgICAgIGxvZ3JvdGF0ZS5wcCAgICAgb3Blbm9mZmlj
ZS5wcCAgICAgIHJnbWFuYWdlci5wcCAgICBzdHViYnkucHAgICAgICAgICAgdm5zdGF0ZC5wcApi
YXNlLnBwICAgICAgICAgZGJhZG0ucHAgICAgICAgICAgICBoYWRvb3AucHAgICAgICAgbG9nd2F0
Y2gucHAgICAgICBvcGVudnBuLnBwICAgICAgICAgcmhjcy5wcCAgICAgICAgIHN0dW5uZWwucHAg
ICAgICAgICB2cG4ucHAKYmNmZzIucHAgICAgICAgIGRic2trLnBwICAgICAgICAgICAgaGFsLnBw
ICAgICAgICAgIGxwZC5wcCAgICAgICAgICAgb3BlbnZzd2l0Y2gucHAgICAgIHJoZ2IucHAgICAg
ICAgICBzdWRvLnBwICAgICAgICAgICAgdzNjLnBwCmJpbmQucHAgICAgICAgICBkYnVzLnBwICAg
ICAgICAgICAgIGhkZHRlbXAucHAgICAgICBsc20ucHAgICAgICAgICAgIHBhY2VtYWtlci5wcCAg
ICAgICByaHNtY2VydGQucHAgICAgc3UucHAgICAgICAgICAgICAgIHdhdGNoZG9nLnBwCmJpcmQu
cHAgICAgICAgICBkY2MucHAgICAgICAgICAgICAgIGhvc3RhcGQucHAgICAgICBsdm0ucHAgICAg
ICAgICAgIHBhZHMucHAgICAgICAgICAgICByaWNjaS5wcCAgICAgICAgc3Zuc2VydmUucHAgICAg
ICAgIHdkbWQucHAKYml0bGJlZS5wcCAgICAgIGRkY2xpZW50LnBwICAgICAgICAgaG9zdG5hbWUu
cHAgICAgIG1haWxtYW4ucHAgICAgICAgcGFzc2VuZ2VyLnBwICAgICAgIHJraHVudGVyLnBwICAg
ICBzeGlkLnBwICAgICAgICAgICAgd2ViYWRtLnBwCmJsdWVtYW4ucHAgICAgICBkZGNwcm9iZS5w
cCAgICAgICAgIGhvdHBsdWcucHAgICAgICBtYWlsc2Nhbm5lci5wcCAgIHBjbWNpYS5wcCAgICAg
ICAgICBybG9naW4ucHAgICAgICAgc3luY3RoaW5nLnBwICAgICAgIHdlYmFsaXplci5wcApibHVl
dG9vdGgucHAgICAgZGVueWhvc3RzLnBwICAgICAgICBob3dsLnBwICAgICAgICAgbWFuMmh0bWwu
cHAgICAgICBwY3NjZC5wcCAgICAgICAgICAgcm5nZC5wcCAgICAgICAgIHN5c2FkbS5wcCAgICAg
ICAgICB3aW5lLnBwCmJvaW5jLnBwICAgICAgICBkZXZpY2VraXQucHAgICAgICAgIGh3bG9jLnBw
ICAgICAgICBtYW5kYi5wcCAgICAgICAgIHBlZ2FzdXMucHAgICAgICAgICByb3VuZHVwLnBwICAg
ICAgc3lzbmV0d29yay5wcCAgICAgIHdpcmVndWFyZC5wcApib290bG9hZGVyLnBwICAgZGhjcC5w
cCAgICAgICAgICAgICBoeXBlcnZrdnAucHAgICAgbWNlbG9nLnBwICAgICAgICBwZXJkaXRpb24u
cHAgICAgICAgcnBjYmluZC5wcCAgICAgIHN5c3N0YXQucHAgICAgICAgICB3aXJlc2hhcmsucHAK
YnJjdGwucHAgICAgICAgIGRpY3RkLnBwICAgICAgICAgICAgaTE4bl9pbnB1dC5wcCAgIG1lZGlh
d2lraS5wcCAgICAgcGluZ2QucHAgICAgICAgICAgIHJwYy5wcCAgICAgICAgICBzeXN0ZW1kLnBw
ICAgICAgICAgd20ucHAKYnVnemlsbGEucHAgICAgIGRpcm1uZ3IucHAgICAgICAgICAgaWNlY2Fz
dC5wcCAgICAgIG1lbWNhY2hlZC5wcCAgICAgcGtjcy5wcCAgICAgICAgICAgIHJwbS5wcCAgICAg
ICAgICBzeXN0ZW10YXAucHAgICAgICAgeGRnLnBwCmNhY2hlZmlsZXNkLnBwICBkaXN0Y2MucHAg
ICAgICAgICAgIGlmcGx1Z2QucHAgICAgICBtaWx0ZXIucHAgICAgICAgIHBseW1vdXRoZC5wcCAg
ICAgICByc2hkLnBwICAgICAgICAgdGJvb3QucHAgICAgICAgICAgIHhlbi5wcApjYWxhbWFyaXMu
cHAgICAgZGpiZG5zLnBwICAgICAgICAgICBpbWF6ZS5wcCAgICAgICAgbWluaWRsbmEucHAgICAg
ICBwb2RzbGV1dGgucHAgICAgICAgcnNzaC5wcCAgICAgICAgIHRjcGQucHAgICAgICAgICAgICB4
ZnMucHAKY2FsbHdlYXZlci5wcCAgIGRraW0ucHAgICAgICAgICAgICAgaW5jbHVkZSAgICAgICAg
IG1pbmlzc2RwZC5wcCAgICAgcG9saWN5a2l0LnBwICAgICAgIHJzeW5jLnBwICAgICAgICB0Y3Nk
LnBwICAgICAgICAgICAgeGd1ZXN0LnBwCmNhbm5hLnBwICAgICAgICBkbWVzZy5wcCAgICAgICAg
ICAgIGluZXRkLnBwICAgICAgICBtaXNjZmlsZXMucHAgICAgIHBvbGlwby5wcCAgICAgICAgICBy
dGtpdC5wcCAgICAgICAgdGVsZXBhdGh5LnBwICAgICAgIHhwcmludC5wcApjY3MucHAgICAgICAg
ICAgZG1pZGVjb2RlLnBwICAgICAgICBpbml0LnBwICAgICAgICAgbW9kZW1tYW5hZ2VyLnBwICBw
b3J0YWdlLnBwICAgICAgICAgcndoby5wcCAgICAgICAgIHRlbG5ldC5wcCAgICAgICAgICB4c2Ny
ZWVuc2F2ZXIucHAKY2RyZWNvcmQucHAgICAgIGRuc21hc3EucHAgICAgICAgICAgaW5uLnBwICAg
ICAgICAgIG1vZHV0aWxzLnBwICAgICAgcG9ydG1hcC5wcCAgICAgICAgIHNhbWJhZ3VpLnBwICAg
ICB0ZnRwLnBwICAgICAgICAgICAgeHNlcnZlci5wcApjZXJ0bWFzdGVyLnBwICAgZG5zc2VjdHJp
Z2dlci5wcCAgICBpb2RpbmUucHAgICAgICAgbW9qb21vam8ucHAgICAgICBwb3J0cmVzZXJ2ZS5w
cCAgICAgc2FtYmEucHAgICAgICAgIHRndGQucHAgICAgICAgICAgICB5YW0ucHAKY2VydG1vbmdl
ci5wcCAgIGRvdmVjb3QucHAgICAgICAgICAgaXBzZWMucHAgICAgICAgIG1vbmdvZGIucHAgICAg
ICAgcG9ydHNsYXZlLnBwICAgICAgIHNhbWhhaW4ucHAgICAgICB0aHVuZGVyYmlyZC5wcCAgICAg
emFiYml4LnBwCmNlcnR3YXRjaC5wcCAgICBkcGh5c3N3YXBmaWxlLnBwICAgIGlwdGFibGVzLnBw
ICAgICBtb25pdC5wcCAgICAgICAgIHBvc3RmaXhwb2xpY3lkLnBwICBzYW5sb2NrLnBwICAgICAg
dGltaWRpdHkucHAgICAgICAgIHphcmFmYS5wcApjZmVuZ2luZS5wcCAgICAgZHBrZy5wcCAgICAg
ICAgICAgICBpcmNkLnBwICAgICAgICAgbW9uby5wcCAgICAgICAgICBwb3N0Zml4LnBwICAgICAg
ICAgc2FzbC5wcCAgICAgICAgIHRtcHJlYXBlci5wcCAgICAgICB6ZWJyYS5wcApjZ21hbmFnZXIu
cHAgICAgZHJiZC5wcCAgICAgICAgICAgICBpcmMucHAgICAgICAgICAgbW9ub3AucHAgICAgICAg
ICBwb3N0Z3Jlc3FsLnBwICAgICAgc2JsaW0ucHAgICAgICAgIHRvci5wcCAgICAgICAgICAgICB6
b3NyZW1vdGUucHAKY2dyb3VwLnBwICAgICAgIGRzcGFtLnBwICAgICAgICAgICAgaXJxYmFsYW5j
ZS5wcCAgIG1vbi5wcCAgICAgICAgICAgcG9zdGdyZXkucHAgICAgICAgIHNjcmVlbi5wcCAgICAg
ICB0cG0yLnBwCmNoa3Jvb3RraXQucHAgICBlbnRyb3B5ZC5wcCAgICAgICAgIGlzY3NpLnBwICAg
ICAgICBtb3VudC5wcCAgICAgICAgIHBwcC5wcCAgICAgICAgICAgICBzZWNhZG0ucHAgICAgICAg
dHJhbnNwcm94eS5wcApjaHJvbWl1bS5wcCAgICAgZXZvbHV0aW9uLnBwICAgICAgICBpc25zLnBw
ICAgICAgICAgbW96aWxsYS5wcCAgICAgICBwcmVsaW5rLnBwICAgICAgICAgc2VjdG9vbG0ucHAg
ICAgIHRyaXB3aXJlLnBwCmNocm9ueWQucHAgICAgICBleGltLnBwICAgICAgICAgICAgIGphYmJl
ci5wcCAgICAgICBtcGQucHAgICAgICAgICAgIHByZWx1ZGUucHAgICAgICAgICBzZWxpbnV4dXRp
bC5wcCAgdHVuZWQucHAKY2lwZS5wcCAgICAgICAgIGZhaWwyYmFuLnBwICAgICAgICAgamF2YS5w
cCAgICAgICAgIG1wbGF5ZXIucHAgICAgICAgcHJpdm94eS5wcCAgICAgICAgIHNlbmRtYWlsLnBw
ICAgICB0dnRpbWUucHAKL3RtcC9faG9tZV9vY3Rlb25fbGludXhfZW1iZWRkZWRfcm9vdGZzLXJv
b3Rmcy91c3Ivc2hhcmUvc2VsaW51eC9yZWZwb2xpY3k6KCkgOjogCgo=
--00000000000083246c05b5d5a590--
