Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m42LrSG4028271
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2008 17:53:28 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m42LrPDH006795
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2008 21:53:25 GMT
Received: by wr-out-0506.google.com with SMTP id c30so1148765wra.21
        for <selinux@tycho.nsa.gov>; Fri, 02 May 2008 14:53:22 -0700 (PDT)
Message-ID: <7e0fb38c0805021453m4274bb4cgf9d40de2ec3daead@mail.gmail.com>
Date: Fri, 2 May 2008 17:53:21 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: segfault using dismod when linking modules
Cc: selinux <selinux@tycho.nsa.gov>, "Joshua Brindle" <jbrindle@tresys.com>
In-Reply-To: <1209735912.25678.510.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <7e0fb38c0805011304i3f63a0d0g987473892a76abb2@mail.gmail.com>
	 <1209735912.25678.510.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well at least it doesn't segfault   :)

/me has much pain trying to move genfs_context type messages into a module.

-Eric

On Fri, May 2, 2008 at 9:45 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>
>  On Thu, 2008-05-01 at 16:04 -0400, Eric Paris wrote:
>  > Maybe someone else will know this pretty quickly.  I'm attaching a
>  > tiny little base.conf and base.mod and a tiny test.te and test.mod
>  > that I built.  When I try to link them together I get a segfault
>  > somewhere through user_fix_callback() -> mls_level_convert()
>  >
>  > Anyway, maybe I'll get to looking at it tomorrow, but if anyone else
>  > who actually understands all of this has a chance to look let me
>  > know....
>
>  Looks like mls_level_convert() falls over dead if passed an "empty" user
>  declaration, which appears to happen when you specify a require on it
>  but not a declaration for it in your module, which is what you do in
>  test.te.  Patch below will at least fix the symptom - not sure whether
>  it will yield the expected end result though.
>
>  Index: trunk/libsepol/src/link.c
>  ===================================================================
>  --- trunk/libsepol/src/link.c   (revision 2874)
>  +++ trunk/libsepol/src/link.c   (working copy)
>  @@ -864,6 +864,10 @@
>         if (!mod->policy->mls)
>                 return 0;
>
>  +       /* Required not declared. */
>  +       if (!src->sens)
>  +               return 0;
>  +
>         assert(mod->map[SYM_LEVELS][src->sens - 1]);
>         dst->sens = mod->map[SYM_LEVELS][src->sens - 1];
>
>
>  --
>  Stephen Smalley
>  National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
