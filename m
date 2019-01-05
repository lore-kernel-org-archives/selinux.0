Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9984FC43387
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 15:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7280120868
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 15:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAEPfT convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Sat, 5 Jan 2019 10:35:19 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:42151 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAEPfT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 10:35:19 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 079C15647B3
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 16:35:16 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id 32so34446541ota.12
        for <selinux@vger.kernel.org>; Sat, 05 Jan 2019 07:35:15 -0800 (PST)
X-Gm-Message-State: AJcUukfAvBY+3p4Hy0hI5QZ8rIMrslhj3KCnlwpSq9LzGQyie8pF8Jca
        1IJnROy8Sa2uA/n3+HVfvjIjNodzyFivHoyfBEk=
X-Google-Smtp-Source: ALg8bN6ngdSenl4tGr02sBhJ0n8zK56jUdllfnaD1T4W2h4zD3ynRvvN80pe9fLvCs25v2lM4dATLlKLjyCaU1RQirg=
X-Received: by 2002:a9d:6108:: with SMTP id i8mr39444244otj.278.1546702514921;
 Sat, 05 Jan 2019 07:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20190102134639.30515-1-bigon@debian.org> <e2da0c12-9e7d-089f-d45a-fba523e6e04f@debian.org>
 <91136ae0462be76415705cb8a014d2a49e59aa85.camel@tycho.nsa.gov>
 <3a568434-6d6a-172c-6337-d43ddfb910e1@debian.org> <dca2a6edf3d24aa897afc37dbd1b7b0421343a72.camel@tycho.nsa.gov>
In-Reply-To: <dca2a6edf3d24aa897afc37dbd1b7b0421343a72.camel@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 5 Jan 2019 16:35:04 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=m+=h-=wk-RRTcvBpt0Rr-p49NOzJTSpeYngbQgkwNQSA@mail.gmail.com>
Message-ID: <CAJfZ7=m+=h-=wk-RRTcvBpt0Rr-p49NOzJTSpeYngbQgkwNQSA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Always set errno to 0 before calling getpwent()
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Laurent Bigonville <bigon@debian.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 16:35:16 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 4, 2019 at 5:08 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Fri, 2019-01-04 at 16:57 +0100, Laurent Bigonville wrote:
> > Le 4/01/19 à 16:11, Stephen Smalley a écrit :
> > > On Wed, 2019-01-02 at 15:30 +0100, Laurent Bigonville wrote:
> > > > Le 2/01/19 à 14:46, Laurent Bigonville a écrit :
> > > > > From: Laurent Bigonville <bigon@bigon.be>
> > > > >
> > > > > The manpage explicitly states that:
> > > > >
> > > > >     The  getpwent()  function  returns a pointer to a passwd
> > > > > structure, or
> > > > >     NULL if there are no more entries or an error occurred.  If
> > > > > an
> > > > > error
> > > > >     occurs, errno is set appropriately.  If one wants to check
> > > > > errno
> > > > > after
> > > > >     the call, it should be set to zero before the call.
> > > > >
> > > > > Without this, genhomedircon can wrongly return the following:
> > > > >     libsemanage.get_home_dirs: Error while fetching
> > > > > users.  Returning list so far.
> > > > >
> > > > > https://github.com/SELinuxProject/selinux/issues/121
> > > > >
> > > > > Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> > > > > ---
> > > > >    libsemanage/src/genhomedircon.c | 13 ++++++++++---
> > > > >    1 file changed, 10 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/libsemanage/src/genhomedircon.c
> > > > > b/libsemanage/src/genhomedircon.c
> > > > > index 3e61b510..591941fb 100644
> > > > > --- a/libsemanage/src/genhomedircon.c
> > > > > +++ b/libsemanage/src/genhomedircon.c
> > > > > @@ -361,7 +361,11 @@ static semanage_list_t
> > > > > *get_home_dirs(genhomedircon_settings_t * s)
> > > > >
> > > > >         errno = 0;
> > > > >         setpwent();
> > > > > -       while ((pwbuf = getpwent()) != NULL) {
> > > > > +       while (1) {
> > > > > +               errno = 0;
> > > > > +               pwbuf = getpwent();
> > > > > +               if (pwbuf == NULL)
> > > > > +                       break;
> > > > >                 if (pwbuf->pw_uid < minuid || pwbuf->pw_uid >
> > > > > maxuid)
> > > > >                         continue;
> > > > >                 if (!semanage_list_find(shells, pwbuf-
> > > > > >pw_shell))
> > > > > @@ -403,7 +407,6 @@ static semanage_list_t
> > > > > *get_home_dirs(genhomedircon_settings_t * s)
> > > > >                 }
> > > > >                 free(path);
> > > > >                 path = NULL;
> > > > > -               errno = 0;
> > > > Actually I'm wondering if this shouldn't stay there
> > > Why?
> >
> > According to strdup() manpage, it can also change errno, isn't there
> > a
> > risk that errno is changed to an non-zero value and then causing the
> > warning below to be printed?
>
> On strdup(pwbuf->pw_dir) failure, we'll break out of the loop with non-
> zero errno and then correctly report that there was an error that
> truncated the list.  That's correct behavior.  The errno = 0; were are
> removing is within the loop and is obsoleted by your setting of it at
> the beginning of the loop.  So I think your patch is fine as is,
> although I have not tested it.

I have tested it on my test system. Before applying the patch,
"semanage fcontext -m ..." displayed "libsemanage.get_home_dirs: Error
while fetching users.  Returning list so far.". This message
disappears as expected with the patch.

Merged. Thanks!
Nicolas
>
> >
> >
> > > > >         }
> > > > >
> > > > >         if (errno) {
> > > > > @@ -1101,7 +1104,11 @@ static int
> > > > > get_group_users(genhomedircon_settings_t * s,
> > > > >         }
> > > > >
> > > > >         setpwent();
> > > > > -       while ((pw = getpwent()) != NULL) {
> > > > > +       while (1) {
> > > > > +               errno = 0;
> > > > > +               pw = getpwent();
> > > > > +               if (pw == NULL)
> > > > > +                       break;
> > > > >                 // skip users who also have this group as their
> > > > >                 // primary group
> > > > >                 if (lfind(pw->pw_name, group->gr_mem,
> > > > > &nmembers,
>

