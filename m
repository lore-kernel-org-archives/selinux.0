Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4TENoq9013018
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2012 10:23:50 -0400
Message-ID: <4FC4DBE9.6050305@redhat.com>
Date: Tue, 29 May 2012 10:23:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "James B. Byrne" <byrnejb@harte-lyne.ca>
CC: selinux@tycho.nsa.gov
Subject: Re: Where to go for advice on local policy secuirity implications
References: <3cc2271ab50f5f35b273260eda59d356.squirrel@webmail.harte-lyne.ca>
In-Reply-To: <3cc2271ab50f5f35b273260eda59d356.squirrel@webmail.harte-lyne.ca>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/28/2012 11:54 AM, James B. Byrne wrote:
> We employ a third-party Apache module (passenger aka mod-rails) to handle
> our Ruby-on-Rails web applications.  Because of the lack of SELinux
> awareness built into the module we currently run these on an isolated
> virtual host in SE permissive mode.
> 
> We are in the process of examining whether it is possible to create a local
> policy for Passenger which will allow it to run in enforcing mode but not
> open the system to other exploits. We would like to know if there is any
> on-line venue where the security aspects of specific policy elements might
> be discussed.
> 
> Is there such a resource?  If so, can anyone here provide the reference?
> 
> 
Why not just email to refpolicy list the rules you want to allow along with
the AVC's.  If there is security info you do not want to reveal, I would be
willing to look at them.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/E2+kACgkQrlYvE4MpobNBpACfVdm6sAYBtuTg2L5q7p8Hzv/3
5SoAmQFChBdVOQtNR1Nwp04GHtu6Q+7c
=U0yB
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
