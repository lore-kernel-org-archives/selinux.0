Message-ID: <4F398582.7030004@redhat.com>
Date: Mon, 13 Feb 2012 16:49:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Currently the kernel is interpreting reading the link file on /proc/PID/exe
 as sys_ptrace for a different UID.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I believe this should be DAC_READ_SEARCH.

I am trying to prevent all SYS_PTRACE from any domain on the system
but certain apps like dbus, consolekit, policykit, systemd-logger and
others like to look /proc/PID/exe to report the path of the executable
they are communicating with.  This causes lots of sys_ptrace access
being required for domains, that I do not believe need it.

They need DAC_READ_SEARCH because they are trying to read content that
is owned by a different UID.  The SYS_PTRACE stuff was put in to
prevent apps from reading process memory information stored in /proc.

I think this is a bug in the kernel.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk85hYIACgkQrlYvE4MpobPnsACcDXrEipv+rkdDa1/E4TwQdrtj
z9IAn2yCwDDdAvUIxiSugzMJQZUzswJ1
=Tfwm
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
