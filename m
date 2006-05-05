Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k457ov1F010743
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 03:50:57 -0400
Received: from h80ad24da.async.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k457osU3013199
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 07:50:55 GMT
Message-Id: <200605050750.k457oPp6014607@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: pam_namespace 
In-Reply-To: Your message of "Fri, 05 May 2006 16:23:22 +1000."
             <200605051623.25533.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <200605051623.25533.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146815424_2521P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 05 May 2006 03:50:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1146815424_2521P
Content-Type: text/plain; charset=us-ascii

On Fri, 05 May 2006 16:23:22 +1000, Russell Coker said:
> I was just playing with pam_namespace.  It seems to me that the current setup
> of having tmp/tmp.inst-$USER- does not provide adequate protection.  A 
> process that is hostile to the user and which runs in the system name space 
> (EG any cracked daemon) can access the user's instance of /tmp.

Not if /tmp/tmp.inst-$USER has an SELinux context on it that the daemon
isn't able to read.  Of course, this has it's own issues, since the parent
and instance directories have different SELinux contexts.

I've been corresponding with Janak Desai about several issues related to this
one - it turns out to be trickier than expected if you need any setup above
and beyond what pam_namespace does.  If anybody has good ideas on how the
namespace.init script should work, please let Janak know.  We already decided
that where the Fedora RPM put the script was a Bad Idea - now it's in /etc/
security where it's easier to protect.  Still an issue - I tried to get it to
play nice with gdm, and discovered it didn't work when the X socket wasn't
there. So I added to the script:

case $1 in
     /tmp)
        if [ ! -d ${2}/.X11-unix ];
        then
                mkdir ${2}/.X11-unix
                chcon --reference=${1}/.X11-unix  ${2}/.X11-unix
        fi

(and then hardlink the socket already open by GDM into that directory so
the user's X session can find it).  This however still loses, because at
this point we're already running in the user's SELinux context, so we
probably can't do the chcon.  Janak was going to look at setexeccon() games
so the script can do setup that the user can't....

--==_Exmh_1146815424_2521P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEWwPAcC3lWbTT17ARAnXoAKCKrQMWWmc/ujsJUussOWKPK2vkPACcCRIq
44718dytzAyQ9wHqO3ukKe4=
=/spP
-----END PGP SIGNATURE-----

--==_Exmh_1146815424_2521P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
