Message-ID: <4F3BCE70.6060507@redhat.com>
Date: Wed, 15 Feb 2012 10:25:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.j.vermeulen@gmail.com>
CC: SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Force avc_has_perm to return success if enforcing == 0;
References: <CAPzO=Nw+T8_QkzHPboQ-s399hmdMF0jb0_3ipSrSyqpHztfOfg@mail.gmail.com>
In-Reply-To: <CAPzO=Nw+T8_QkzHPboQ-s399hmdMF0jb0_3ipSrSyqpHztfOfg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/15/2012 07:50 AM, Sven Vermeulen wrote:
> On Feb 14, 2012 10:26 PM, "Daniel J Walsh" <dwalsh@redhat.com 
> <mailto:dwalsh@redhat.com>> wrote:
>> I would like to patch libselinux to always return 0 on
>> avc_has_perm if the machine is in permissive mode.
>> 
>> This will allow Userspace Object Managers to work even if the
>> system is totally mislabeled and processes as running with bad
>> context. Currently if a program like dbus asks with a bad process
>> label it can get denials even in permissive mode.
> 
> Shouldn't SELinux-aware applications be aware as well that
> "permissive" exists? I don't know what the impact would be to
> change the libselinux code here, but if dbus (and other
> applications that link with libselinux) would check the selinuxtype
> as well they have full control over what happens.
> 
> A similar thing exists with SELinux-aware applications that call 
> getexeccon() when their context is wrong. Some of these
> applications expect this call to always result non-NULL which, in
> case of permissive runs, yields abnormal behavior (SSHd segfaulting
> is an example on this, Gentoo's Portage refusing to work is
> another).
> 
> In these cases too, it is much more important imo to have the 
> application check if the system  is running in permissive mode or
> not.
> 
> Wkr, Sven Vermeulen
> 


Well this code actually already had a check in there to see if it was
in permissive mode.  It was just not checking all failure modes.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk87znAACgkQrlYvE4MpobPjNwCeJR2x6XWmzJQx6oXuFNeXG4uj
ZxsAoLUS78u1sP9XJW9dY2PFiOQS076Y
=60ac
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
