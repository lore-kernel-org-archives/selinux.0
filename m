Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9SCu6YN013505
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 08:56:07 -0400
Message-ID: <526E5EDD.20206@redhat.com>
Date: Mon, 28 Oct 2013 08:55:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>,
        SELinux List <selinux@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>
Subject: Re: avc_has_perm() returns -1 even when SELinux is in permissive
 mode
References: <20131027144337.5b89c5a8@fornost.bigon.be>
In-Reply-To: <20131027144337.5b89c5a8@fornost.bigon.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/27/2013 09:43 AM, Laurent Bigonville wrote:
> Hello,
> 
> After some debugging on Debian to figure out why D-Bus why denying messages
> between my user session and policykit with SELinux in permissive mode,
> eparis pointed me that Fedora has a patch for this in the avc_has_perm()
> function.
> 
> The patch[0] itself seems pretty trivial and I was wondering if it (or 
> something similar) could be merged in the upstream codebase.
> 
> But, if I'm not wrong, this patch makes avc_has_perm() and 
> avc_has_perm_noaudit() have different behavior when the machine is running
> in permissive mode, shouldn't this be tested in the avc_has_perm_noaudit()
> function instead?
> 
> my 2¢,
> 
> Laurent Bigonville
> 
> [0] 
> http://pkgs.fedoraproject.org/cgit/libselinux.git/tree/libselinux-rhat.patch#n704
>
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
I believe this patch was rejected upstream.  Basically upstream wanted the
calling apps to check the permissive flags themselves.  DBUS argued against
it, so we carry a patch for it.

The reason this is not in avc_has_perm_noaudit is that we want the avc to be
still audited.  I agree that it should be moved up to avc_has_perm_noaudit.

avc_has_perm_noaudit currently checks the permissive flag on only one code
path, but not on failures.

The argument is whether or not avc_has_perm* should ever block anything in
permissive mode.  We believe it should not.

I will move the override check to avc_has_perm_noaudit.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuXt0ACgkQrlYvE4MpobNkPwCgmAqYTTwRqfW2HxzyVz2AKrPc
9MgAoLEkCxZ2iNHsWRs+BEJlTwRmV14Y
=TiuS
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
