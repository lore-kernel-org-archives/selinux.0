Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0BGNVik014905
 for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2015 11:23:31 -0500
Received: by mail-we0-f181.google.com with SMTP id q58so15423601wes.12
 for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2015 08:23:26 -0800 (PST)
Received: from bigboy.network2 (84-245-31-108.dsl.cambrium.nl. [84.245.31.108])
 by mx.google.com with ESMTPSA id fa13sm6687050wid.17.2015.01.11.08.23.25
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 11 Jan 2015 08:23:25 -0800 (PST)
Date: Sun, 11 Jan 2015 17:23:23 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
Message-ID: <20150111162322.GA24791@bigboy.network2>
References: <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
 <CAHZ_AjsxSJ3adY-UeMfik9xzOczk1411hk_ckSRPNbBOFSkwbA@mail.gmail.com>
 <14ad1cb43d8.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <1420883781.24061.22.camel@gmail.com>
 <CAB9W1A2Ro0mTqOwJOBL=9S9SaE0C_sXw3MUKpGP4L9VQObokYw@mail.gmail.com>
 <20150110171950.GA23358@bigboy.network2>
 <20150110174300.GA28262@bigboy.network2>
 <CAB9W1A1rLu_5XnMXqn0kbR0yhD-D39RmBTF12=1Kz320Hv5iEA@mail.gmail.com>
 <20150110191517.GA30004@bigboy.network2>
 <CAHC9VhQXUqQJErLXuadhapft2_=o81mmBmbZ0nDKRHBAHE0H+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
In-Reply-To: <CAHC9VhQXUqQJErLXuadhapft2_=o81mmBmbZ0nDKRHBAHE0H+g@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2015 at 10:49:03AM -0500, Paul Moore wrote:
> On Sat, Jan 10, 2015 at 2:15 PM, Dominick Grift <dac.override@gmail.com> =
wrote:
> > On Sat, Jan 10, 2015 at 01:54:01PM -0500, Stephen Smalley wrote:
> >> Well, I noted it in the technical reports I wrote originally for
> >> SELinux.  I guess it didn't get carried into documentation written by
> >> others, although it has been discussed on this list and the Fedora
> >> SELinux list various times.  Also, even if we were to implement such a
> >> check, we'd have to dontaudit it in most cases because the kernel
> >> would automatically be scanning the range for an available and allowed
> >> port, and various userspace libraries do exactly the same thing when
> >> trying to bind to an available port.  Which would render it a
> >> mysterious denial on random send/connect and bind calls.
> >
> > You hinted that implementing a check for this could affect performance,=
 and so i am no longer in favor of that solution.
> >
> > however i would like some of the tools to be aware of this issue.
> >
> > for example if i do
> >
> > sesearch -A -s sshd_t -t port_type -c tcp_socket -p name_bind
> >
> > That it returns somehow that this access to ports in the local port ran=
ge will be allowed. So that auditors see that it is allowed even though the=
re is no rule to allow it.
> > At least then they know there is something going on and can look for do=
cumentation about it.
> >
> > The problem is how does one implement that in an informative way withou=
t relying on customizable identifiers.
>=20
> Perhaps a mention in the relevant man pages?

That is better than nothing in my opinion but I do not believe this is prom=
inently visible enough on its own. In my view we should pro-actively inform=
 users about this and other inconsistencies.

>=20
> --=20
> paul moore
> www.paul-moore.com
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Dominick Grift

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUsqN0AAoJENAR6kfG5xmcr/IMAIqHsy5e9aInmPWRU6X4OCjr
DC8rJWTWOwD3QNQ+690MEG/cprgwnntQUCpLXeE0nW7UWPjDy9G82iluJ915s6Rl
JYqgotEZgt4/XyVbFA60Uvhz4l2zuW3UqxFDhgn+RL9NdxuazPzuxlOKy1+qJ37I
hn9ZIXcV6kg7bVIrPZAURDeUieV59VSTbUm5K1oEAI6r5wh0adkX6AROcMNddRHw
rlzhct5oqSSwkkuO8zWgr89ChvmfqasbLv7ROy6XUWKcoRp5KwHLMO0/EeSZgKYy
sOobdk+nqIt4oX51R3UeY/7htbJ5a1Cazvp1kMehs9AjX61HIpTcgR84teyBh9Tp
h2xXgWjO6J/bANQH6MGuT0hdBHQcmR/23pvq41bhAKnBRukGL3wW2jWIOM9S6E4b
OGvLCmiC6xY605XcYR6DIFwovVtj1PWT5yXco6DEiMtV88H6tKiaEov5KzcVn2PB
IOgVWoyzLiXYyQm0naTfeOOk0tITPyMgtZ8KplRTUg==
=oMzr
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
