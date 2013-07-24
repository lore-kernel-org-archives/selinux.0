Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6OJYmKl001414
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2013 15:34:49 -0400
Received: by mail-la0-f43.google.com with SMTP id fs13so670789lab.30
        for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2013 12:34:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201307231723.GBI69775.VSOLHFQFOOtJMF@I-love.SAKURA.ne.jp>
References: <201305292152.CCF10933.FQJHFLOtOFVMSO@I-love.SAKURA.ne.jp>
	<201306082154.BDJ95357.MFQFVOJLSOtHFO@I-love.SAKURA.ne.jp>
	<20130609090721.GD5531@localhost>
	<201306092109.GBB81777.JOHtFOMQVLSFOF@I-love.SAKURA.ne.jp>
	<201306242205.GAE95336.LSFMFOFOQJOHtV@I-love.SAKURA.ne.jp>
	<201307231723.GBI69775.VSOLHFQFOOtJMF@I-love.SAKURA.ne.jp>
Date: Wed, 24 Jul 2013 15:34:46 -0400
Message-ID: <CACLa4psOkoz+G3zKQMO922Y7XjRu9hyDZADEyM=mL-eUztQGcA@mail.gmail.com>
Subject: Re: [PATCH] xattr: Constify ->name member of "struct xattr".
From: Eric Paris <eparis@parisplace.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 23, 2013 at 4:23 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> I'm waiting for an ACK from SELinux people.
> ----------------------------------------
> >From 283a07233cfa2f64cb654f72bec86b9a61c60af0 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 23 Jul 2013 17:20:12 +0900
> Subject: [PATCH] xattr: Constify ->name member of "struct xattr".
>
> Since everybody sets kstrdup()ed constant string to "struct xattr"->name but
> nobody modifies "struct xattr"->name , we can omit kstrdup() and its failure
> checking by constifying ->name member of "struct xattr".
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reviewed-by: Joel Becker <jlbec@evilplan.org> [ocfs2]
> Acked-by: Serge E. Hallyn <serge.hallyn@ubuntu.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Looks fine to me.

Acked-by: Eric Paris <eparis@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
