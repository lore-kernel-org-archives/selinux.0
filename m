Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF150C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 21:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiLPVxr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 16:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPVxq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 16:53:46 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B03F5F405
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 13:53:42 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kw15so9158743ejc.10
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 13:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OjJQLftJVh0yNtGggpElAun+Qst38/bVUWm/H2jtLi0=;
        b=khLbwsrSPnwX7+aEBsqP2U4RwHi5+wm73KK+8insr+1GFZIYHKnpk81iXsuL5byh67
         uc9Kw3729Bc6ccukvCyLzMIsvIRbtUNk6jXGZO3wyaxaLrRhscNRfiOWowX6gaTXM5Xd
         QMjqJNOT0dwpWhZcux9R71HYmKTBP4QK5ATNDiFHFQlwmDNwYJKO3aftceK+HuRodmWu
         MWRYMwF7bcNcwq7JBv+NdpEkVnbiQ+LLlXu3Vt2lzL+ry/o4TpJgyNxgI4LIStttJUu6
         K9HdNjCsn3GojTGyI4L/kl62waK8lUpOWGKhtu1AJJH6U3jNucEpNgsW20XLCMu8ptPl
         MiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjJQLftJVh0yNtGggpElAun+Qst38/bVUWm/H2jtLi0=;
        b=BCA7oWSinXSM9cd8c9BwihoGCdteNWgARQJ1vc40cJoCwIHfDIDGMFm3mprpZsftgn
         nyCMieNDV9qcdJnS0WGMr49tal/u327G6L5vTxaMjsIKk+kWA7yIn1H/t6U2lOe0ITtz
         SLD3lFKsxZHKTX40MV8zOegHSk7qOkfcvMKYDqZy6baRo5Ymr/y+ZbX+nUX4YVzF8JQ/
         BxdX2Ov0KzlJT9m1u5C6q5bpmRUuMuXmzTNnzy9Qpz+znFpV1I9Fix45qBwClxAGtbJ2
         IQwnabDmYfzruuk1BhyotOCs3bjEp2ofx7P04C0aDxCX0gVUKjVRGcqEw8PLdyEKtf13
         fWiA==
X-Gm-Message-State: ANoB5pl2i3r8ytFVb/PevEXMmOIhZjeTgk041v/coj82e1H6AU2At8Lv
        1ioXPp+mt9CfWVEsnHWQkYoefeMjfNXVu1O9dtI2MZD77kY=
X-Google-Smtp-Source: AA0mqf77xy+Zv/sWX1TTfqyodWM7ZzaSU1KbaXqwjMI8lU07mplddE/SB0Yd3ju3oFJXsXaJ+yVckK2Mbczwnnx5uBQ=
X-Received: by 2002:a17:906:3a15:b0:7c1:b65:ad79 with SMTP id
 z21-20020a1709063a1500b007c10b65ad79mr11017188eje.402.1671227620517; Fri, 16
 Dec 2022 13:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20221208194335.479739-1-lautrbach@redhat.com>
