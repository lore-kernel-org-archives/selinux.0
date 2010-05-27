Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4R0gktD020975
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 20:42:46 -0400
Received: from mail-gy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4R0g3t1029149
	for <selinux@tycho.nsa.gov>; Thu, 27 May 2010 00:42:03 GMT
Received: by gyg8 with SMTP id 8so4208569gyg.12
        for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 17:42:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C821BB21.B8234%csellers@tresys.com>
References: <C821BB21.B8234%csellers@tresys.com>
Date: Wed, 26 May 2010 20:42:44 -0400
Message-ID: <AANLkTim1T-6OdCijnKbMkOSFqSjfth-QDokuKSZe113k@mail.gmail.com>
Subject: Re: install giving the wrong label
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Chad Sellers <csellers@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 25, 2010 at 5:36 PM, Chad Sellers <csellers@tresys.com> wrote:
> I just found a problem with /usr/bin/install. It appears that it will label
> things improperly if they have an extra / in the target name. For instance:
>
> # install foo /usr
> # ls -lZ /usr/foo
> -rwxr-xr-x. root root system_u:object_r:usr_t:s0       /usr/foo
>
> but
>
> # install foo //usr
> # ls -lZ /usr/foo
> -rwxr-xr-x. root root system_u:object_r:default_t:s0       /usr/foo
>
> The same thing goes for targets like /var/www//foo, where the // is later in
> the filename.
>
> This appears to result from install calling matchpathcon() with the target
> passed in directly. My question is, whose responsibility should this be?
> Should matchpatchcon() scrub filenames passed into it, or should callers be
> required to pass proper filenames to matchpathcon()?

I suppose matchpathcon / selabel_lookup could handle the trivial cases
(e.g. duplicate /), but we don't want it to internally canonicalize
the pathname via realpath() or equivalent - leave that to the callers
(as is already done by e.g. restorecon).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
