Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AF6C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 22:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiLPWC6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLPWC5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 17:02:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBC418C
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 14:02:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s5so5438853edc.12
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 14:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IuHYz7XpF4oqFxdS9QIJ9TwHom2Bu41GpLsctPyhvks=;
        b=WO9Jst0t3rTg9nHxzC7G0lx+imnyp8O51cUtnrmxynLWjFvMfy5WHu/8QBkq9VZBiR
         jQ1yu5LolnfgDLJgaf0VUiUl5rK5u8Z4+emfvl2cjIqp7F2bYNfyQu5QxcOJzWFplKBR
         CxDqMkLGg/BNyq7n3GWGLzmpsXaOqNyMDw2dI2PyrdQwO7KE04bPOtZewJrnBHbkHaFl
         0Q9JA6vCX4e7h69rNiuF5b6rmt5YNIuCqrddMH7x31nxwhIZRuZ/WKmAwN7mBrU8Cqpg
         dOqLNzSULX9wxojhIKRwxXVRN8aB/NymuY674NhdLAZrleE0R3NK2MY+/IXGQKdVNmhf
         AxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuHYz7XpF4oqFxdS9QIJ9TwHom2Bu41GpLsctPyhvks=;
        b=uPl/UAcFN8oFJRcUkKNEykJcK6FplAkyvtHdv9EzEJl2rTRhqa91QWsaCf6eXfKNSb
         8UbTcDucrY5wJ+TyvaF3sppis2TFSBnYZjUAS4VT95KUfjJHYMKMGhdGIIF1MkjDtSoc
         DXfBAhPEGs5x/7aDxz20XCXtHjMR4XTyoN5dRDZTB6Gv+wV1i656ICLuGQ1wm0uq4t65
         Hcjh70xlB8UwA9M5kxM1dn6rvCGaksLmeKGVv+ga+F3JSAYfoKBG6CvXqeLqRNYF+Vcx
         wdlmkKfxj/AX0O5ZYUy++m2SQOl03+frTEFMt8/sCkHR4xIm9BB/WVuWzdP9shbkJUK7
         QQ8A==
X-Gm-Message-State: ANoB5pmPfJhaSXfQ8fyi/ojLuP7iXWNI+LbaFJ4OVS4OsxYrbZ7ZyPev
        38PC/aTZ+A/yBJJ7SB49bQtfp94nMvpLx2uTZ0o=
X-Google-Smtp-Source: AA0mqf5OaxTwKFnag6KcRjvN2f8eIdUpoAiBj0BIu/1BLzNS6DhtOcQQnL4vCm6U6CtQdgkK6hkupuK7xntDxY4UYPE=
X-Received: by 2002:a50:fd08:0:b0:46c:7117:3cae with SMTP id
 i8-20020a50fd08000000b0046c71173caemr22186048eds.195.1671228174547; Fri, 16
 Dec 2022 14:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20221208194335.479739-1-lautrbach@redhat.com> <CAP+JOzQAsGdps1=RMJQMerJ-SQ=VWeWOCV4fOhtog3g6j1kYGQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQAsGdps1=RMJQMerJ-SQ=VWeWOCV4fOhtog3g6j1kYGQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 17:02:43 -0500
Message-ID: <CAP+JOzSBs6X06UOR8x4DMgXB4qE9fU9DhX9NMmrA2vH-_V4qDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sepolicy: Switch main selection menu to GtkPopover
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 16, 2022 at 4:53 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Dec 8, 2022 at 2:54 PM Petr Lautrbach <lautrbach@redhat.com> wrote:
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/206
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>
These two patches have been merged.
Thanks,
Jim

