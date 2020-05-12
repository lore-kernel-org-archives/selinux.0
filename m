Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B3DCA90AF
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FA92064A
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6Aq7hCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgELTsu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 15:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELTsu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 15:48:50 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3F6C061A0C
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 12:48:50 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z25so11504066otq.13
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsliJWINiVY8goC/XtZoZKY+umh6VN0chu/fmxZPwuc=;
        b=f6Aq7hCgxmWW+8Rr8IaBezF9pCrJHjXqd8rc4xJxYJ/tyX67PHqfjwp4H0Qovums8O
         pawJUFwT5VHdVbrraWxv62Ahw5EeNYLxbe0v+krOhVnOA9I2SBRKG5bMkv+e9BPziyWG
         zNnc9p340Pw8WEURj0B4VfDADQHgUrSm2ZYWSTnEURkkWewPfuLMnho3wQwBJRhB3O8y
         Y5PK0H3xEWVmmv8Y4fRzGv/X+PuoiNr3dcnMccttBqpwvU6ccZCaEQUVJwQlGxf9Hv1i
         6egc3xCeNsusn/bGOuxj+UiOmsVSiyqZPapyJFcU8gFPuaMiOzWFgpN1LESBKv3xvMaz
         juzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsliJWINiVY8goC/XtZoZKY+umh6VN0chu/fmxZPwuc=;
        b=aZdWlPMzd2USA8aa6KnXkA0rkWU1PSmw8b1EEe6M1hRzzY5Tci/p8ekOKPPjjtlnJW
         3JSGhQZYqeA/jwbxZxG6xCT0hQRgxk5plmWuYo6Y4HyL55dCvm+u1dIbI1vR6eGWcxFG
         ryjRsrnsVHe5jREu9QwNee3N3tHFF/9gPSWiXFHK3I4urcAqEj0olV9ogWWjdnE3k1kv
         JG/H+UXwS4Xo8OFMta2elaKc408UQeXg23JQSW4hbUUCqgIKfVEtzkfnlq4bV8nges33
         QyQdFKAWt0GBymUz2xQDQFzxG++fPiBRZInY//DETBppUGyZnTwnJKf9XfojI3BbSHJY
         hy1A==
X-Gm-Message-State: AGi0PuZFfl05G/MP4zw/z79WIKMwI5ci/6Rck6h+AQoLV5zI0nJIWg8w
        NImmcbJasTvIbNoAGl/jTp2m06sjavYjK8eyY/uFKHgz
X-Google-Smtp-Source: APiQypKLzIPw5OQs5CggzuEhX9io5I0iiHu/x56OBu0DmwmO3iVpPwp0nD0XqXOoekbLnGXP6OaRd+m0KEKbWqijLrA=
X-Received: by 2002:a9d:6c88:: with SMTP id c8mr3500491otr.59.1589312929717;
 Tue, 12 May 2020 12:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200305135337.113248-1-omosnace@redhat.com> <20200511122703.GA26404@workstation>
 <CAP+JOzSep5+YSZm68ru2NOOoPUhazE3dy9x6t1AqUJxfgDNrJQ@mail.gmail.com>
 <CAP+JOzTUiNhyPPVOm-cFqNzPUGmQKmGvR9n_yNbTatQ8tYnJng@mail.gmail.com>
 <CAEjxPJ7Px-LkZPGk_Oe=G6HZP_Yu1a=nWDBPc6i=oNOMf0nG9A@mail.gmail.com>
 <CAP+JOzTX3tFUAeheUUDB4br+nLhqCUP+EPY_XuTugDoqpwNGVg@mail.gmail.com>
 <20200512171605.GK108209@workstation> <CAEjxPJ7f-N7uOOjcrYUJe73-WaikP40O=ibi43tYbsiJ6M1m7Q@mail.gmail.com>
 <CAP+JOzQ74-t40KLCt6QjJK_HTgR-Lq+GfkNAmKjPAEi0JGPgEg@mail.gmail.com>
