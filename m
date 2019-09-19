Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F82BC3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 13:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E96421907
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 13:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiSf6jBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbfISNDI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:03:08 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44716 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfISNDI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 09:03:08 -0400
Received: by mail-wr1-f47.google.com with SMTP id i18so2972883wru.11
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2019 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIO7VpqRridRZA6neRu+MoaNkZZ6uhPyvyCLoH46Mes=;
        b=SiSf6jBf93Q9BXO/ViKYYzfcM5G9X2fGtv2R8HeRgmhgUsRiwnZIF9BTf9Q/7Hl2cA
         11B1lOmzB0/uJo33eJdokXOVsHQsde+YT5ii97K5XrPrIYBns6rvt3ZDYVo+ywS9X+b7
         20l41rmbDXwYw7t2496062j++eCQ+XfxxJl69TxBEbV7puMH8f+scO0sw1u6FaaDQNlX
         X1H894C4by9S/2mNBArdIzKCUUKdsfgYtazYVTGMqayBxtEdtRvHaZcr2vhd+VhNwdkZ
         iU/3aXcWcPKJJziBqXv+3w677ngKtfRXnzPbFE4pcfUO+HLsSn92lZLqFvg6RKm9+/li
         POQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIO7VpqRridRZA6neRu+MoaNkZZ6uhPyvyCLoH46Mes=;
        b=iXaFdWL6iUPYpeoe5tBJdDj1cnQPkYyj6LRu9KShQKSX2cmsjHb0Vn25dnmIGikrdA
         lOPb4mbX+XQEcM326s+s8d8Hd7iUg65mgI0xWilMbIJc0pjIf81MjBEVEa0eaLddgSsx
         rwQKETxwbL2A2PoZX9eBoowOadLorUmRB64fMr3EaxxCaq8LFtKEK/oU9F5pujpxdFxX
         gOPwJDFVTF0y8LnPqZydGQC6TYDJRJyWJxShWfJ/IRDq1c2wAgrgvNuVLwl3h6qv7sMz
         WG+Vo+C2ED4StG4G8JAi6REIrkO1TeBwXvAyjhTdQsXH+okzC9SLMIFtumvU0dwZa7ma
         B4oA==
X-Gm-Message-State: APjAAAVix/YiSIi9bxBJGq3L0H5ElSELsZMjtl4QfQyGy7RXQdUtiz3d
        zifm15KUoYZK4kcXAdW79RW7hUhi9RZKOvYddhx9cw==
X-Google-Smtp-Source: APXvYqyhy0cAHEiu2CHLT/qV4eWop899a0a6pYHjqc7l0KdFSuf5K3S9xwnLmoXhi8t2IoteO2Ilvwj4LkAUvNRO6qo=
X-Received: by 2002:adf:9cc7:: with SMTP id h7mr6889681wre.193.1568898186705;
 Thu, 19 Sep 2019 06:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
 <ac6433e2-88a4-747c-66f5-d241499f40d6@tycho.nsa.gov> <CAFPpqQGfAifnShcWTMs1pJe1m7W_4wM8AUqFsvj4Zts5-9QiCQ@mail.gmail.com>
 <b2c71d86-c574-43d6-2fcf-17a06078c8df@tycho.nsa.gov>
In-Reply-To: <b2c71d86-c574-43d6-2fcf-17a06078c8df@tycho.nsa.gov>
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 19 Sep 2019 08:02:51 -0500
Message-ID: <CAFPpqQHJU8sta7t5ZQ2PQCJi064Po4jXZ2g-LAoOZPF9rtd-pQ@mail.gmail.com>
Subject: Re: strange tclass in AVCs
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 18, 2019 at 9:18 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 9/18/19 10:03 AM, Ted Toth wrote:
> > On Wed, Sep 18, 2019 at 8:53 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>
> >> On 9/18/19 9:35 AM, Ted Toth wrote:
> >>> I'm seeing things like tclass=context#012 in some AVCs what is this telling me?
> >>
> >> Just a guess here, but octal 012 is '\n' aka a newline character, and
> >> libselinux/src/avc.c:avc_audit() appends a "\n" at the end of the buffer
> >> before calling avc_log() to log the entire string.  avc_log() will call
> >> the logging callback, and dbusd does define one, which calls
> >> audit_log_user_avc_message().  Maybe audit_log_user_avc_message() is
> >> escaping the newline character in its output as well as appending
> >> additional data.
> >>
> >> I'm a little unclear though on why dbusd is checking a context contains
> >> permission?
> >
> > These appear to only occur when systemd is starting the dbus daemon
> > and they end up in /var/log/messages not /var/log/audit/audit.log as
> > I'd expect.
>
> Sounds like auditd isn't operational at that point and therefore the
> output just goes to syslog.
>
> Arguably avc_audit() shouldn't be adding a newline at all and that
> should be handled by the logging callback (or default_selinux_log if no
> callback is set).  But it has been this way forever, so that would no
> doubt break some users.  Legacy of when this was a printk/printf.
>
>
>
>

FWIW here's the comments from the function dbus uses that calls
avs_has_perm where the contains check happens. Why dbus policy does
not allow this is seems like an oversight.

/**
 * Determine if the SELinux security policy allows the given sender
 * security context to go to the given recipient security context.
 * This function determines if the requested permissions are to be
 * granted from the connection to the message bus or to another
 * optionally supplied security identifier (e.g. for a service
 * context).  Currently these permissions are either send_msg or
 * acquire_svc in the dbus class.
 *
 * @param sender_sid source security context
 * @param override_sid is the target security context.  If SECSID_WILD this will
 *        use the context of the bus itself (e.g. the default).
 * @param target_class is the target security class.
 * @param requested is the requested permissions.
 * @returns #TRUE if security policy allows the send.
 */
#ifdef HAVE_SELINUX
static dbus_bool_t
bus_selinux_check (BusSELinuxID        *sender_sid,
                   BusSELinuxID        *override_sid,
                   security_class_t     target_class,
                   access_vector_t      requested,
                   DBusString          *auxdata)
