Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5PKwsoO025619
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2007 16:58:54 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5PKwr6d002955
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2007 20:58:53 GMT
Subject: Re: [PATCH] Initial policyrep patch
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <d060fb6e9bd19573be1a.1182796135@localhost.localdomain>
References: <d060fb6e9bd19573be1a.1182796135@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4qjVqJZyE6cTShaWmQX/"
Date: Mon, 25 Jun 2007 16:58:49 -0400
Message-Id: <1182805129.4391.41.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-4qjVqJZyE6cTShaWmQX/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-06-25 at 14:28 -0400, Karl MacMillan wrote:
> Initial patch to create a new policyrep branch using C++. This patch incl=
udes basic classes for
> representing policy (Node and Parent), a few policy objects, a bison pars=
er, a boost::python
> binding, and basic test infrastructure.
>=20
> Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"

 So I suck at C++, so feel free to ignore any of these comments that are
stupid :)

> +namespace policyrep {
> +
> +	class location;
> +
> +	class Parser {
> +	public:
> +		Parser();
> +		virtual ~Parser();
> +
> +		// scanner
> +		void scan_begin();
> +		void scan_end();
> +		bool trace_scanning;
> +
> +		// Parser
> +		Module* parse(const std::string& f);

 Why are you returning a pointer here, this implies that it can return
NULL ... but it can't, it throws an exception if there's an error.

> +		std::string file;

 Do you really want public members like this?

> +		bool trace_parsing;
> +		Module* pmodule;
> +
> +		// error handling
> +		virtual void error(const policyrep::location& l, const std::string& m)=
;
> +		virtual void error(const std::string& m);
> +	};
[...]
> +	struct PolicyImpl;
> +	class Policy : public Parent {
> +	public:
> +		Policy(bool mls=3Dfalse);
> +		Policy(const Policy& other);
> +		virtual ~Policy() { };
> +		void operator=3D(const Policy& other);

 Is it normal to have only a virtual dtor? My understanding was you
generally wanted ctor, dtor and op=3D to have the same overidability.

> +		bool get_mls() const;
> +		void set_mls(bool val);

 Isn't this better done with polymorphism? Like:

                 bool mls() const;
                 void mls(bool);

> +                virtual void output(std::ostream& o, enum OutputStyle st=
yle=3DDEFAULT_OUTPUT) const;
> +	protected:
> +		PolicyImpl* impl;
> +	};
> +	typedef boost::shared_ptr<Policy> PolicyPtr;

[...]            =20
> +                std::string get_name() const;
> +                void set_name(std::string name);
> +                std::string get_version() const;
> +                void set_version(std::string version);

 Don't you want to be returning a const reference like:

                  const std::string &name(void) const;

...AIUI this automatically converts to a std::string via. copy in the
cases you need a writable version. Dito. the set version, but just for
the speed increase (Ie. the internal member is still a plain
std::string).

> +       Module::Module() : impl(new ModuleImpl) { }
> +
> +       Module::Module(const Module& other)
> +               : Parent(), impl(new ModuleImpl)
> +       {
> +               *impl =3D *other.impl;
> +       }=20

 So you are allocating memory to a pointer impl, but the Policy dtor
does nothing?

> +                virtual void output(std::ostream& o, enum OutputStyle st=
yle=3DDEFAULT_OUTPUT) const;
> +        protected:
> +		ModuleImpl* impl;
> +        };
> +	typedef boost::shared_ptr<Module> ModulePtr;
[...]

> +	void Policy::operator=3D(const Policy& other)
> +	{
> +		*impl =3D *impl;=09
> +	}

 This looks very wrong.


--=20
James Antill <jantill@redhat.com>

--=-4qjVqJZyE6cTShaWmQX/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGgCyJ11eXTEMrxtQRAnG7AJ9b3azzjPJXGWnapSLye/1rRUzZNwCgk2aW
jqyL9i+HfUO1uz92czCNNuE=
=Imph
-----END PGP SIGNATURE-----

--=-4qjVqJZyE6cTShaWmQX/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
