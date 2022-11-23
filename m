Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4384C433FE
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 15:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbiKWPFw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbiKWPFp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 10:05:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16F96B229
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 07:05:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f7so25242986edc.6
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 07:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ksi0BFh9RDmrrIAWUY13V3O3o6IIplvXlKCu1xjeDjg=;
        b=Ga0XGwBmyVU2AL/AxXDxOrHeGkRqajBQSaj/jU1duAhwVIivVde3jdiV4l8z65jy9L
         PzbxFPoQaibZAX+PQL+3a2+ggfWWyaV5RyF/db9E/SB2rO+ydApSplrNjscWz8FRJyEK
         JcJt4OaCkd9Tgn+0v1n0oVfTn5uc7k0Fac1MNzz9IUQ4eNgpS9QtNBe48jm7bheEFCV9
         pbFtMDSkL3W3+dEkOlDqwHoJB9VtfB3wR8C5ncIXNYO716XQ90Nhl8rHCUOvjV2HNouf
         SxZWc41rwSa8OReUi6+4lGbM2+lBJ3kyQNAE9107I9KUmRqB8ntFs6YEsUrfZOPbepXz
         0+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ksi0BFh9RDmrrIAWUY13V3O3o6IIplvXlKCu1xjeDjg=;
        b=B6DntlSW/weAEbVH0F3SKMOgr3hQIMuf7Ag/Bt+BuRknnmmeG4gSlWpH/8wmOH3rDh
         uK3EqUBgMR0g6HVroSah9c5O48Gyfk0mdhhTo5Bh3poWKtkj09tZSLND8vl1MCDY/K0g
         Y1qAu5rNWPkWuMYHjTOe0szyPhNPZzJvgRs3iZLSD78IwYE0ejJG7fHbdElstamxGr3+
         QUGho+43NxLFQL4+o+rEkzSHDTOQ9h6VzuTCweMuos6V+XjnR/S101Fe1qnRWb5N2fNu
         2fWDvcnFBCgNqBjQIwbPXQGxKAexznD5hb0NXEviPn5UD79SiBzKd34LldNUaMNAu+aL
         f2og==
X-Gm-Message-State: ANoB5pk2WZMJnO15WSgdqDizK9RblNktI1Rcr8X2b+W+YuEp8A2BTRhT
        x4yOjjv6RaZ3iweACVCrpXIzCw3umjbmEU0BvYdwWfCt
X-Google-Smtp-Source: AA0mqf7d4GuqjgoI3WAY8v1z7p++dUQmfB2wqGSZ4kX9sGKfjvHlM0Mj7FTYu/8HE0PYK3j2qXTX6OxBA624DG6q8C0=
X-Received: by 2002:a05:6402:2b87:b0:45b:c731:b683 with SMTP id
 fj7-20020a0564022b8700b0045bc731b683mr27138958edb.251.1669215942453; Wed, 23
 Nov 2022 07:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20221121110125.525391-1-lautrbach@redhat.com> <CAP+JOzSxJJs9YnAvHSF5B-HRUhT--8ynX6etukXsVKo-j+BTLw@mail.gmail.com>
