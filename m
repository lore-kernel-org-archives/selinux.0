Message-ID: <473B5928.6090800@redhat.com>
Date: Wed, 14 Nov 2007 15:23:04 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
Subject: Re: [Fwd: type class key]
References: <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil> <1194628263.3630.14.camel@vogon> <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil> <24708.1194612682@redhat.com> <22421.1194637689@redhat.com> <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil> <24415.1194697577@redhat.com>
In-Reply-To: <24415.1194697577@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
>> Ah, wait - this is an automatic allocation of a per-uid keyring upon a
>> setuid() call, right?
> 
> Yes.
> 
>> and a single Linux uid might ultimately have a number of SELinux security
>> contexts running on its behalf.
> 
> Indeed.  It's not something that anyone considered at the time, I suppose.
> 
> David
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

David, we need a method of querying the keyring to see what the selinux
context that is associated with it.  For debugging purposes.  Currently
we can not tell whether the policy is correct or not, since we have no
way to ask the keyring for its label.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHO1korlYvE4MpobMRAoruAKDTG5sR2NohyeorC54htOn9/echHgCfYvKH
JwjEmAskBq6lezg/UfN74D8=
=NQJJ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
