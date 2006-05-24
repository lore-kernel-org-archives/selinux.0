Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4OIZhC2014933
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 14:35:43 -0400
Received: from wx-out-0102.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4OIZgbH001322
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 18:35:42 GMT
Received: by wx-out-0102.google.com with SMTP id i29so1194558wxd
        for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 11:35:42 -0700 (PDT)
Message-ID: <4474A779.7080806@gmail.com>
Date: Thu, 25 May 2006 03:35:37 +0900
From: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: method@gentoo.org, selinux@tycho.nsa.gov
Subject: Re: Gentoo SELinux problem in enforcing mode
References: <4474A024.5010103@gmail.com> <1148495589.24463.507.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1148495589.24463.507.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Thu, 2006-05-25 at 03:04 +0900, Tetsuji Maverick Rai wrote:
>> I installed SELinux on one of my Gentoo box but it doesn't work in
>> enforcing mode at all.   It looks like almost anything is denied even
>> with the base policy as provided in Gentoo's package.  For example, if
>> enforcing mode is enabled during an X Window session, all inputs from
>> the mouse or keyboard is denied.   On commandline console,
>> "ctrl+alt+del" gives "reboot not permitted"-like error...
> 
> That's a question for the Hardened Gentoo folks, assuming you are just
> using their packages for SELinux and not trying to mix them with
> upstream ones.  But last I looked, Hardened Gentoo was limited to server
> systems, not desktops, so they omit the X-related policy and are also
> strict policy-based rather than targeted policy-based.
> 
>> I have tried SELinux with old Redhat some years ago, and didn't find
>> such a problem and now I feel this is very unusual.  What wrong do you
>> think I am doing?   I have tried with generic 2.6.16.16, but now I'm
>> installing 2.6.16-rc6 plus nsa's patch at
>> http://www.nsa.gov/selinux/code/download5.cfm (but other file, policy,
>> libselinux etc are from Gentoo's package).  What's the difference in
>> this patch from the generic kernel?
> 
> I don't think that will help, and it isn't a good idea to mix and match.
> We only periodically make updated releases on nsa.gov, and they are
> primarily targeted at the distro package maintainers, not at end users
> (and in the case of Fedora, they actually track our bleeding edge from
> the selinux sourceforge CVS/subversion tree for the SELinux userland and
> the upstream kernel for the kernel code).  Most end users are using the
> distro packages these days.  
> 

okay,

Thank you for your advice.

- -Tetsuji
- --
Tetsuji 'Maverick' Rai
Main http://maverick6664.bravehost.com/
Profile:
http://setiweb.ssl.berkeley.edu/beta/view_profile.php?userid=123
pubkey http://mav.atspace.com/tmr_at_gmail.txt
PGP Key ID: 82335CD9
Key fingerprint = 41CA 94B4 2A89 3FF1 5B11  BC37 D597 E667 8233 5CD9

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEdKd31ZfmZ4IzXNkRAiOiAKDwx9WI4QYRKyhXgCuG4erem1n4qgCfe82e
hHKpn+IGNU8RdBPY0nE97PA=
=wu+g
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
