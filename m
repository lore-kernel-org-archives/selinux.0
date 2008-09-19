To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: typebounds lookup from userspace
In-Reply-To: Your message of "Fri, 19 Sep 2008 11:07:22 EDT."
             <1221836842.25857.40.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <48D3B220.1060903@manicmethod.com> <1221834373.25857.25.camel@moss-spartans.epoch.ncsc.mil> <48D3B802.1000505@manicmethod.com>
            <1221836842.25857.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1221838947_13224P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 19 Sep 2008 11:42:27 -0400
Message-ID: <19786.1221838947@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1221838947_13224P
Content-Type: text/plain; charset=us-ascii

On Fri, 19 Sep 2008 11:07:22 EDT, Stephen Smalley said:

> I know that at one point the trend was toward one value per file, but
> that carries a cost of course, and I'm not sure the /selinux/class
> interface turned out to be ideal.  Maybe others have opinions.

That's true for sysfs.  The selinuxfs is a different beast and can make its
own choices.   The biggest gotcha is that you need to remain backwards-combatabl;e,
so anything that's there *now* has to remain there for a rather extensive
deprecation period.  Keep in mind that Andrew Morton just this week had an
issue with /proc/net that turned out to be because he had an FC5 policy loaded,
and that ancient policy didn't know that /proc/net is now a symlink...

What info would *ideally* be available for userspace?  Let's figure that out
first, and work backwards from there...



--==_Exmh_1221838947_13224P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFI08hjcC3lWbTT17ARAjRrAJ4+QuIHu59oHCVryc+wW51tOeDtpQCg06EZ
qWH1dximZPkX9zcYmNSWmCM=
=FZvY
-----END PGP SIGNATURE-----

--==_Exmh_1221838947_13224P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
