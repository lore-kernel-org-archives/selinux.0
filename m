Subject: Re: Rawhide kernel is reporting
From: Eric Paris <eparis@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47791CF7.3030300@redhat.com>
References: <47791CF7.3030300@redhat.com>
Content-Type: text/plain
Date: Mon, 31 Dec 2007 11:49:16 -0500
Message-Id: <1199119756.3716.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It means that if you kernel has defined classes and permissions which
the policy doesn't know about those security checks will be 'allowed'.
Aka if you update your kernel and not your policy 'hopefully' it won't
break stuff.

-Eric

On Mon, 2007-12-31 at 11:46 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> SELinux: policy loaded with handle_unknown=allow
> 
> 
> Have no idea what this means.
> 
> Dan
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.8 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkd5HPYACgkQrlYvE4MpobOkCACfT4kNc5CYsw4rtEDokk5RdXwO
> 0/YAn0RbSbhQaEY7ytMcLWKIvQrt7qj5
> =JH78
> -----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