In-Reply-To: <CAP+JOzSxJJs9YnAvHSF5B-HRUhT--8ynX6etukXsVKo-j+BTLw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 23 Nov 2022 10:05:31 -0500
Message-ID: <CAP+JOzSSsccfHwV39+qZ09cSJ7EG8c-byJY5T=+-A1Swcwo9-g@mail.gmail.com>
Subject: Re: [PATCH] Fix E275 missing whitespace after keyword
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 21, 2022 at 9:24 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Nov 21, 2022 at 6:06 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
> >
> > Fixes:
> >   ./gui/polgengui.py:484:18: E275 missing whitespace after keyword
> >   ./gui/polgengui.py:530:18: E275 missing whitespace after keyword
> >   ./python/sepolgen/src/sepolgen/policygen.py:327:19: E275 missing whitespace after keyword
> >   ./python/sepolgen/src/sepolgen/policygen.py:329:11: E275 missing whitespace after keyword
> >   ./python/sepolicy/sepolicy/__init__.py:453:15: E275 missing whitespace after keyword
> >   ./python/sepolicy/sepolicy/generate.py:1351:28: E275 missing whitespace after keyword
> >   ./python/sepolicy/sepolicy/generate.py:1353:28: E275 missing whitespace after keyword
> >   ./python/sepolicy/sepolicy/gui.py:638:24: E275 missing whitespace after keyword
> >   ./python/sepolicy/sepolicy/gui.py:863:23: E275 missing whitespace after keyword
> >   ./python/sepolicy/sepolicy/gui.py:2177:16: E275 missing whitespace after keyword
> >   ./sandbox/sandbox:114:7: E275 missing whitespace after keyword
> >   ./sandbox/sandbox:134:11: E275 missing whitespace after keyword
> >   ./sandbox/sandbox:136:7: E275 missing whitespace after keyword
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  gui/polgengui.py                          | 4 ++--
> >  python/sepolgen/src/sepolgen/policygen.py | 4 ++--
> >  python/sepolicy/sepolicy/__init__.py      | 4 ++--
> >  python/sepolicy/sepolicy/generate.py      | 4 ++--
> >  python/sepolicy/sepolicy/gui.py           | 6 +++---
> >  sandbox/sandbox                           | 6 +++---
> >  6 files changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/gui/polgengui.py b/gui/polgengui.py
> > index 7a3ecd50c91c..16116ba68b61 100644
> > --- a/gui/polgengui.py
> > +++ b/gui/polgengui.py
> > @@ -481,7 +481,7 @@ class childWindow:
> >              my_policy = sepolicy.generate.policy(self.get_name(), self.get_type())
> >
> >              iter = self.boolean_store.get_iter_first()
> > -            while(iter):
> > +            while iter:
> >                  my_policy.add_boolean(self.boolean_store.get_value(iter, 0), self.boolean_store.get_value(iter, 1))
> >                  iter = self.boolean_store.iter_next(iter)
> >
> > @@ -527,7 +527,7 @@ class childWindow:
> >              my_policy.set_out_udp(self.out_udp_all_checkbutton.get_active(), self.out_udp_entry.get_text())
> >
> >              iter = self.store.get_iter_first()
> > -            while(iter):
> > +            while iter:
> >                  if self.store.get_value(iter, 1) == FILE:
> >                      my_policy.add_file(self.store.get_value(iter, 0))
> >                  else:
> > diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/src/sepolgen/policygen.py
> > index 8f0ce26e4dc7..183b41a93d50 100644
> > --- a/python/sepolgen/src/sepolgen/policygen.py
> > +++ b/python/sepolgen/src/sepolgen/policygen.py
> > @@ -324,9 +324,9 @@ def call_interface(interface, av):
> >              ifcall.args.append(av.obj_class)
> >          else:
> >              print(params[i].type)
> > -            assert(0)
> > +            assert 0
> >
> > -    assert(len(ifcall.args) > 0)
> > +    assert len(ifcall.args) > 0
> >
> >      return ifcall
> >
> > diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> > index 9c3caa05b80b..05888e5cb94a 100644
> > --- a/python/sepolicy/sepolicy/__init__.py
> > +++ b/python/sepolicy/sepolicy/__init__.py
> > @@ -450,9 +450,9 @@ def get_conditionals(src, dest, tclass, perm):
> >                  tlist.append(tdict)
> >                  tdict = {}
> >      except KeyError:
> > -        return(tlist)
> > +        return tlist
> >
> > -    return (tlist)
> > +    return tlist
> >
> >
> >  def get_conditionals_format_text(cond):
> > diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
> > index 3717d5d4ed78..b6df3e91160b 100644
> > --- a/python/sepolicy/sepolicy/generate.py
> > +++ b/python/sepolicy/sepolicy/generate.py
> > @@ -1346,9 +1346,9 @@ allow %s_t %s_t:%s_socket name_%s;
> >              if len(temp_dirs) != 0:
> >                  for i in temp_dirs:
> >                      if i in self.dirs.keys():
> > -                        del(self.dirs[i])
> > +                        del self.dirs[i]
> >                      elif i in self.files.keys():
> > -                        del(self.files[i])
> > +                        del self.files[i]
> >                      else:
> >                          continue
> >
> > diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> > index 335be582b668..c8f33f522a2d 100644
> > --- a/python/sepolicy/sepolicy/gui.py
> > +++ b/python/sepolicy/sepolicy/gui.py
> > @@ -635,7 +635,7 @@ class SELinuxGui():
> >          for k in self.cur_dict:
> >              for j in self.cur_dict[k]:
> >                  if i == ctr:
> > -                    del(self.cur_dict[k][j])
> > +                    del self.cur_dict[k][j]
> >                      return
> >                  i += 1
> >
> > @@ -860,7 +860,7 @@ class SELinuxGui():
> >                      if val is True or val is False or val is None:
> >                          continue
> >                      # Returns true if filter_txt exists within the val
> > -                    if(val.find(self.filter_txt) != -1 or val.lower().find(self.filter_txt) != -1):
> > +                    if val.find(self.filter_txt) != -1 or val.lower().find(self.filter_txt) != -1:
> >                          return True
> >                  except (AttributeError, TypeError):
> >                      pass
> > @@ -2174,7 +2174,7 @@ class SELinuxGui():
> >          model.set_value(iter, 0, not model.get_value(iter, 0))
> >          active = model.get_value(iter, 0)
> >          if name in self.cur_dict["boolean"]:
> > -            del(self.cur_dict["boolean"][name])
> > +            del self.cur_dict["boolean"][name]
> >          else:
> >              self.cur_dict["boolean"][name] = {"active": active}
> >          self.new_updates()
> > diff --git a/sandbox/sandbox b/sandbox/sandbox
> > index 770807345858..a2762a7d215a 100644
> > --- a/sandbox/sandbox
> > +++ b/sandbox/sandbox
> > @@ -111,7 +111,7 @@ def copyfile(file, srcdir, dest):
> >
> >  def savefile(new, orig, X_ind):
> >      copy = False
> > -    if(X_ind):
> > +    if X_ind:
> >          import gi
> >          gi.require_version('Gtk', '3.0')
> >          from gi.repository import Gtk
> > @@ -131,9 +131,9 @@ def savefile(new, orig, X_ind):
> >          except NameError:
> >              pass
> >          ans = input(_("Do you want to save changes to '%s' (y/N): ") % orig)
> > -        if(re.match(_("[yY]"), ans)):
> > +        if re.match(_("[yY]"), ans):
> >              copy = True
> > -    if(copy):
> > +    if copy:
> >          shutil.copy2(new, orig)
> >
> >
> > --
> > 2.38.1
> >
