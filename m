Message-ID: <47C2CBA1.5040807@redhat.com>
Date: Mon, 25 Feb 2008 09:07:29 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: I have begun merging XWindows Controls into Rawhide.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

But the complexity of this stuff is just getting nuts.

I don't thing we should have more then one type for xserver.  Allowing a
confined user to transition to user_xserver_t is just nuts and ends up
having awful policy for getting xdm_xserver_t to work.  Why in the world
would we allow a confined user to start and XServer?  And if they can,
why not just allow them to start xdm_xserver_t?  In Rawhide right now no
users can start and Xserver except unconfined_t and he starts
xdm_xserver_t to make sure the transitions work properly.  If someone
actually has a use case where they need user separated xservers then I
say write that policy off the main stream.  You can still theoretically
run multiple xdm_xserver_t at different MLS levels.

Having four macro parameters is confusing as hell, and needs to go.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfCy6AACgkQrlYvE4MpobMKCgCg5Eq4/YgkCt1ehLQWxiMrveo2
hwIAoIg7fAuzk/hyjIH6wqlzUKgiBUL2
=OmSx
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
