Date: Sat, 8 May 2010 09:59:05 +0200
From: Dominick Grift <domg472@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: Re: Selinux and Apache in chroot question....
Message-ID: <20100508075904.GB3075@localhost.localdomain>
References: <OF4B777D47.6A3F031D-ON8525771C.00694668-8525771C.0070353C@vpcl.on.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
In-Reply-To: <OF4B777D47.6A3F031D-ON8525771C.00694668-8525771C.0070353C@vpcl.on.ca>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 07, 2010 at 04:25:35PM -0400, fred.schnittke@vpcl.on.ca wrote:
> Hi:
>=20
> Not sure if this is the right place to post a question like this, but I'l=
l=20
> give it a shot.
>=20
> I've been following the "Guide to the Secure Configuration of Red Hat=20
> Enterprise Linux 5" (which has been a great resource) in setting up our=
=20
> new server. However I ran into problems chrooting, apache, php and mysql.=
=20
> So it was suggested to remove the applications and compile from source.=
=20
> After that was done, I moved the three applications to my chroot, and wit=
h=20
> a bit of effort, it all works. The only thing is, I don't think SELINUX i=
s=20
> monitoring any of the files in the chroot. For instance, it still thinks=
=20
> the web directory is in /var/www/ instead of /chroot/httpd/usr/local/www.
>=20
> When I run the following command:=20
>=20
> ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | tr ':' ' ' |=
=20
> awk '{ print $NF }'

SELinux is much about the labeling of objects. File context specifications,=
 specify what label to assign to what object in what location.
By chrooting apache and mysql, you change their objects locations. Which in=
 this case SElinux seems not aware about.

The only objects that remain in place is the services init script. When ini=
t runs an init script the init domain, domain transitions to the init scrip=
t domain.
The init script domain would usually transition to the service domain, if t=
he service domain executable file is properly labeled.

The init script domain is unrestricted and unprotected.

So what is happening is the following.

You have moved objects owned by apache and mysql to a new mountpoint called=
 /chroot.=20
The command: semanage fcontext -l | grep /chroot, tells us that there is cu=
rrently no context specified for this location.

Thus the location would be labeled either default_t or root_t.

you start the service, init transitions to the unconfined init script domai=
n initrc_t and initrc_t, the init script executes the apache /mysql executa=
ble file which is somewhere in /chroot and labeled with a generic type for =
unspecified locations. Thus initrc_t does not domain transition to the apac=
he/mysql domain as it would usually do if the apache/mysql executable files=
 were labeled properly. So you end up with a chrooted services but you lost=
 selinux protection.


To solve this issue you must change the labeling to reflect their usual loc=
ation. You can list contexts of the various object using semanage fcontext =
-l and use similar command to add, modify, delete file context entries.



>=20
> I get this output:
>=20
> mysqld
> httpd
> httpd
> httpd
> httpd
> httpd
> httpd
> httpd
> httpd
> =20
> So my question is:
>=20
> Is there a (an easy) way to confine these daemons?
>=20
> =20
> Regards,=20
> =20
> =20
> Fred Schnittke  MCSE, MCP,
> Network Engineer
> VETERINARY PURCHASING company limited

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkvlGcgACgkQMlxVo39jgT81EgCg1bCln1/p2og4/K6dq2qZFcvP
31AAoIwk8kwMG60Pof3AJ4W8VIc6/Vfp
=sZx4
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