In-Reply-To: <CAP+JOzQ74-t40KLCt6QjJK_HTgR-Lq+GfkNAmKjPAEi0JGPgEg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 May 2020 15:48:37 -0400
Message-ID: <CAP+JOzQpCbOtxv_aiBY-=Cz4sGnC4T2bRUSd91P7eCsn7rR1+g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] libsepol/cil: raise default attrs_expand_size to 2
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 12, 2020 at 3:33 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, May 12, 2020 at 1:27 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, May 12, 2020 at 1:16 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > > On Mon, May 11, 2020 at 03:01:06PM -0400, James Carter wrote:
> > > > On Mon, May 11, 2020 at 2:09 PM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Mon, May 11, 2020 at 2:03 PM James Carter <jwcart2@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, May 11, 2020 at 9:25 AM James Carter <jwcart2@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, May 11, 2020 at 8:27 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Mar 05, 2020 at 02:53:37PM +0100, Ondrej Mosnacek wrote:
> > > > > > > > > The value attrs_expand_size == 1 removes all empty attributes, but it
> > > > > > > > > also makes sense to expand all attributes that have only one type. This
> > > > > > > > > removes some redundant rules (there is sometimes the same rule for the
> > > > > > > > > type and the attribute) and reduces the number of attributes that the
> > > > > > > > > kernel has to go through when looking up rules.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > v2: fix typos (Tne -> The; cointains -> contains)
> > > > > > > > >
> > > > > > > > >  libsepol/cil/src/cil.c | 3 ++-
> > > > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > > > > > > > > index d222ad3a..c010ca2a 100644
> > > > > > > > > --- a/libsepol/cil/src/cil.c
> > > > > > > > > +++ b/libsepol/cil/src/cil.c
> > > > > > > > > @@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
> > > > > > > > >       (*db)->disable_dontaudit = CIL_FALSE;
> > > > > > > > >       (*db)->disable_neverallow = CIL_FALSE;
> > > > > > > > >       (*db)->attrs_expand_generated = CIL_FALSE;
> > > > > > > > > -     (*db)->attrs_expand_size = 1;
> > > > > > > > > +     /* 2 == remove attributes that contain none or just 1 type */
> > > > > > > > > +     (*db)->attrs_expand_size = 2;
> > > > > > > > >       (*db)->preserve_tunables = CIL_FALSE;
> > > > > > > > >       (*db)->handle_unknown = -1;
> > > > > > > > >       (*db)->mls = -1;
> > > > > > > > > --
> > > > > > > > > 2.24.1
> > > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > This patch broke `semanage node -l` on Fedora [1]
> > > > > > > >
> > > > > > > > :: [ 21:25:25 ] :: [  BEGIN   ] :: Running 'make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 test'
> > > > > > > > ...
> > > > > > > > test_list (__main__.SemanageTests) ... Traceback (most recent call last):
> > > > > > > >   File "/usr/sbin/semanage", line 967, in <module>
> > > > > > > >     do_parser()
> > > > > > > >   File "/usr/sbin/semanage", line 946, in do_parser
> > > > > > > >     args.func(args)
> > > > > > > >   File "/usr/sbin/semanage", line 649, in handleNode
> > > > > > > >     OBJECT = object_dict['node'](args)
> > > > > > > >   File "/usr/lib/python3.8/site-packages/seobject.py", line 1849, in __init__
> > > > > > > >     self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
> > > > > > > > IndexError: list index out of range
> > > > > > > >
> > > > > > > > While the `IndexError: list index out of range` error can be simply fixed, it
> > > > > > > > uncovered the problem that semanage uses attibutes to list certain records -
> > > > > > > > node_type, port_type, file_type, device_node, ... and these attributes can disappear when
> > > > > > > > there's only 1 type assigned.
> > > > > > > >
> > > > > > > > I guess it should be reverted as there's no other way how to find out that a
> > > > > > > > type node_t is node_type.
> > > > > > > >
> > > > > > > > [1] https://jenkins-continuous-infra.apps.ci.centos.org/job/fedora-rawhide-pr-pipeline/3462/artifact/package-tests/logs/FAIL-upstream-err.log
> > > > > > > >
> > > > > >
> > > > > > I see now.  python/semanage/seobject.py and
> > > > > > python/semanage/semanage-bash-completion.sh both assume that node_type
> > > > > > is always defined as an attribute in a policy. There seems to be quite
> > > > > > a lot that is assumed about policy in the python directory.
> > > > > >
> > > > > > This is not a bug in CIL or libsepol. Ideally the tests should have
> > > > > > their own policy and the python code should gracefully handle the
> > > > > > situation when its assumptions are wrong. If we need to revert this
> > > > > > patch in the short-term than I am ok with that.
> > > > >
> > > > > We can mark these attributes explicitly in policy to prevent their
> > > > > expansion, right?  So while we cannot make this change right now
> > > > > without breaking compatibility with selinux userspace tools (not just
> > > > > tests), we could start marking these attributes on which the tools
> > > > > depend in policy and then later we can re-apply this?
> > > >
> > > > Yes, we can add the rule "expandattribute node_type false;" in policy
> > > > for node_type and any other attributes that are required to exist.
> > > >
> > >
> > >
> > > It doesn't seem to be propagated to cil:
> > >
> > > # cat mypolicy.te
> > > policy_module(mypolicy,1.0)
> > >
> > > type myapp_t;
> > > type myapp_log_t;
> > >
> > > attribute myattribute;
> > > expandattribute myattribute false;
> > > typeattribute myapp_t myattribute;
> > >
> > > allow myattribute myapp_log_t:file read;
> > >
> > > # make -f /usr/share/selinux/devel/Makefile mypolicy.pp
> > > make: 'mypolicy.pp' is up to date.
> > >
> > > # /usr/libexec/selinux/hll/pp mypolicy.pp
> > > (type myapp_t)
> > > (roletype object_r myapp_t)
> > > (type myapp_log_t)
> > > (roletype object_r myapp_log_t)
> > > (typeattribute myattribute)
> > > (typeattributeset myattribute (myapp_t ))
> > > (roleattributeset cil_gen_require system_r)
> > > (allow myattribute myapp_log_t (file (read)))
> > >
> > >
> > > But it works with mypolicy.cil which contains:
> > > (expandtypeattribute myattribute false)
> > >
> > >
> > > I'm not really experienced in writing policy but I still find the behaviour
> > > confusing.
> > > It's not only about `semanage`, you can hit this using `sesearch` as well, e.g.
> > > before policy is rebuilt with new libsepol, `sesearch -A -t node_type` finds
> > > about 535 rules with node_type, then you rebuild policy and it's 0. But if
> > > assign node_type to another type, it's again more than 536.
> > >
> > > For this particular attribute we can/should use `expandtypeattribute` but should
> > > be this expression used every time you have an attribute assigned to only 1 type?
> > >
> > >
> > > If it stays as it is, it definitely needs to be part of release notes.
> >
> > I think we should revert the change prior to release since it breaks
> > selinux userspace.
> > We'll need to fix the separate bug regarding pp to cil conversion that
> > is losing the expandattribute statement that you mentioned above.
> > And we should start annotating all attributes in policy on which
> > selinux userspace depends with
> > explicit expandattribute false statements to ensure that they are not
> > optimized away in the future.
>
> Looking at libsepol, the issue is that the expand attribute
> information is not saved in any of the binary formats. Converting a
> policy.conf to a CIL file preserves the expand attribute statement.
>
> So we need to revert the change, update binary formats, annotate
> attributes that always need to be kept, and then we can reapply the
> change.
>
I guess we can just add a CIL module with the needed
expandtypeattribute statements. That would be a whole lot easier.

Jim

> Jim
