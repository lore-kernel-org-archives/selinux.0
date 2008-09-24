Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8OBQwgg018533
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 07:26:58 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8OBQwO1027627
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 11:26:58 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m8OBQveh022615
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 07:26:57 -0400
Message-ID: <48DA2404.8010306@redhat.com>
Date: Wed, 24 Sep 2008 07:27:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
CC: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: How to find SELinux policy type?
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org> <17838240D9A5544AAA5FF95F8D52031604BE24FD@ad-exh01.adhost.lan>
In-Reply-To: <17838240D9A5544AAA5FF95F8D52031604BE24FD@ad-exh01.adhost.lan>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mike Sweetser - Adhost wrote:
> James,
> 
> The following command set should give you what you want:
> 
> grep '^SELINUXTYPE' /etc/selinux/config | awk '{split($0,a,"="); print
> a[2];}'
> 
> When run against my targeted setup on RHEL 5.2, it gave me back
> "targeted".
> 
> --------------------------
> Mike Sweetser | Systems Administrator
> 
> Adhost Internet
> 140 Fourth Avenue North, Suite 360, Seattle, Washington 98109 USA
> P 206.404.9000    T 888.234.6781 (ADHOST-1)    F 206.404.9050
> E mikesw@adhost.com    W adhost.com
> 
> Our brand new Adhost West data center is open - contact us for a tour at
> 1-888-234-6781 (ADHOST-1)
> 
> 
> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On Behalf Of James Morris
> Sent: Tuesday, September 23, 2008 4:13 PM
> To: selinux@tycho.nsa.gov
> Subject: How to find SELinux policy type?
> 
> Is there a programmatic way to determine the type of SELinux policy 
> configured on a system? (e.g. "targeted")
> 
> I've looked in the SELinux userspace and SETools repositories but not 
> found a library call to do this.
> 
> 
> - James
selinux_getpolicytype()

No Man page.

python -c "import selinux; print selinux.selinux_getpolicytype()"
[0, 'targeted']

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjaJAQACgkQrlYvE4MpobO+YgCgjCHmaHYdrgeOs0gnrpMPUsU7
3BUAmwdc99Nxbk8r7ZNemgbCIQ93RSG9
=YhtH
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
