Subject: Re: Rawhide kernel is reporting
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Eric Paris <eparis@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <7e0fb38c0712310902u84e3465sb5104774757f8afc@mail.gmail.com>
References: <47791CF7.3030300@redhat.com>
	 <1199119756.3716.7.camel@localhost.localdomain>
	 <7e0fb38c0712310902u84e3465sb5104774757f8afc@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 07 Jan 2008 15:08:01 -0500
Message-Id: <1199736481.2944.247.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2007-12-31 at 12:02 -0500, Eric Paris wrote:
> Stephen do you have any thoughts on me stealing another flag to
> specify maybe 'has_unknown'?  Then we can only print a message if
> there is an unknown permission?  I could probably also to the printing
> in the validate_classes loop and not have to carry a flag.
> 
> dwlash also suggested
> 
> SELinux: policy loaded with allowing unknown accesses.
> 
> probably a bit less cryptic.  If we like the idea of not printing the
> message except when relevant I'll make both changes...

Moving the output to validate_classes and making it conditional on
whether or not any classes/perms were undefined seems reasonable.  I
don't think the above is less cryptic though.  Maybe "SELinux:  Missing
kernel classes or permissions from the loaded policy,
allowing/denying/rejecting".

> 
> -Eric
> 
> On 12/31/07, Eric Paris <eparis@redhat.com> wrote:
> > It means that if you kernel has defined classes and permissions which
> > the policy doesn't know about those security checks will be 'allowed'.
> > Aka if you update your kernel and not your policy 'hopefully' it won't
> > break stuff.
> >
> > -Eric
> >
> > On Mon, 2007-12-31 at 11:46 -0500, Daniel J Walsh wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > SELinux: policy loaded with handle_unknown=allow
> > >
> > >
> > > Have no idea what this means.
> > >
> > > Dan
> > > -----BEGIN PGP SIGNATURE-----
> > > Version: GnuPG v1.4.8 (GNU/Linux)
> > > Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> > >
> > > iEYEARECAAYFAkd5HPYACgkQrlYvE4MpobOkCACfT4kNc5CYsw4rtEDokk5RdXwO
> > > 0/YAn0RbSbhQaEY7ytMcLWKIvQrt7qj5
> > > =JH78
> > > -----END PGP SIGNATURE-----
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
