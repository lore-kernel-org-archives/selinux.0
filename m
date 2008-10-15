Message-ID: <48F61C6A.6090703@redhat.com>
Date: Wed, 15 Oct 2008 12:38:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Trying to figure out the signature of a screen capture.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I wanted to see if we could prevent nsplugin_t from screen capturing
random parts of the Desktop.

So I relabeled /usr/bin/gimp as nsplugin_exec_t, then ran it to get
AVC's, when capturing a screen image, sadly no AVC's were generated, so
nsplugin_t can capture screen images.

I Wanted to see what avc's are created when you screen capture that are
different from running a standard X App, so I labeled /usr/bin/gimp and
put the machine in permissive mode.  Ran gimp to the point of capturing
the screen capture, and cleared the log files.

When capturing the image I got the following allow rules.

allow gpg_t focus_xevent_t:x_event receive;
allow gpg_t input_xevent_t:x_event receive;
allow gpg_t self:x_cursor destroy;
allow gpg_t xdm_rootwindow_t:x_drawable { read setattr };
allow gpg_t xdm_xserver_t:x_device { freeze force_cursor bell };


Is there anything we could eliminate from common X Apps, to prevent
nsplgugin from screen capture.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkj2HGoACgkQrlYvE4MpobNXJQCeJZe3VURACUU/l6IEfPjkI0i/
3WgAn3C/7F9YLlXYvpK64CJduYzyemHw
=HXwO
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
