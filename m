Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AA2C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 17:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B48B217D6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 17:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkK1A3ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390002AbfISRTn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:19:43 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42903 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389230AbfISRTm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 13:19:42 -0400
Received: by mail-wr1-f50.google.com with SMTP id n14so3926814wrw.9
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2019 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCK2xHlUH9Ec6S22H5/pIOZ0rDUq1FwwbdffFvARigI=;
        b=lkK1A3ow5ZcVjX5Bs59NUM7mdmEUM7LTMJ/MWm75bQfrZ5DOE77TqDV36DvLaQFKEt
         81ckaCeLk9/IPGux4DMDYe5Q+TbLXGoBCSXMgP0MbL0WiyCgUgbkgKOMKC2WJtNviXeT
         xk5xxbJKKEEl3Wfc4yK4/aSm8SzfkAVBJ9C4G4Gq4iexZSPGtz9A4bSZMVbJA1izHDKL
         pGjifQCvGZd8RlovpLDvAUzAP8GdaMF0WVhYECqOBdmFmwJPKRWyzuLo5D+zj7Lo0dkj
         UvrNo4DKuiLUZDBQVVMP3AHkHaUfWyrymPbH7iQUv3maXayuKX3H6WcFaRYVDOIwQi6l
         FdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCK2xHlUH9Ec6S22H5/pIOZ0rDUq1FwwbdffFvARigI=;
        b=OvSgBXJXYUzFL/DHgEDAIdeK0llsA3oalMt1XyVvLgWIuH2sLhVe+wjHlk43oz4bFg
         emQPgxtSnIcepLNGq5o78V6QN2Lm8LcEdqMzYhd2rCxJ6R91xaVUMvVPUYGGmZ12Q4r8
         alAYH+xzSO8zM3Z59BoKcggzPBBqPW0towaejD/h5kUm5lTSVAr+QDY+REF7d0VHOtAS
         QPo3zdMNW26G4AHmGyMrrqsBkYZ92sRlbxZ0NjM1FVnc7UNgRFQCA+0QXmm8ETc7yENS
         yX+QwW89rkDUD3q9bxEdN0kmgwk6oSMjJqPaeCuZ0cuSiuGzDhzyDMxUaUl3ZSlVUrM/
         RHOg==
X-Gm-Message-State: APjAAAXlMXxnbIwo0JWxD/sojgOAFUpqV7BRRtN55vDyLbVrBes6lT1X
        Z9D+loY2GZdSHo4osKQCaiajPr0vM0aLJPqsxxdLuA==
X-Google-Smtp-Source: APXvYqxKnILqYlVVBAaqAdphcNwXEdT7p4hBzb/ltx37g5iLbfGHMjXgKFjcfgWikelU4uBJMKEXQoTJv39KiIbWpFA=
X-Received: by 2002:a5d:4c92:: with SMTP id z18mr7597775wrs.111.1568913580419;
 Thu, 19 Sep 2019 10:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
 <ac6433e2-88a4-747c-66f5-d241499f40d6@tycho.nsa.gov> <CAFPpqQGfAifnShcWTMs1pJe1m7W_4wM8AUqFsvj4Zts5-9QiCQ@mail.gmail.com>
 <b2c71d86-c574-43d6-2fcf-17a06078c8df@tycho.nsa.gov> <CAFPpqQHJU8sta7t5ZQ2PQCJi064Po4jXZ2g-LAoOZPF9rtd-pQ@mail.gmail.com>
 <e8f03fe4-9a6d-3803-9766-ab3226fe79ed@tycho.nsa.gov>
In-Reply-To: <e8f03fe4-9a6d-3803-9766-ab3226fe79ed@tycho.nsa.gov>
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 19 Sep 2019 12:19:29 -0500
Message-ID: <CAFPpqQG_2B=-E8HNEaMkkKidXWPSuEs9M_ZWR7u_YdQ7KmvuCQ@mail.gmail.com>
Subject: Re: strange tclass in AVCs
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 19, 2019 at 12:03 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 9/19/19 9:02 AM, Ted Toth wrote:
> > On Wed, Sep 18, 2019 at 9:18 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>
> >> On 9/18/19 10:03 AM, Ted Toth wrote:
> >>> On Wed, Sep 18, 2019 at 8:53 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>>>
> >>>> On 9/18/19 9:35 AM, Ted Toth wrote:
> >>>>> I'm seeing things like tclass=context#012 in some AVCs what is this telling me?
> >>>>
> >>>> Just a guess here, but octal 012 is '\n' aka a newline character, and
> >>>> libselinux/src/avc.c:avc_audit() appends a "\n" at the end of the buffer
> >>>> before calling avc_log() to log the entire string.  avc_log() will call
> >>>> the logging callback, and dbusd does define one, which calls
> >>>> audit_log_user_avc_message().  Maybe audit_log_user_avc_message() is
> >>>> escaping the newline character in its output as well as appending
> >>>> additional data.
> >>>>
> >>>> I'm a little unclear though on why dbusd is checking a context contains
> >>>> permission?
> >>>
> >>> These appear to only occur when systemd is starting the dbus daemon
> >>> and they end up in /var/log/messages not /var/log/audit/audit.log as
> >>> I'd expect.
> >>
> >> Sounds like auditd isn't operational at that point and therefore the
> >> output just goes to syslog.
> >>
> >> Arguably avc_audit() shouldn't be adding a newline at all and that
> >> should be handled by the logging callback (or default_selinux_log if no
> >> callback is set).  But it has been this way forever, so that would no
> >> doubt break some users.  Legacy of when this was a printk/printf.
> >>
> >>
> >>
> >>
> >
> > FWIW here's the comments from the function dbus uses that calls
> > avs_has_perm where the contains check happens. Why dbus policy does
> > not allow this is seems like an oversight.
>
> dbusd doesn't check context contains permission AFAIK, only acquire_svc
> and send_msg permissions in the dbus class.  Is that something you
> added?  Or are we picking up some kind of pam module interaction?

You're right it only checks those permissions not contains :( We don't
modify dbus.
How were you thinking pam could be involved?

>
> >
> > /**
> >   * Determine if the SELinux security policy allows the given sender
> >   * security context to go to the given recipient security context.
> >   * This function determines if the requested permissions are to be
> >   * granted from the connection to the message bus or to another
> >   * optionally supplied security identifier (e.g. for a service
> >   * context).  Currently these permissions are either send_msg or
> >   * acquire_svc in the dbus class.
> >   *
> >   * @param sender_sid source security context
> >   * @param override_sid is the target security context.  If SECSID_WILD this will
> >   *        use the context of the bus itself (e.g. the default).
> >   * @param target_class is the target security class.
> >   * @param requested is the requested permissions.
> >   * @returns #TRUE if security policy allows the send.
> >   */
> > #ifdef HAVE_SELINUX
> > static dbus_bool_t
> > bus_selinux_check (BusSELinuxID        *sender_sid,
> >                     BusSELinuxID        *override_sid,
> >                     security_class_t     target_class,
> >                     access_vector_t      requested,
> >                     DBusString          *auxdata)
> >
>