In-Reply-To: <20221208194335.479739-1-lautrbach@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 16:53:29 -0500
Message-ID: <CAP+JOzQAsGdps1=RMJQMerJ-SQ=VWeWOCV4fOhtog3g6j1kYGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sepolicy: Switch main selection menu to GtkPopover
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 8, 2022 at 2:54 PM Petr Lautrbach <lautrbach@redhat.com> wrote:
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/206
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy/gui.py         | 20 ++++----------------
>  python/sepolicy/sepolicy/sepolicy.glade |  9 +--------
>  2 files changed, 5 insertions(+), 24 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> index c8f33f522a2d..53f3c6148b58 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -135,9 +135,8 @@ class SELinuxGui():
>          builder.add_from_file(glade_file)
>          self.outer_notebook = builder.get_object("outer_notebook")
>          self.window = builder.get_object("SELinux_window")
> -        self.main_selection_window = builder.get_object("Main_selection_menu")
> +        self.main_selection_popover = builder.get_object("Main_selection_menu")
>          self.main_advanced_label = builder.get_object("main_advanced_label")
> -        self.popup = 0
>          self.applications_selection_button = builder.get_object("applications_selection_button")
>          self.revert_button = builder.get_object("Revert_button")
>          self.busy_cursor = Gdk.Cursor(Gdk.CursorType.WATCH)
> @@ -531,7 +530,6 @@ class SELinuxGui():
>          dic = {
>              "on_combo_button_clicked": self.open_combo_menu,
>              "on_disable_ptrace_toggled": self.on_disable_ptrace,
> -            "on_SELinux_window_configure_event": self.hide_combo_menu,
>              "on_entrycompletion_obj_match_selected": self.set_application_label,
>              "on_filter_changed": self.get_filter_data,
>              "on_save_changes_file_equiv_clicked": self.update_to_file_equiv,
> @@ -808,18 +806,8 @@ class SELinuxGui():
>          return self.help_show_page()
>
>      def open_combo_menu(self, *args):
> -        if self.popup == 0:
> -            self.popup = 1
> -            location = self.window.get_position()
> -            self.main_selection_window.move(location[0] + 2, location[1] + 65)
> -            self.main_selection_window.show()
> -        else:
> -            self.main_selection_window.hide()
> -            self.popup = 0
> -
> -    def hide_combo_menu(self, *args):
> -        self.main_selection_window.hide()
> -        self.popup = 0
> +        self.main_selection_popover.set_relative_to(self.applications_selection_button)
> +        self.main_selection_popover.popup()
>
>      def set_application_label(self, *args):
>          self.set_application_label = True
> @@ -2335,7 +2323,7 @@ class SELinuxGui():
>              self.active_button = self.network_radio_button
>
>      def clearbuttons(self, clear=True):
> -        self.main_selection_window.hide()
> +        self.main_selection_popover.hide()
>          self.boolean_radio_button.set_visible(False)
>          self.files_radio_button.set_visible(False)
>          self.network_radio_button.set_visible(False)
> diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
> index 0724d6c8caa4..30e7b03f21c2 100644
> --- a/python/sepolicy/sepolicy/sepolicy.glade
> +++ b/python/sepolicy/sepolicy/sepolicy.glade
> @@ -10,11 +10,8 @@
>        <column type="gchararray"/>
>      </columns>
>    </object>
> -  <object class="GtkWindow" id="Main_selection_menu">
> +  <object class="GtkPopover" id="Main_selection_menu">
>      <property name="can_focus">False</property>
> -    <property name="default_width">265</property>
> -    <property name="default_height">100</property>
> -    <property name="decorated">False</property>
>      <child>
>        <object class="GtkBox" id="vbox2">
>          <property name="visible">True</property>
> @@ -53,7 +50,6 @@
>                  <property name="primary_icon_stock">gtk-find</property>
>                  <property name="primary_icon_activatable">False</property>
>                  <property name="secondary_icon_activatable">False</property>
> -                <signal name="activate" handler="on_SELinux_window_configure_event" swapped="no"/>
>                  <signal name="changed" handler="on_completion_entry_changed" swapped="no"/>
>                </object>
>                <packing>
> @@ -306,7 +302,6 @@
>      </columns>
>    </object>
>    <object class="GtkEntryCompletion" id="entrycompletion_obj">
> -    <signal name="match-selected" handler="on_SELinux_window_configure_event" swapped="no"/>
>      <signal name="match-selected" handler="on_completion_entry_changed" swapped="no"/>
>      <signal name="match-selected" handler="on_entrycompletion_obj_match_selected" swapped="no"/>
>    </object>
> @@ -1707,9 +1702,7 @@
>      <property name="window_position">center-always</property>
>      <property name="default_width">650</property>
>      <property name="default_height">420</property>
> -    <signal name="configure-event" handler="on_SELinux_window_configure_event" swapped="no"/>
>      <signal name="delete-event" handler="on_confirmation_close" swapped="no"/>
> -    <signal name="focus-in-event" handler="on_SELinux_window_configure_event" swapped="no"/>
>      <child>
>        <object class="GtkBox" id="vbox1">
>          <property name="visible">True</property>
> --
> 2.38.1
>
