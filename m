Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63485C4338F
	for <selinux@archiver.kernel.org>; Fri, 30 Jul 2021 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A97460F94
	for <selinux@archiver.kernel.org>; Fri, 30 Jul 2021 14:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbhG3OUM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbhG3OTb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jul 2021 10:19:31 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6035BC061386
        for <selinux@vger.kernel.org>; Fri, 30 Jul 2021 07:19:18 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id a19so13397631oiw.6
        for <selinux@vger.kernel.org>; Fri, 30 Jul 2021 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fixPITF+cxqkuQgeF5VDXxTVQj9Ftw5LzyJ1XmMAN9I=;
        b=S5glkR8J+A9+JoK5t9k2ZQKM514Vl8C2kRqTxO5HZ5iZ5louuSM0P4R0e143QBYXVf
         p+AVVXL9cR8jxL115H5igNPcUsan9i7IcDdxP7PrKK9/iltM60zw9tuq6TxzzWIpmaNt
         S6QiV7FpFt12hlrWNwj2X9pg7uF1rJLra+3Yh5N5K9O1MeybO4iM4YkqTf3+xt4uqG2y
         m1cL6MdQClbI2gqGDuqVxZUux08iyMAaH0Eo648bnDi45dpCrN684wrg/+7dn5Ig04HF
         k621wnG8M6UxPBBNdO7Mz/Xy3zsUjAJ2Qw6y8bvLFDth7rKTx42qbXoia5Kn6OqAGsNr
         z8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fixPITF+cxqkuQgeF5VDXxTVQj9Ftw5LzyJ1XmMAN9I=;
        b=VDS68dXQEnJzkeJ43iUHS1idhvDoD6ctDWDpNBe0bfbuDSItQaUYkNlp24x6NXldk0
         XtEVhiJ76QnAN/VVQL0VZoe+zzRY29zaoDNw0GGTQ4EFmLLJnLQcUcmN4yjAaAAusJkb
         E+GaufTR6OJwEv50TvPnj2TQQ4U0URPPReM4tnGg0kDvd2SW01YcxfVFMw7MBJptgm0F
         Qoc13dnT3hPbehj9qIRN1FLMr99QwFlVLM2NB0yL7fC+nRserS9nqZ7BR6UcPKbXTKML
         j9p4DGqgGIV8M/qTrnt87sT6CmiNZ4M+46FX5HSlzcZD/Bh76UI1UZEiTD2ZFfwbmixJ
         MISw==
X-Gm-Message-State: AOAM531zVqgAV3TJkDLs2hzapspDgHx0YYFWHuv7YKYrt94TFc0qIsOz
        PDspD7mKl1dpfE1akugrHS08AQJcKMIVvUd8OYg=
X-Google-Smtp-Source: ABdhPJyX3SeI7pbrXZ4NfznSpS2GP2L70dSfb22F3D13skpPxhgLSWVyMM4sLKKj/PxqICSVCyBbvQUdqE5c5q7LVBM=
X-Received: by 2002:aca:ad90:: with SMTP id w138mr1915994oie.16.1627654757812;
 Fri, 30 Jul 2021 07:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210728165835.186338-1-plautrba@redhat.com>
In-Reply-To: <20210728165835.186338-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 30 Jul 2021 10:19:07 -0400
Message-ID: <CAP+JOzS-HRWq7SpjapTQXZpvAXvL_CmS=_YOtuH=anTQ1BJ+mg@mail.gmail.com>
Subject: Re: [PATCH] Do not use Python slip
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 28, 2021 at 12:59 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Python slip is not actively maintained anymore and it was used just as
> a polkit proxy. It looks like polkit dbus interface is quite simple to
> be used directly via python dbus module.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

