Message-ID: <47C5C89D.3060600@redhat.com>
Date: Wed, 27 Feb 2008 15:31:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Ok latest Xserver is in rawhide, and permissive mode seems to be
 working.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Although policy seems to be a long way off.

Trying to get all of these to work correctly is going to be a bear.

#============= staff_mono_t ==============
allow staff_mono_t staff_default_xproperty_t:x_property read;
allow staff_mono_t staff_t:x_drawable { get_property read getattr
list_child receive add_child };

#============= staff_t ==============
allow staff_t default_xproperty_t:x_property read;
allow staff_t output_xext_t:x_extension use;
allow staff_t staff_mono_client_xevent_t:x_synthetic_event send;
allow staff_t staff_mono_default_xevent_t:x_event receive;
allow staff_t staff_mono_default_xproperty_t:x_property read;
allow staff_t staff_mono_manage_xevent_t:x_event receive;
allow staff_t staff_mono_property_xevent_t:x_event receive;
allow staff_t staff_mono_t:x_drawable { get_property hide setattr show
receive manage send getattr list_child set_property };
allow staff_t xdm_xserver_t:x_device force_cursor;

I will try unconfined_t next.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfFyJ0ACgkQrlYvE4MpobNy4gCgkRXAr9bB8zjHRktlEDog0ubh
un0An1O8mTXE5m6sT5SIK0AmChGyDfNf
=M8z0
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
