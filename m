Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m69Eo9OZ021135
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2008 10:50:09 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m69Eo85u027988
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2008 14:50:08 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id m69EpJs4015726
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2008 10:51:19 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id m69EpJs3015725
	for selinux@tycho.nsa.gov; Wed, 9 Jul 2008 10:51:19 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m68KFwQ4019377
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2008 16:15:58 -0400
Received: from yx-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m68KFwoq012912
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2008 20:15:58 GMT
Received: by yx-out-1718.google.com with SMTP id 3so645134yxi.84
        for <selinux@tycho.nsa.gov>; Tue, 08 Jul 2008 13:15:57 -0700 (PDT)
Message-ID: <10143820807081315p2f2b12bx2754e157a640faeb@mail.gmail.com>
Date: Tue, 8 Jul 2008 16:15:56 -0400
From: "Karl MacMillan" <karlwmacmillan@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: semanage patch to allow boolean files to be imported.
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <4873C5B2.20009@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4873C5B2.20009@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 8, 2008 at 3:53 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Added flag to semanage to be able to import and export boolean files
> into the current system.
>

[snip]

>
> +       def modify(self, name, value=False, use_file=False):
> +

I think it is more idiomatic to use None instead of False when the
argument is a value rather than just a boolean.

>                rc = semanage_begin_transaction(self.sh)
>                if rc < 0:
>                        raise ValueError(_("Could not start semanage transaction"))
> -
> -               rc = semanage_bool_set_active(self.sh, k, b)
> -               if rc < 0:
> -                       raise ValueError(_("Could not set active value of boolean %s") % name)
> -               rc = semanage_bool_modify_local(self.sh, k, b)
> -               if rc < 0:
> -                       raise ValueError(_("Could not modify boolean %s") % name)
> +                if use_file:

And then "if use_file is not None:" here.

> +                       fd = open(name)
> +                       for b in fd.read().split():
> +                              bool, val = b.split("=")

I think you need a little more error checking here. For example, if
the b.split("=") resulted in less than two items the split into the
two variables would fail, raising an exception. I think that we would
want it to be both more tolerant to malformed files and provide better
error reporting to the user.

With those changes:

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
