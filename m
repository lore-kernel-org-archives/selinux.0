Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBVH35db015103
	for <selinux@tycho.nsa.gov>; Mon, 31 Dec 2007 12:03:05 -0500
Received: from nz-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBVH300G014261
	for <selinux@tycho.nsa.gov>; Mon, 31 Dec 2007 17:03:00 GMT
Received: by nz-out-0506.google.com with SMTP id i1so874177nzh.39
        for <selinux@tycho.nsa.gov>; Mon, 31 Dec 2007 09:02:59 -0800 (PST)
Message-ID: <7e0fb38c0712310902u84e3465sb5104774757f8afc@mail.gmail.com>
Date: Mon, 31 Dec 2007 12:02:59 -0500
From: "Eric Paris" <eparis@parisplace.org>
To: "Eric Paris" <eparis@redhat.com>
Subject: Re: Rawhide kernel is reporting
Cc: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <1199119756.3716.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47791CF7.3030300@redhat.com>
	 <1199119756.3716.7.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen do you have any thoughts on me stealing another flag to
specify maybe 'has_unknown'?  Then we can only print a message if
there is an unknown permission?  I could probably also to the printing
in the validate_classes loop and not have to carry a flag.

dwlash also suggested

SELinux: policy loaded with allowing unknown accesses.

probably a bit less cryptic.  If we like the idea of not printing the
message except when relevant I'll make both changes...

-Eric

On 12/31/07, Eric Paris <eparis@redhat.com> wrote:
> It means that if you kernel has defined classes and permissions which
> the policy doesn't know about those security checks will be 'allowed'.
> Aka if you update your kernel and not your policy 'hopefully' it won't
> break stuff.
>
> -Eric
>
> On Mon, 2007-12-31 at 11:46 -0500, Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > SELinux: policy loaded with handle_unknown=allow
> >
> >
> > Have no idea what this means.
> >
> > Dan
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v1.4.8 (GNU/Linux)
> > Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> >
> > iEYEARECAAYFAkd5HPYACgkQrlYvE4MpobOkCACfT4kNc5CYsw4rtEDokk5RdXwO
> > 0/YAn0RbSbhQaEY7ytMcLWKIvQrt7qj5
> > =JH78
> > -----END PGP SIGNATURE-----
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
