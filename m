Return-Path: <SRS0=s7s9=A3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E03C433DF
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C88D207E8
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 15:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgEpLtKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgGPPMb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgGPPMb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 11:12:31 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E4EC061755
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 08:12:31 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so4469254otc.3
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rz2FtH2lhwDAbInzFYb6E+pCKJyGbp0bUPQnIOK3+Ps=;
        b=sgEpLtKVyG5k7pZpROnzxJNhHojfzz8DgZIgvSrBiffq2rSfH6SSMzHk4erDP+l25T
         r5uGdlCS4D9A67Z/c9l9gkoy3E1j0Iiu3B0Uj4zfcWY24GRSRZNRNt1Htic5pKdnedwv
         Vf2G2IukzOyKjpwOWZ5oeE7W/G1HUyH+8P103Po5t3S7Fj+8l8OdurL2k/+M3nrz7DIN
         EbRSJ8w8kWzRSuQbYiCrtZmd9u7M2xKQxTuziK+HJFMG/xnpInC4KSmpYCWN9XgKuvdl
         plLDNBxbzx/4qKL+LiPb6zEMcVUMh88PLT0uARfcvc41T1yds/mN5ZuISjvumDgqdbd4
         SXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rz2FtH2lhwDAbInzFYb6E+pCKJyGbp0bUPQnIOK3+Ps=;
        b=iBQ8KX4hLj+CYaMg73Qj1Oc3GG15QKPcplr3bCHwyg9mIetKg15lzYcVb/1WejTdA4
         Vp4OtnwTuHSb8zxSEzED7cv5Z5N7/KC9hYxGK2uSiurisCMhhRrK8KKGwj6w3abeLVOY
         8Y/3YY+6ok+TrPONs9hzbLJiQ9pg+H+dNYMbAE0tOuCjW0+JjrJYC/Imsj3KlS3b0uyQ
         dPPr5VjVv0DWctlZZc9W6/6iR5rLEktL7JuR5VX1ZY0ldUxYTJDIFahuISOUWH197PzS
         mZfVbDQWMtDTVYub2r7/eV9kNBbh5weJbHN5ovOspErONOSlHOOCLiVCjf4m+fZoX8Xz
         5LJA==
X-Gm-Message-State: AOAM531/Jg1t1AHB7cofBTT8ikR5r/A9qB9s3CsPEQXpOm/wDY4BxL5W
        HIPGT+pg7bRfaWpK/pZM0sUs7lvoldZlF3ZRKUK5Aw==
X-Google-Smtp-Source: ABdhPJzLXQqpbrrQTzDh84R0ISOMUOAMrMw8VB2GQmfvsr/lKxBXDLQACRzJgRnS8HQES/P7cR2NyIrvpxRgZjKkS8o=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr4977878oti.162.1594912350540;
 Thu, 16 Jul 2020 08:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ5m31kcXH66viy3R-ncbBJCET8Wm3+DjphDeZ0iV3giEA@mail.gmail.com>
 <CAMN686GqFW_40pcX=fkb8XUVFczg7+md8tqoS45C4VNcbcq-ww@mail.gmail.com>
 <CAEjxPJ5mb9iz8OnGUMS6i0i5sbmxf=Ff6h6ey95SgJzXjgyuDw@mail.gmail.com>
 <CAMN686HGb5-TmKAa3h+eof6a451CMa7Qd9n5F9FX_ozw31BWAg@mail.gmail.com>
 <CAMN686F4uT7__dvy22V_Y9_zqd6ckw=14gs6RcExuT-3ru6NtA@mail.gmail.com>
 <CAEjxPJ4B4sOjy_ZW+hCMjA7Uy6KGO5HT8tMdFp_obF_raXiqUw@mail.gmail.com>
 <CAMN686EudnKSaR89rKm8xOkYJVJA8-eXFc__1k4QMH9Vyp5b1w@mail.gmail.com>
 <CAMN686F=msEb59N4pjroKFzZU4sH+81UzeyL91Hbvy3bddunqg@mail.gmail.com>
 <CAEjxPJ5RGYQi4A7nD8b=tKv2OdC7f8wfMiwprApOCNADEi-ahg@mail.gmail.com>
 <CAMN686H=3RY-E1a01fWPY9QqGpUABVxJmQGrx00c53JrMVswZA@mail.gmail.com>
 <CAEjxPJ6PQe0WPOA-LjNbfhRfDP7=dJ7N0aisCu9Y=WSHC7HXGA@mail.gmail.com> <CAMN686Ep659JPUhvkfSZ2eCxSwz8EkL6sdZ5kTT0td0buYi=Qw@mail.gmail.com>
