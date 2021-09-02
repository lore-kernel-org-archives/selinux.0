Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21CAC83027
	for <selinux@archiver.kernel.org>; Thu,  2 Sep 2021 16:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B220B610A0
	for <selinux@archiver.kernel.org>; Thu,  2 Sep 2021 16:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhIBQ2l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbhIBQ2k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Sep 2021 12:28:40 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BEDC061575
        for <selinux@vger.kernel.org>; Thu,  2 Sep 2021 09:27:42 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h133so3246628oib.7
        for <selinux@vger.kernel.org>; Thu, 02 Sep 2021 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3UwwjrccCjtRkntz6XfpMVhHPnD2KLgGyyBTmau6V+c=;
        b=a2SLksonWS/2pwxzkEgR+hRDU0kWMV8b5XVpMJxX2W+myFdXJKLPZ4QdvOURy/OInJ
         P2A62sZDIBNJgu6u4pJZehb3u0CYLvRGVvkQ0vSrqk1lPxwjIu0NUGYc79+Pm+tw7MEH
         33C8+Rq0VRNryi6WqbxBn4akL6aRXSOODGZ6KZ6sop81nOaJxg1B7adZJptxqBxe2K66
         aKX+2yvXihbqRQZnm9RonkieP7H9oST86BzyvC4n9r0YLJ+giG/PZY1k7A0g1xzcsgY2
         Uuw/C3ddwNBt/Ot5ZMFkSK7TbacHjtA7yzxUVx6unaoCvjlGyq+UTgZZFvaIafXUKN9c
         OQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3UwwjrccCjtRkntz6XfpMVhHPnD2KLgGyyBTmau6V+c=;
        b=hxmX8jgNUHpOLKoyWTs0ODONur7lrGnvScRRZ84QkylVOxlEIBtioHVgHTv9og4HIH
         uwrfP9CM5qVRQH5VRDR4H8q8FEk+U6Q0o4C4CyV/CiTA6lWpE+HCBI3br/b6Swu2CqjA
         S7dI9Zp/u/QEGT0K2+jF958QNajfm9ibwgQYplACGmGgx31ZcdgiM8om3HNT/nPM/eJe
         A7ryvKaD4iEnWhviUHUlOHeaB+70bA2r9sWXwNkFMpC4OEIC8EmM/ynj48mQ7eLQaIlg
         FBLnIjWLqoWV06HX36dm5eQq+/iXzaJkjlRpfaflcLx0+CPcV5QW2s+SVdVUNOegiDnC
         oRhQ==
X-Gm-Message-State: AOAM5312HodsRdXzOZsBRS19HZS3NrLABaoxUXNk/taq/HbGsleEJByj
        TI6f5XJDsPCPc3tCSPJOPDDweE0jJrJMqoZjSZZiZFuo
X-Google-Smtp-Source: ABdhPJyvZgcAnkG4M09E3vn4rBRox9BDfFZcvhNDu2+BOkprBfh3LLx8rYCPkoC1nLS6lR0dzF1gTTFo+PRebfunukY=
X-Received: by 2002:aca:1b19:: with SMTP id b25mr2815239oib.138.1630600061679;
 Thu, 02 Sep 2021 09:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210825091940.240207-1-mgorny@gentoo.org> <CAP+JOzRjh1km9Y3s3mibXyPopP5ietjmUJBYE6mF2mzt8fKEeQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRjh1km9Y3s3mibXyPopP5ietjmUJBYE6mF2mzt8fKEeQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Sep 2021 12:27:30 -0400
