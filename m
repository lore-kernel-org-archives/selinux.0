Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r1ELPNL3001361
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2013 16:25:23 -0500
Date: Thu, 14 Feb 2013 22:25:02 +0100
From: <aranea@aixah.de> Luis Ressel
To: selinux@tycho.nsa.gov
Subject: Mount of cgroup filesystems fails when booting in SELinux enforcing
 mode
Message-ID: <20130214222502.2f7d657c@gentp.lnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA512;
 boundary="Sig_/tScVuar7tV94M=lAjR1VQX3"; protocol="application/pgp-signature"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Sig_/tScVuar7tV94M=lAjR1VQX3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello everyone,


does anybody have an idea about this bug?
https://bugs.gentoo.org/show_bug.cgi?id=3D457618

It looks like help from SELinux kernel developers would be really
helpful here, as everything is going on in-kernel here. It would be
especially helpful if someone could explain why there are no avc denial
messages.

If it helps, this is the userland script which mounts the cgroup
filesystems and therefore causes the messages:

        local agent=3D"/lib64/rc/sh/cgroup-release-agent.sh"
        mkdir /sys/fs/cgroup/openrc
        mount -n -t cgroup \
                -o none,nodev,noexec,nosuid,name=3Dopenrc,release_agent=3D"=
$agent" \
                openrc /sys/fs/cgroup/openrc
        echo 1 > /sys/fs/cgroup/openrc/notify_on_release

        yesno ${rc_controller_cgroups:-YES} && [ -e /proc/cgroups ] || retu=
rn 0
        while read name hier groups enabled rest; do
                case "${enabled}" in
                        1)      mkdir /sys/fs/cgroup/${name}
                                mount -n -t cgroup -o nodev,noexec,nosuid,$=
{name} \
                                        ${name} /sys/fs/cgroup/${name}
                                ;;
                esac
        done < /proc/cgroups

The "echo 1" line yields a "permission denied" error, but apart from
that there are no other messages.


If you need more details, just ask me.
Any feedback will be greatly appreciated!


Regards,
Luis "aranea" Ressel

--Sig_/tScVuar7tV94M=lAjR1VQX3
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJRHVZAAAoJEOBVC/zizycO9eQP/isxVSKKgENkhOQmoyyoTiiH
vOWlSLQgOxLXqtwM+uLWZkcj3prTaf/x13Bfipgc7VxBJAY1JOV8DRsQRT4LCjgl
4tN9LBPOLMI0K+5K9WoVNw1VS/l4XVJKJukd1dsI8gEO/NoRf4DqPS38RrO0UXIj
4UkqRLg0yQ4LwCZWrimTyy22ZnBxzEEUv0JmHn5UvtzKp5//E4dO60S9t9XUaOPy
BywyzHz13+yEtliTfXdd5IPotnWozfA/ak5hlgqVegf7jRQSTOkSmCdqGiCoGNRo
kwC+fDNSFg1EGZ1j//BoYFXstS0CGoGuWtJclbDtGoYrwIw0jjtO3LGXjGtVOc6e
uNj232VWmCRfE88JspciArze4bBH1N5c42QCNJ6Bu1+/7/+IOrcQdfGQpsUfC1ca
dfT8dC6wRyQPOEt1kiBkltXWrfg3r1SR153FSz1iB2kvHWbxtAsCzJIrdxdCzw0P
JsrvnXvLY/9aCbXrnYXfd50evtLLWrpSousCNrzjYV75EtXkKJ+1XLT9Km28qB6O
ZNkOhq7tKuzQ303G4TlGLgGrZYto+fZr/GKY+/Mzv+SpMA9EcgPi6k6SCeAPXwMc
ZwKkpiIWAcDf7xJsLYYnW6TBi8gQt5zwONjqp94BjHdMcyDMuEJ8vUBj9zKtXugF
adRjolPmcbrS8OVLS1bE
=pzZb
-----END PGP SIGNATURE-----

--Sig_/tScVuar7tV94M=lAjR1VQX3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
