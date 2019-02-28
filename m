Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909BCC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 05:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDA5218AE
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 05:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20150623.gappssmtp.com header.i=@perfinion-com.20150623.gappssmtp.com header.b="02m5nLg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfB1FOe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:14:34 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:38297 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfB1FOe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 00:14:34 -0500
Received: by mail-pf1-f171.google.com with SMTP id n125so9133914pfn.5
        for <selinux@vger.kernel.org>; Wed, 27 Feb 2019 21:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A3hkAZxuiuACcReJVQqtgPfHlRhrar+TrvlGd3cIQds=;
        b=02m5nLg/JK6VjLMtHst899AzNUPIizEb01Vqr2AQooA2RRvK3kxoreaPMrExsjNaGl
         ZI9gXKfRHDd+QYR1+g16U/R5gSlc6XRD6cbBotRG55sXZi+0P1lLX7BhpSZ5lope1gkc
         d20FwbT7CLqtu+iWoTtq4mfDXH2dc4A9XR0tziy2qUGQHEE1gNt9CPLZLk80AeH814Q6
         Supv9m/n+zemSoscXaBJrGmkUXSyV0+C/Y/CpJpaTSeLiqqma0oChq3iwPGE0KBW4gUb
         Xejhg2kLWBew3keW1nS2I5dGuiOd/BEdv6HHJ9vFieY22WcyK/A9rJzQJfdALX/aG5uj
         pOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A3hkAZxuiuACcReJVQqtgPfHlRhrar+TrvlGd3cIQds=;
        b=hUNSk/GL6O2Ly19QTrJMEhbL48Tu+Ds0w1wfvuLP3IGzCKvp+up2cL9dJ5vRGwUUjv
         AmEJ5am6+LFMeGypsF4TA3L4ZZK105GpIZ25b/HowC2Ov0TFv6tjcU4bhYTFBjYuiA4V
         wuMb1/P15Ov315ykzcFHAnjkGUpfAUCK09dlkexn3r2XiNjDcU5IMM0XpQKMDLYEAwkw
         VwDtZgDRpzPfss0xBd2rs1VDS6UjWWoaZJBFjJmUrmDBajhndglFB3HIhy7AyUHiT1CH
         nE4iyFJk3B7Ak1bZqK+9P+IDveRhpUmWbaUfMPE8foedmh7d4kiVn9DUO3zQe5y+7kCU
         BcYA==
X-Gm-Message-State: AHQUAuYTnVljlXivX5CxBxPoR5BJ4UOPbgHKnLRYtspSG4qe0MriWW6e
        VVzi5b0PUtI1Eh2so1xxPCPcDQ==
X-Google-Smtp-Source: AHgI3IaXJqF1KfULx7ka+fpkbb/1iCgPVX7uH5rVBCeuG230JjGFJfPfuuw4X9P09DQz2hS1SbjmPw==
X-Received: by 2002:a62:e04b:: with SMTP id f72mr5620326pfh.41.1551330873368;
        Wed, 27 Feb 2019 21:14:33 -0800 (PST)
Received: from localhost ([76.14.26.221])
        by smtp.gmail.com with ESMTPSA id l7sm46829214pfj.162.2019.02.27.21.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 21:14:32 -0800 (PST)
Date:   Wed, 27 Feb 2019 21:14:30 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Subject: Re: .desktop files installed by gui/
Message-ID: <20190228051430.GA9258@meriadoc.perfinion.com>
References: <CAJfZ7=n7c8s-uiGjD=FRMahRQBQANzSa5FbRKSov4w=EZj+f-w@mail.gmail.com>
 <pjdimx5l481.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pjdimx5l481.fsf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 27, 2019 at 03:02:06PM +0100, Petr Lautrbach wrote:
> 
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
> 
> > Hello,
> >
> > Currently, gui/Makefile installs three .desktop files:
> > * /usr/share/system-config-selinux/selinux-polgengui.desktop 
> > (with
> > "Exec=/usr/bin/selinux-polgengui")
> > * /usr/share/system-config-selinux/sepolicy.desktop (with
> > "Exec=/usr/bin/sepolicy gui")
> > * /usr/share/system-config-selinux/system-config-selinux.desktop 
> > (with
> > Exec=/usr/bin/system-config-selinux)
> >
> > There are several issues about them:
> > * The first one does not work because "make install" does not 
> > create
> > /usr/bin/selinux-polgengui. It creates
> > /usr/share/system-config-selinux/polgengui.py instead.
> > * The first two ones do not work on Arch Linux because the 
> > commands
> > they use need to be run as root in order to load.
> > * None of them are seen by GNOME or XFCE, which look for 
> > .desktop
> > files in /usr/share/applications/. This has been reported for 
> > Arch
> > Linux on https://github.com/archlinuxhardened/selinux/issues/20.
> >
> > Are these files used by other distributions? Would it break 
> > things if
> > these files are moved to /usr/share/applications/ 
> 
> This is from Fedora policycoreutils.spec:
> 
> ---
> ln -sf /usr/share/system-config-selinux/polgengui.py 
> %{buildroot}%{_bindir}/selinux-polgengui
> 
> desktop-file-install --dir %{buildroot}%{_datadir}/applications 
> --add-category Settings \
>     %{buildroot}%{_datadir}/system-config-selinux/system-config-selinux.desktop
> 
> desktop-file-install --dir %{buildroot}%{_datadir}/applications 
> --add-category Settings \
>     %{buildroot}%{_datadir}/system-config-selinux/sepolicy.desktop
> 
> desktop-file-install --dir %{buildroot}%{_datadir}/applications \
>     %{buildroot}%{_datadir}/system-config-selinux/selinux-polgengui.desktop
> 
> rm -f 
> %{buildroot}%{_datadir}/system-config-selinux/selinux-polgengui.desktop
> rm -f 
> %{buildroot}%{_datadir}/system-config-selinux/sepolicy.desktop
> rm -f 
> %{buildroot}%{_datadir}/system-config-selinux/system-config-selinux.desktop
> ---
> 
> It's been like that for more than 6 years already.
> 
> Given that it addresses almost all the described problems I can 
> say that
> your proposed changes won't break anything in Fedora.

I haven't even packaged the gui on Gentoo, so its definitely not a
regression here :) 
> 
> > and if pkexec is
> > introduced in order to run commands as root (ie.
> > selinux-polgengui.desktop is changed to "Exec=/usr/bin/pkexec
> > /usr/share/system-config-selinux/polgengui.py" and 
> > sepolicy.desktop to
> > "Exec=/usr/bin/pkexec /usr/bin/sepolicy gui")?
> >
> 
> /usr/share/system-config-selinux/polgengui.py works without root 
> on
> Fedora.
> 
> sepolicy gui asks for privileges on "Action:
> org.selinux.customized" which is decorated by
> @slip.dbus.polkit.require_auth so I'm not sure if pkexec is really 
> needed.

If it works without thats obviously the best. But also I seem to recall
pkexec had issues on my machine. It might need policy updates?

Not that I'd be opposed if you added pkexec since its not used here at
all right now so if I added the gui I'd just fix pkexec first.

-- Jason

> 
> > Nicolas
> 
