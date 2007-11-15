Message-ID: <473C4AC7.8050403@redhat.com>
Date: Thu, 15 Nov 2007 08:33:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
Subject: Re: [Fwd: type class key]
References: <473B5928.6090800@redhat.com> <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil> <1194628263.3630.14.camel@vogon> <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil> <24708.1194612682@redhat.com> <22421.1194637689@redhat.com> <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil> <24415.1194697577@redhat.com> <363.1195129061@redhat.com>
In-Reply-To: <363.1195129061@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Howells wrote:
> Daniel J Walsh <dwalsh@redhat.com> wrote:
> 
>> David, we need a method of querying the keyring to see what the selinux
>> context that is associated with it.  For debugging purposes.  Currently
>> we can not tell whether the policy is correct or not, since we have no
>> way to ask the keyring for its label.
> 
> That's probably easy enough.  What form does a context take?
> 
> David
It is just the string associated with the object
probably something like

user_u:object_r:user_t:s0


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHPErHrlYvE4MpobMRAkt3AKDldaprNVeo+ZEA+Zwv+sylbl89pQCgodZX
a0TNsLL6RjlNvMajn4xz0Ak=
=4xHk
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
