Message-ID: <47C63353.9040008@redhat.com>
Date: Wed, 27 Feb 2008 23:06:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Tonights rawhide contains a fix to stop xspy.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Basically if you turn on xserver_object_manager boolean, no applications
will be allowed to read the x_device.  This stops xspy as you said dead
in its tracks,  but some other applications start to get AVC's around
querypointer, and eventually I hung the server.  You mentioned in
another email, that you were going to change the querypointer to a
getattr rather then a read, I think this is necessary, to make this work.


#============= mono_t ==============
allow mono_t xdm_xserver_t:x_device read;

#============= unconfined_t ==============
allow unconfined_t xdm_xserver_t:x_device read;

#============= xdm_t ==============
allow xdm_t xdm_xserver_t:x_device read;

type=USER_AVC msg=audit(1204170576.402:774): user pid=2729 uid=0
auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023
msg='avc:  denied  { read } for request=X11:QueryPointer comm=mono
xdevice="Virtual core pointer"
scontext=unconfined_u:unconfined_r:mono_t:s0
tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device
: exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfGM1IACgkQrlYvE4MpobNFCACgswhn3LUm6w7TN1WQTJMjkQEr
Y4IAoI88/8sGgw8ZU3ibGp1cpzwUkDk5
=Q+pt
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