Message-ID: <CAP+JOzSXjGqT8vkyxe7L6zWnpL6csxuf-q_xA_+6AwqcKGZisg@mail.gmail.com>
Subject: Re: [PATCH] python: Import specific modules from setools for less deps
To:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 31, 2021 at 6:38 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Aug 25, 2021 at 5:27 AM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org=
> wrote:
> >
> > Import the setools classes needed for Python bindings from specific
> > setools modules in order to reduce the dependency footprint
> > of the Python bindings.  Importing the top-level module causes all
> > setools modules to be loaded which includes the modules that require
> > networkx.
> >
> > SELinux packages belong to the group of core system packages on Gentoo
> > Linux.  It is desirable to keep the system set as small as possible,
> > and the dependency between setools and networkx seems to be the easiest
> > link to break without major loss of functionality.
> >
> > Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  python/semanage/seobject.py          |  7 ++-
> >  python/sepolicy/sepolicy/__init__.py | 88 ++++++++++++++++------------
> >  2 files changed, 53 insertions(+), 42 deletions(-)
> >
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index 6a14f7b4..21adbf6e 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -31,7 +31,8 @@ import socket
> >  from semanage import *
> >  PROGNAME =3D "policycoreutils"
> >  import sepolicy
> > -import setools
> > +from setools.policyrep import SELinuxPolicy
> > +from setools.typequery import TypeQuery
> >  import ipaddress
> >
> >  try:
> > @@ -1339,7 +1340,7 @@ class ibpkeyRecords(semanageRecords):
> >      def __init__(self, args =3D None):
> >          semanageRecords.__init__(self, args)
> >          try:
> > -            q =3D setools.TypeQuery(setools.SELinuxPolicy(sepolicy.get=
_store_policy(self.store)), attrs=3D["ibpkey_type"])
> > +            q =3D TypeQuery(SELinuxPolicy(sepolicy.get_store_policy(se=
lf.store)), attrs=3D["ibpkey_type"])
> >              self.valid_types =3D sorted(str(t) for t in q.results())
> >          except:
> >              pass
> > @@ -1599,7 +1600,7 @@ class ibendportRecords(semanageRecords):
> >      def __init__(self, args =3D None):
> >          semanageRecords.__init__(self, args)
> >          try:
> > -            q =3D setools.TypeQuery(setools.SELinuxPolicy(sepolicy.get=
_store_policy(self.store)), attrs=3D["ibendport_type"])
> > +            q =3D TypeQuery(SELinuxPolicy(sepolicy.get_store_policy(se=
lf.store)), attrs=3D["ibendport_type"])
> >              self.valid_types =3D set(str(t) for t in q.results())
> >          except:
> >              pass
> > diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sep=
olicy/__init__.py
> > index 9338603e..e8654abb 100644
> > --- a/python/sepolicy/sepolicy/__init__.py
> > +++ b/python/sepolicy/sepolicy/__init__.py
> > @@ -4,7 +4,6 @@
> >
> >  import errno
> >  import selinux
> > -import setools
> >  import glob
> >  import sepolgen.defaults as defaults
> >  import sepolgen.interfaces as interfaces
> > @@ -13,6 +12,17 @@ import os
> >  import re
> >  import gzip
> >
> > +from setools.boolquery import BoolQuery
> > +from setools.portconquery import PortconQuery
> > +from setools.policyrep import SELinuxPolicy
> > +from setools.objclassquery import ObjClassQuery
> > +from setools.rbacrulequery import RBACRuleQuery
> > +from setools.rolequery import RoleQuery
> > +from setools.terulequery import TERuleQuery
> > +from setools.typeattrquery import TypeAttributeQuery
> > +from setools.typequery import TypeQuery
> > +from setools.userquery import UserQuery
> > +
> >  PROGNAME =3D "policycoreutils"
> >  try:
> >      import gettext
> > @@ -168,7 +178,7 @@ def policy(policy_file):
> >      global _pol
> >
> >      try:
> > -        _pol =3D setools.SELinuxPolicy(policy_file)
> > +        _pol =3D SELinuxPolicy(policy_file)
> >      except:
> >          raise ValueError(_("Failed to read %s policy file") % policy_f=
ile)
> >
> > @@ -188,7 +198,7 @@ def info(setype, name=3DNone):
> >          init_policy()
> >
> >      if setype =3D=3D TYPE:
> > -        q =3D setools.TypeQuery(_pol)
> > +        q =3D TypeQuery(_pol)
> >          q.name =3D name
> >          results =3D list(q.results())
> >
> > @@ -206,7 +216,7 @@ def info(setype, name=3DNone):
> >          } for x in results)
> >
> >      elif setype =3D=3D ROLE:
> > -        q =3D setools.RoleQuery(_pol)
> > +        q =3D RoleQuery(_pol)
> >          if name:
> >              q.name =3D name
> >
> > @@ -217,7 +227,7 @@ def info(setype, name=3DNone):
> >          } for x in q.results())
> >
> >      elif setype =3D=3D ATTRIBUTE:
> > -        q =3D setools.TypeAttributeQuery(_pol)
> > +        q =3D TypeAttributeQuery(_pol)
> >          if name:
> >              q.name =3D name
> >
> > @@ -227,7 +237,7 @@ def info(setype, name=3DNone):
> >          } for x in q.results())
> >
> >      elif setype =3D=3D PORT:
> > -        q =3D setools.PortconQuery(_pol)
> > +        q =3D PortconQuery(_pol)
> >          if name:
> >              ports =3D [int(i) for i in name.split("-")]
> >              if len(ports) =3D=3D 2:
> > @@ -251,7 +261,7 @@ def info(setype, name=3DNone):
> >          } for x in q.results())
> >
> >      elif setype =3D=3D USER:
> > -        q =3D setools.UserQuery(_pol)
> > +        q =3D UserQuery(_pol)
> >          if name:
> >              q.name =3D name
> >
> > @@ -268,7 +278,7 @@ def info(setype, name=3DNone):
> >          } for x in q.results())
> >
> >      elif setype =3D=3D BOOLEAN:
> > -        q =3D setools.BoolQuery(_pol)
> > +        q =3D BoolQuery(_pol)
> >          if name:
> >              q.name =3D name
> >
> > @@ -278,7 +288,7 @@ def info(setype, name=3DNone):
> >          } for x in q.results())
> >
> >      elif setype =3D=3D TCLASS:
> > -        q =3D setools.ObjClassQuery(_pol)
> > +        q =3D ObjClassQuery(_pol)
> >          if name:
> >              q.name =3D name
> >
> > @@ -372,11 +382,11 @@ def search(types, seinfo=3DNone):
> >          tertypes.append(DONTAUDIT)
> >
> >      if len(tertypes) > 0:
> > -        q =3D setools.TERuleQuery(_pol,
> > -                                ruletype=3Dtertypes,
> > -                                source=3Dsource,
> > -                                target=3Dtarget,
> > -                                tclass=3Dtclass)
> > +        q =3D TERuleQuery(_pol,
> > +                        ruletype=3Dtertypes,
> > +                        source=3Dsource,
> > +                        target=3Dtarget,
> > +                        tclass=3Dtclass)
> >
> >          if PERMS in seinfo:
> >              q.perms =3D seinfo[PERMS]
> > @@ -385,11 +395,11 @@ def search(types, seinfo=3DNone):
> >
> >      if TRANSITION in types:
> >          rtypes =3D ['type_transition', 'type_change', 'type_member']
> > -        q =3D setools.TERuleQuery(_pol,
> > -                                ruletype=3Drtypes,
> > -                                source=3Dsource,
> > -                                target=3Dtarget,
> > -                                tclass=3Dtclass)
> > +        q =3D TERuleQuery(_pol,
> > +                        ruletype=3Drtypes,
> > +                        source=3Dsource,
> > +                        target=3Dtarget,
> > +                        tclass=3Dtclass)
> >
> >          if PERMS in seinfo:
> >              q.perms =3D seinfo[PERMS]
> > @@ -398,11 +408,11 @@ def search(types, seinfo=3DNone):
> >
> >      if ROLE_ALLOW in types:
> >          ratypes =3D ['allow']
> > -        q =3D setools.RBACRuleQuery(_pol,
> > -                                  ruletype=3Dratypes,
> > -                                  source=3Dsource,
> > -                                  target=3Dtarget,
> > -                                  tclass=3Dtclass)
> > +        q =3D RBACRuleQuery(_pol,
> > +                          ruletype=3Dratypes,
> > +                          source=3Dsource,
> > +                          target=3Dtarget,
> > +                          tclass=3Dtclass)
> >
> >          for r in q.results():
> >              toret.append({'source': str(r.source),
> > @@ -720,11 +730,11 @@ def get_all_entrypoints():
> >
> >
> >  def get_entrypoint_types(setype):
> > -    q =3D setools.TERuleQuery(_pol,
> > -                            ruletype=3D[ALLOW],
> > -                            source=3Dsetype,
> > -                            tclass=3D["file"],
> > -                            perms=3D["entrypoint"])
> > +    q =3D TERuleQuery(_pol,
> > +                    ruletype=3D[ALLOW],
> > +                    source=3Dsetype,
> > +                    tclass=3D["file"],
> > +                    perms=3D["entrypoint"])
> >      return [str(x.target) for x in q.results() if x.source =3D=3D sety=
pe]
> >
> >
> > @@ -739,10 +749,10 @@ def get_init_transtype(path):
> >
> >
> >  def get_init_entrypoint(transtype):
> > -    q =3D setools.TERuleQuery(_pol,
> > -                            ruletype=3D["type_transition"],
> > -                            source=3D"init_t",
> > -                            tclass=3D["process"])
> > +    q =3D TERuleQuery(_pol,
> > +                    ruletype=3D["type_transition"],
> > +                    source=3D"init_t",
> > +                    tclass=3D["process"])
> >      entrypoints =3D []
> >      for i in q.results():
> >          try:
> > @@ -754,10 +764,10 @@ def get_init_entrypoint(transtype):
> >      return entrypoints
> >
> >  def get_init_entrypoints_str():
> > -    q =3D setools.TERuleQuery(_pol,
> > -                            ruletype=3D["type_transition"],
> > -                            source=3D"init_t",
> > -                            tclass=3D["process"])
> > +    q =3D TERuleQuery(_pol,
> > +                    ruletype=3D["type_transition"],
> > +                    source=3D"init_t",
> > +                    tclass=3D["process"])
> >      entrypoints =3D {}
> >      for i in q.results():
> >          try:
> > @@ -837,7 +847,7 @@ def get_all_role_allows():
> >          return role_allows
> >      role_allows =3D {}
> >
> > -    q =3D setools.RBACRuleQuery(_pol, ruletype=3D[ALLOW])
> > +    q =3D RBACRuleQuery(_pol, ruletype=3D[ALLOW])
> >      for r in q.results():
> >          src =3D str(r.source)
> >          tgt =3D str(r.target)
> > @@ -923,7 +933,7 @@ def get_all_roles():
> >      if not _pol:
> >          init_policy()
> >
> > -    q =3D setools.RoleQuery(_pol)
> > +    q =3D RoleQuery(_pol)
> >      roles =3D [str(x) for x in q.results() if str(x) !=3D "object_r"]
> >      return roles
> >
> > --
> > 2.33.0
> >
