Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8HDcVuP019772
	for <selinux@tycho.nsa.gov>; Mon, 17 Sep 2012 09:38:31 -0400
Message-ID: <505727CF.2040406@redhat.com>
Date: Mon, 17 Sep 2012 09:38:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: ImportError: /usr/lib64/libvirt.so.0: undefined symbol: selinux_virtual_domain_context_path
References: <15785B7E063D464C86DD482FCAE4EBA5017811671EB9@XCH11.scidom.de>
In-Reply-To: <15785B7E063D464C86DD482FCAE4EBA5017811671EB9@XCH11.scidom.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/15/2012 09:10 AM, Lentes, Bernd wrote:
> Hi,
> 
> i don't know if this is the right place for my question, but i hope. I have
> a problem which is in my belief related to SELinux. I try to install the
> application "virt-manager", which is intendend to be for the control of
> virtuell domains in KVM. My box is SLES 11 SP1, 64bit, kernel 2.6.32. But
> starting the application throws an error:
> 
> pc56846:~ # Traceback (most recent call last): File
> "/usr/share/virt-manager/virt-manager.py", line 26, in <module> import
> libvirt File "/usr/lib64/python2.6/site-packages/libvirt.py", line 25, in
> <module> raise lib_e ImportError: /usr/lib64/libvirt.so.0: undefined
> symbol: selinux_virtual_domain_context_path
> 
> [1]+  Exit 1                  virt-manager pc56846:~ #
> 
> What I found out is that the package "linux-utils", beginning with version
> 2.1.9, include two manpages having names related to my error: 
> /usr/share/man/man5/virtual_domain_context.5.gz 
> /usr/share/man/man5/virtual_image_context.5.gz
> 
> I tried to install linux-utils, but didn't find the right version for my
> box. So I installed the mentioned version, breaking some dependendcies.
> That didn't help. I don't know if this is not the desired package or if the
> error is related to the missing dependencies.
> 
> Any ideas ?
> 
> 
> Bernd
> 
> -- Bernd Lentes
> 
> Systemadministration Institut für Entwicklungsgenetik HelmholtzZentrum
> münchen bernd.lentes@helmholtz-muenchen.de phone: +49 89 3187 1241 fax:
> +49 89 3187 3826 http://www.helmholtz-muenchen.de/idg
> 
> Wir sollten nicht den Tod fürchten, sondern das schlechte Leben
> 
> 
> Helmholtz Zentrum München Deutsches Forschungszentrum für Gesundheit und
> Umwelt (GmbH) Ingolstädter Landstr. 1 85764 Neuherberg 
> www.helmholtz-muenchen.de Aufsichtsratsvorsitzende: MinDir´in Bärbel
> Brumme-Bothe Geschäftsführer: Prof. Dr. Günther Wess und Dr. Nikolaus Blum 
> Registergericht: Amtsgericht München HRB 6466 USt-IdNr: DE 129521671
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
> 
Looks like libvirt expects to be linked against libselinux.  If you built
without SELINUX support then their is a bug in the ifdef code of libvirt that
should not be making this call.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBXJ88ACgkQrlYvE4MpobM6LQCglDCNsgzx9dToivR3Xy4D0LfA
3o8AoOiQgW+n7T0/pqLQL3rmvJhoRYOs
=xFmD
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