I am not very familiar with the python parts of the SELinux userspace,
but this patch looks good to me.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  dbus/selinux_server.py             | 69 ++++++++++++++++++------------
>  python/sepolicy/sepolicy/sedbus.py |  9 ----
>  2 files changed, 41 insertions(+), 37 deletions(-)
>
> diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
> index be4f4557a9fa..b7c9378bcb5d 100644
> --- a/dbus/selinux_server.py
> +++ b/dbus/selinux_server.py
> @@ -4,26 +4,33 @@ import dbus
>  import dbus.service
>  import dbus.mainloop.glib
>  from gi.repository import GObject
> -import slip.dbus.service
> -from slip.dbus import polkit
>  import os
>  import selinux
>  from subprocess import Popen, PIPE, STDOUT
>
>
> -class selinux_server(slip.dbus.service.Object):
> +class selinux_server(dbus.service.Object):
>      default_polkit_auth_required = "org.selinux.semanage"
>
>      def __init__(self, *p, **k):
>          super(selinux_server, self).__init__(*p, **k)
>
> +    def is_authorized(self, sender, action_id):
> +        bus = dbus.SystemBus()
> +        proxy = bus.get_object('org.freedesktop.PolicyKit1', '/org/freedesktop/PolicyKit1/Authority')
> +        authority = dbus.Interface(proxy, dbus_interface='org.freedesktop.PolicyKit1.Authority')
> +        subject = ('system-bus-name', {'name': sender})
> +        result = authority.CheckAuthorization(subject, action_id, {}, 1, '')
> +        return result[0]
> +
>      #
>      # The semanage method runs a transaction on a series of semanage commands,
>      # these commands can take the output of customized
>      #
> -    @slip.dbus.polkit.require_auth("org.selinux.semanage")
> -    @dbus.service.method("org.selinux", in_signature='s')
> -    def semanage(self, buf):
> +    @dbus.service.method("org.selinux", in_signature='s', sender_keyword="sender")
> +    def semanage(self, buf, sender):
> +        if not self.is_authorized(sender, "org.selinux.semanage"):
> +            raise dbus.exceptions.DBusException("Not authorized")
>          p = Popen(["/usr/sbin/semanage", "import"], stdout=PIPE, stderr=PIPE, stdin=PIPE, universal_newlines=True)
>          p.stdin.write(buf)
>          output = p.communicate()
> @@ -35,9 +42,10 @@ class selinux_server(slip.dbus.service.Object):
>      # on the server.  This output can be used with the semanage method on
>      # another server to make the two systems have duplicate policy.
>      #
> -    @slip.dbus.polkit.require_auth("org.selinux.customized")
> -    @dbus.service.method("org.selinux", in_signature='', out_signature='s')
> -    def customized(self):
> +    @dbus.service.method("org.selinux", in_signature='', out_signature='s', sender_keyword="sender")
> +    def customized(self, sender):
> +        if not self.is_authorized(sender, "org.selinux.customized"):
> +            raise dbus.exceptions.DBusException("Not authorized")
>          p = Popen(["/usr/sbin/semanage", "export"], stdout=PIPE, stderr=PIPE, universal_newlines=True)
>          buf = p.stdout.read()
>          output = p.communicate()
> @@ -49,9 +57,10 @@ class selinux_server(slip.dbus.service.Object):
>      # The semodule_list method will return the output of semodule --list=full, using the customized polkit,
>      # since this is a readonly behaviour
>      #
> -    @slip.dbus.polkit.require_auth("org.selinux.semodule_list")
> -    @dbus.service.method("org.selinux", in_signature='', out_signature='s')
> -    def semodule_list(self):
> +    @dbus.service.method("org.selinux", in_signature='', out_signature='s', sender_keyword="sender")
> +    def semodule_list(self, sender):
> +        if not self.is_authorized(sender, "org.selinux.semodule_list"):
> +            raise dbus.exceptions.DBusException("Not authorized")
>          p = Popen(["/usr/sbin/semodule", "--list=full"], stdout=PIPE, stderr=PIPE, universal_newlines=True)
>          buf = p.stdout.read()
>          output = p.communicate()
> @@ -62,25 +71,28 @@ class selinux_server(slip.dbus.service.Object):
>      #
>      # The restorecon method modifies any file path to the default system label
>      #
> -    @slip.dbus.polkit.require_auth("org.selinux.restorecon")
> -    @dbus.service.method("org.selinux", in_signature='s')
> -    def restorecon(self, path):
> +    @dbus.service.method("org.selinux", in_signature='s', sender_keyword="sender")
> +    def restorecon(self, path, sender):
> +        if not self.is_authorized(sender, "org.selinux.restorecon"):
> +            raise dbus.exceptions.DBusException("Not authorized")
>          selinux.restorecon(str(path), recursive=1)
>
>      #
>      # The setenforce method turns off the current enforcement of SELinux
>      #
> -    @slip.dbus.polkit.require_auth("org.selinux.setenforce")
> -    @dbus.service.method("org.selinux", in_signature='i')
> -    def setenforce(self, value):
> +    @dbus.service.method("org.selinux", in_signature='i', sender_keyword="sender")
> +    def setenforce(self, value, sender):
> +        if not self.is_authorized(sender, "org.selinux.setenforce"):
> +            raise dbus.exceptions.DBusException("Not authorized")
>          selinux.security_setenforce(value)
>
>      #
>      # The setenforce method turns off the current enforcement of SELinux
>      #
> -    @slip.dbus.polkit.require_auth("org.selinux.relabel_on_boot")
> -    @dbus.service.method("org.selinux", in_signature='i')
> -    def relabel_on_boot(self, value):
> +    @dbus.service.method("org.selinux", in_signature='i', sender_keyword="sender")
> +    def relabel_on_boot(self, value, sender):
> +        if not self.is_authorized(sender, "org.selinux.relabel_on_boot"):
> +            raise dbus.exceptions.DBusException("Not authorized")
>          if value == 1:
>              fd = open("/.autorelabel", "w")
>              fd.close()
> @@ -111,9 +123,10 @@ class selinux_server(slip.dbus.service.Object):
>      #
>      # The change_default_enforcement modifies the current enforcement mode
>      #
> -    @slip.dbus.polkit.require_auth("org.selinux.change_default_mode")
> -    @dbus.service.method("org.selinux", in_signature='s')
> -    def change_default_mode(self, value):
> +    @dbus.service.method("org.selinux", in_signature='s', sender_keyword="sender")
> +    def change_default_mode(self, value, sender):
> +        if not self.is_authorized(sender, "org.selinux.change_default_mode"):
> +            raise dbus.exceptions.DBusException("Not authorized")
>          values = ["enforcing", "permissive", "disabled"]
>          if value not in values:
>              raise ValueError("Enforcement mode must be %s" % ", ".join(values))
> @@ -122,9 +135,10 @@ class selinux_server(slip.dbus.service.Object):
>      #
>      # The change_default_policy method modifies the policy type
>      #
> -    @slip.dbus.polkit.require_auth("org.selinux.change_default_policy")
> -    @dbus.service.method("org.selinux", in_signature='s')
> -    def change_default_policy(self, value):
> +    @dbus.service.method("org.selinux", in_signature='s', sender_keyword="sender")
> +    def change_default_policy(self, value, sender):
> +        if not self.is_authorized(sender, "org.selinux.change_default_policy"):
> +            raise dbus.exceptions.DBusException("Not authorized")
>          path = selinux.selinux_path() + value
>          if os.path.isdir(path):
>              return self.write_selinux_config(policy=value)
> @@ -136,5 +150,4 @@ if __name__ == "__main__":
>      system_bus = dbus.SystemBus()
>      name = dbus.service.BusName("org.selinux", system_bus)
>      object = selinux_server(system_bus, "/org/selinux/object")
> -    slip.dbus.service.set_mainloop(mainloop)
>      mainloop.run()
> diff --git a/python/sepolicy/sepolicy/sedbus.py b/python/sepolicy/sepolicy/sedbus.py
> index 76b259ae27e8..39b53d47753a 100644
> --- a/python/sepolicy/sepolicy/sedbus.py
> +++ b/python/sepolicy/sepolicy/sedbus.py
> @@ -2,7 +2,6 @@ import sys
>  import dbus
>  import dbus.service
>  import dbus.mainloop.glib
> -from slip.dbus import polkit
>
>
>  class SELinuxDBus (object):
> @@ -11,42 +10,34 @@ class SELinuxDBus (object):
>          self.bus = dbus.SystemBus()
>          self.dbus_object = self.bus.get_object("org.selinux", "/org/selinux/object")
>
> -    @polkit.enable_proxy
>      def semanage(self, buf):
>          ret = self.dbus_object.semanage(buf, dbus_interface="org.selinux")
>          return ret
>
> -    @polkit.enable_proxy
>      def restorecon(self, path):
>          ret = self.dbus_object.restorecon(path, dbus_interface="org.selinux")
>          return ret
>
> -    @polkit.enable_proxy
>      def setenforce(self, value):
>          ret = self.dbus_object.setenforce(value, dbus_interface="org.selinux")
>          return ret
>
> -    @polkit.enable_proxy
>      def customized(self):
>          ret = self.dbus_object.customized(dbus_interface="org.selinux")
>          return ret
>
> -    @polkit.enable_proxy
>      def semodule_list(self):
>          ret = self.dbus_object.semodule_list(dbus_interface="org.selinux")
>          return ret
>
> -    @polkit.enable_proxy
>      def relabel_on_boot(self, value):
>          ret = self.dbus_object.relabel_on_boot(value, dbus_interface="org.selinux")
>          return ret
>
> -    @polkit.enable_proxy
>      def change_default_mode(self, value):
>          ret = self.dbus_object.change_default_mode(value, dbus_interface="org.selinux")
>          return ret
>
> -    @polkit.enable_proxy
>      def change_default_policy(self, value):
>          ret = self.dbus_object.change_default_policy(value, dbus_interface="org.selinux")
>          return ret
> --
> 2.32.0
>
