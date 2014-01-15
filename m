Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0FNPAOH005117
 for <selinux@tycho.nsa.gov>; Wed, 15 Jan 2014 18:25:11 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so1999600lab.9
 for <selinux@tycho.nsa.gov>; Wed, 15 Jan 2014 15:25:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52D6F7DF.2000603@redhat.com>
References: <52D6F7DF.2000603@redhat.com>
Date: Wed, 15 Jan 2014 18:25:05 -0500
Message-ID: <CACLa4puFZOyrX7TxQBft1614P9jpaqpSMWXSaK_vpnt3CNYRgg@mail.gmail.com>
Subject: Re: As we move to use Linux Containers User Namespace
From: Eric Paris <eparis@parisplace.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Just to blow everyone's minds: The first thought that came to me was
that the only way to make this useful is to actually put a label on
the user namespace.

If I create a container, and then a container inside that container,
I'd think selinux should be able to control the capabilities at the
second level down.  Dan's only asking about one level down...

On Wed, Jan 15, 2014 at 4:04 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> I think we need the kernel to start checking container Capabilities rather
> then system capabilities.
>
> I would like to be able to say something like
>
> allow svirt_lxc_net_t self:nscapability sys_admin;
>
> This way we can use MAC to better control break out of user namespace.
>
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlLW998ACgkQrlYvE4MpobP6IgCglpmgF8XKjr1W1xzPU6eGU6k+
> h8EAniQwwEhMAOeAy4e1NUw/8o2h/oWs
> =g8UL
> -----END PGP SIGNATURE-----
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