> > ---
> >  python/sepolicy/sepolicy/gui.py         | 20 ++++----------------
> >  python/sepolicy/sepolicy/sepolicy.glade |  9 +--------
> >  2 files changed, 5 insertions(+), 24 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> > index c8f33f522a2d..53f3c6148b58 100644
> > --- a/python/sepolicy/sepolicy/gui.py
> > +++ b/python/sepolicy/sepolicy/gui.py
> > @@ -135,9 +135,8 @@ class SELinuxGui():
> >          builder.add_from_file(glade_file)
> >          self.outer_notebook = builder.get_object("outer_notebook")
> >          self.window = builder.get_object("SELinux_window")
> > -        self.main_selection_window = builder.get_object("Main_selection_menu")
> > +        self.main_selection_popover = builder.get_object("Main_selection_menu")
> >          self.main_advanced_label = builder.get_object("main_advanced_label")
> > -        self.popup = 0
> >          self.applications_selection_button = builder.get_object("applications_selection_button")
> >          self.revert_button = builder.get_object("Revert_button")
> >          self.busy_cursor = Gdk.Cursor(Gdk.CursorType.WATCH)
> > @@ -531,7 +530,6 @@ class SELinuxGui():
> >          dic = {
> >              "on_combo_button_clicked": self.open_combo_menu,
> >              "on_disable_ptrace_toggled": self.on_disable_ptrace,
> > -            "on_SELinux_window_configure_event": self.hide_combo_menu,
> >              "on_entrycompletion_obj_match_selected": self.set_application_label,
> >              "on_filter_changed": self.get_filter_data,
> >              "on_save_changes_file_equiv_clicked": self.update_to_file_equiv,
> > @@ -808,18 +806,8 @@ class SELinuxGui():
> >          return self.help_show_page()
> >
> >      def open_combo_menu(self, *args):
> > -        if self.popup == 0:
> > -            self.popup = 1
> > -            location = self.window.get_position()
> > -            self.main_selection_window.move(location[0] + 2, location[1] + 65)
> > -            self.main_selection_window.show()
> > -        else:
> > -            self.main_selection_window.hide()
> > -            self.popup = 0
> > -
> > -    def hide_combo_menu(self, *args):
> > -        self.main_selection_window.hide()
> > -        self.popup = 0
> > +        self.main_selection_popover.set_relative_to(self.applications_selection_button)
> > +        self.main_selection_popover.popup()
> >
> >      def set_application_label(self, *args):
> >          self.set_application_label = True
> > @@ -2335,7 +2323,7 @@ class SELinuxGui():
> >              self.active_button = self.network_radio_button
> >
> >      def clearbuttons(self, clear=True):
> > -        self.main_selection_window.hide()
> > +        self.main_selection_popover.hide()
> >          self.boolean_radio_button.set_visible(False)
> >          self.files_radio_button.set_visible(False)
> >          self.network_radio_button.set_visible(False)
> > diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
> > index 0724d6c8caa4..30e7b03f21c2 100644
> > --- a/python/sepolicy/sepolicy/sepolicy.glade
> > +++ b/python/sepolicy/sepolicy/sepolicy.glade
> > @@ -10,11 +10,8 @@
> >        <column type="gchararray"/>
> >      </columns>
> >    </object>
> > -  <object class="GtkWindow" id="Main_selection_menu">
> > +  <object class="GtkPopover" id="Main_selection_menu">
> >      <property name="can_focus">False</property>
> > -    <property name="default_width">265</property>
> > -    <property name="default_height">100</property>
> > -    <property name="decorated">False</property>
> >      <child>
> >        <object class="GtkBox" id="vbox2">
> >          <property name="visible">True</property>
> > @@ -53,7 +50,6 @@
> >                  <property name="primary_icon_stock">gtk-find</property>
> >                  <property name="primary_icon_activatable">False</property>
> >                  <property name="secondary_icon_activatable">False</property>
> > -                <signal name="activate" handler="on_SELinux_window_configure_event" swapped="no"/>
> >                  <signal name="changed" handler="on_completion_entry_changed" swapped="no"/>
> >                </object>
> >                <packing>
> > @@ -306,7 +302,6 @@
> >      </columns>
> >    </object>
> >    <object class="GtkEntryCompletion" id="entrycompletion_obj">
> > -    <signal name="match-selected" handler="on_SELinux_window_configure_event" swapped="no"/>
> >      <signal name="match-selected" handler="on_completion_entry_changed" swapped="no"/>
> >      <signal name="match-selected" handler="on_entrycompletion_obj_match_selected" swapped="no"/>
> >    </object>
> > @@ -1707,9 +1702,7 @@
> >      <property name="window_position">center-always</property>
> >      <property name="default_width">650</property>
> >      <property name="default_height">420</property>
> > -    <signal name="configure-event" handler="on_SELinux_window_configure_event" swapped="no"/>
> >      <signal name="delete-event" handler="on_confirmation_close" swapped="no"/>
> > -    <signal name="focus-in-event" handler="on_SELinux_window_configure_event" swapped="no"/>
> >      <child>
> >        <object class="GtkBox" id="vbox1">
> >          <property name="visible">True</property>
> > --
> > 2.38.1
> >