In-Reply-To: <CAMN686Ep659JPUhvkfSZ2eCxSwz8EkL6sdZ5kTT0td0buYi=Qw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 16 Jul 2020 11:12:18 -0400
Message-ID: <CAEjxPJ56fWB-_k749aXOESJaDEJqQnQOznGZJkYm_=2LFJ6BEQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 16, 2020 at 9:36 AM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> On Thu, Jul 16, 2020 at 8:40 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jul 15, 2020 at 6:45 PM Mike Palmiotto
> > <mike.palmiotto@crunchydata.com> wrote:
> > > Interestingly, the test program is working fine:
> > > https://github.com/mpalmi/selinux/tree/sestatus
> > > https://github.com/mpalmi/sestatus-test
> > >
> > > On a test run, I'm seeing both the status page and netlink socket
> > > notifications for load_polcy (twice for each case):
> > >
> > > ```
> > >  ./test
> > > opened avc successfully
> > > got netlink socket: 4
> > >
> > > watching netlink socket for events
> > > avc:  received policyload notice (seqno=3D3)
> > > policy reload notice received
> > > avc:  received policyload notice (seqno=3D4)
> > > policy reload notice received
> > > ^C
> > > watching sestatus page for events
> > > avc:  received policyload notice (seqno=3D5)
> > > policy reload notice received
> > > avc:  received policyload notice (seqno=3D6)
> > > policy reload notice received
> > > ^Cclosing netlink socket: 4
> > > destroying avc
> > > goodbye
> > > ```
> > >
> > > Still seeing the MAC_POLICY_LOAD audit message, but none of the usual
> > > USER_AVC policyload notices.
> >
> > I only see one notification per load_policy invocation.
>
> I meant I ran load_policy twice for netlink and then twice for
> sestatus. You're correct, there is only one notification per
> invocation.
>
> > What versions of kernel and dbus are you using? Are you using dbus-daem=
on or
> > dbus-broker?  How are you testing dbus with this change - just doing a
> > make install relabel of libselinux and restarting dbus-daemon or
> > dbus-broker, then running load_policy and checking for USER_AVC
> > messages?  Is this on CentOS 7/8?
>
> Here's my setup:
>
> [vagrant/staff_r/SystemLow@mls:~]$ uname -r
> 4.18.0-193.el8.x86_64
> [vagrant/staff_r/SystemLow@mls:~]$ cat /etc/redhat-release
> Red Hat Enterprise Linux release 8.2 (Ootpa)
> [vagrant/staff_r/SystemLow@mls:~]$ dbus-daemon --version | head -1
> D-Bus Message Bus Daemon 1.12.8
> [vagrant/staff_r/SystemLow@mls:~]$ systemctl status --no-pager dbus --ful=
l
> =E2=97=8F dbus.service - D-Bus System Message Bus
>    Loaded: loaded (/usr/lib/systemd/system/dbus.service; static;
> vendor preset: disabled)
>    Active: active (running) since Thu 2020-07-16 01:19:31 UTC; 47min ago
>      Docs: man:dbus-daemon(1)
>  Main PID: 865 (dbus-daemon)
>     Tasks: 1 (limit: 11480)
>    Memory: 3.6M
>    CGroup: /system.slice/dbus.service
>            =E2=94=94=E2=94=80865 /usr/bin/dbus-daemon --system --address=
=3Dsystemd:
> --nofork --nopidfile --systemd-activation --syslog-only
>
> This is my test thread:
>
> 1) `make clean distclean`
> 2) `sudo make DEBUG=3D1 LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 install
> install-pywrap relabel -s`
> 3) `sudo restorecon -RF /` (mcstrans apparently doesn't have the
> relabel target -- I should submit a patch for that)
> 5) reboot
> 6) load_policy/setenforce/setsebool and look for USER_AVC notices in audi=
t.log
>
> Please let me know if there's any other information you need. I'm
> still trying to track this down on my end. I will probably build dbus
> with debugging and take a look at what's going on.

That version of dbus did not call avc_netlink_acquire_fd().  It only
calls avc_init() with a thread callback,
with the expectation that avc_init() will create the thread (as it did
prior to your patch).  So you can't move that part.
Not sure what happens if you leave it there.

If you can't make it work cleanly with legacy object managers, then I
guess we can go with the opt-in route.
