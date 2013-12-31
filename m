Message-ID: <52C2E471.1010605@redhat.com>
Date: Tue, 31 Dec 2013 10:36:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <Selinux@tycho.nsa.gov>
Subject: Re: Bug in libselinux/src/setrans_client.c
References: <CAJfZ7=myQGgMdJ3NWZHUPvSTpOA-mfJUFLGQLvVdCz7a3N5evQ@mail.gmail.com>
 <CAPJdAQBu3=ZyEqUqn_eq4HagfGZZP3-9u_Taimozkkt4EjGfZg@mail.gmail.com>
 <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
 <52B84CDF.7020508@redhat.com>
 <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
In-Reply-To: <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

There is a bug in the coreutils patch, which should check if the
getfscreatecon() returns a null field, it should not call the setfilecon.

getfscreatecon(&scon)  Returning scon == NULL, means the systems default
labeling should take effect.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLC5HEACgkQrlYvE4MpobPMKACgmNTPS43v+0RsrJk3vTrxFeQV
Ke0AoKScjaUS8Foslumq9bxhie8su5uQ
=RchO
-----END PGP SIGNATURE-----
