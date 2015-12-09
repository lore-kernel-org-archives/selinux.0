Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB9JfYPh029380
 for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2015 14:41:34 -0500
From: "Higgs, Stephen" <Stephen.Higgs@icfi.com>
To: Mike Palmiotto <mike.palmiotto@crunchydata.com>
CC: Dominick Grift <dac.override@gmail.com>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: RE: mcs design help
Date: Wed, 9 Dec 2015 19:41:17 +0000
Message-ID: <319a4b07cb6049e88c734d0aa1dbc5fe@VNUCITEX02.ICFI.icfconsulting.com>
References: <17785f5ed91b4948872f64fa18dfb31f@VNUCITEX02.ICFI.icfconsulting.com>
 <20151209184349.GA22046@x250>
 <8feb8506bdf043ebb449c1c52e7be787@VNUCITEX02.ICFI.icfconsulting.com>
 <CAMN686GFjnc7aT=13b-k16sbtPnBiNSsQ1ie-xWo3qtOh5wneA@mail.gmail.com>
In-Reply-To: <CAMN686GFjnc7aT=13b-k16sbtPnBiNSsQ1ie-xWo3qtOh5wneA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Mike Palmiotto [mailto:mike.palmiotto@crunchydata.com]
> Sent: Wednesday, December 09, 2015 2:21 PM
> To: Higgs, Stephen
> Cc: Dominick Grift; selinux@tycho.nsa.gov
> Subject: Re: mcs design help
> 
> On Wed, Dec 9, 2015 at 1:49 PM, Higgs, Stephen <Stephen.Higgs@icfi.com>
> wrote:
> > Thank you, I should also clarify - the generic admin role (sysadm_r)
> should not have access to the database files (this was the tricky part
> for me, as the generic admin has a lot of rights), and I am implementing
> a dbadm_r role that can only administer the database/files.
> >
> > If going with TE, would it mostly be a matter adding an explicit
> constraint on domain transition to mysqld_t?
> 
> If you go the TE route, you'd be labeling your database files and
> allowing the mysqld_t type permissions to it through interfaces/allow
> rules.
> You'd only associate dbadm_r with mysgld_t, so sysadm_r wouldn't have
> those permissions.
> 
> But this brings me to another point...
> 
> Your design really depends upon which database files you're referring
> to, exactly. Are these "database files" database-internal objects, or
> actual external resource files?
> There are should really be two types of admins (one for internal
> database objects, and one for external, OS-level files/objects).
> 
> --Mike
> 
> >
> > --Stpehen
> >
> >> -----Original Message-----
> >> From: Dominick Grift [mailto:dac.override@gmail.com]
> >> Sent: Wednesday, December 09, 2015 1:44 PM
> >> To: Higgs, Stephen
> >> Cc: selinux@tycho.nsa.gov
> >> Subject: Re: mcs design help
> >>
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA512
> >>
> >> On Wed, Dec 09, 2015 at 06:22:17PM +0000, Higgs, Stephen wrote:
> >> > Hi All,
> >> >
> >> > I'm looking for any implementation suggestions for my following the
> >> following: on a database server that restricts logins to confined
> >> users, allow selinux users with sysadm_r the ability to administer
> >> most aspects of the system, but restrict access to some mysql
> database files.
> >> >
> >> > I approached this by labeling the mysql database files with an mcs
> >> category (c127), and then added a domain transition to the mysqld
> >> process to run with a context that includes c127.  The confined login
> >> was configured to initialize with s0:c0.  Finally (and I'm really not
> >> sure this was the best way), I needed to ensure the administrator
> >> could not disable/circumvent selinux so I added the following
> >> restriction to the newrole and setenforce binaries (c0.c1023).
> >> >
> >> > My test user (also in the sudoers file) can do administrative
> >> functions, cannot access the database files, and cannot disable
> selinux.
> >> Any suggestions on how to improve on what I have done?
> >>
> >> I would not use MCS for this but instead use TE
> >>
> >> Also i would leave sysadm_r:sysadm_t a generic admin, so i would
> >> probably create a custom dbadm_r role.
> >>
> >> >
> >> > --Stephen
> >> >
> >> > _______________________________________________
> >> > Selinux mailing list
> >> > Selinux@tycho.nsa.gov
> >> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> > To get help, send an email containing "help" to Selinux-
> >> request@tycho.nsa.gov.
> >>
> >> - --
> >> 02DFF788
> >> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> >> https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF78
> >> 8
> >> Dominick Grift
> >> -----BEGIN PGP SIGNATURE-----
> >> Version: GnuPG v2
> >>
> >> iQGcBAEBCgAGBQJWaHZhAAoJENAR6kfG5xmcGeUL/216fJ/2FJjDpW1U/n5BaN13
> >> iUi6v5dH1RrMgaiY4poCJ7rrTn3Wpof7/KwMWjqjxsck9osmCrDvjBPwJuDwzbMe
> >> lTUgi1uvcc10TAncWZgnNcf8Tut+TUeOGGIoQ2r7JZNZ5gK/xmNVdWexl8WPydcq
> >> eS/vPtglah50MvQk2NowMHV+MLH2gan10WD0sMjAY/H/jq0gLQat4MyTbjQvhPWU
> >> qQehPmy9O7rD2Vz71C801B7yQKEq5BJEwU+88a26Nq46qkRvsbTup6jC5fO14MjJ
> >> ElOydUKb7kqAkOZLW+QYM9ZI316Qp9CiPsW6AJOe4Mdco9e9x9exPYgdcEI9i9+x
> >> JuhmLK2IlfDS98J/6brLRgU8K38YJOc+qaYH1Y5XW3JgAL4djXA+BwhrOg84cgK5
> >> 0BY1sC3xwmuvIZuQzAqhtHuM7FaXSaSQemga+oZEeNa8D5PcGxk0aEG+94SQcVg+
> >> Gsy187V9lJ4J+LOQzJYN1kZC082CW+2jBYW/SgZGdQ==
> >> =EKw1
> >> -----END PGP SIGNATURE-----
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-
> request@tycho.nsa.gov.

Thanks Dominick and Mike, I get what you're saying; I'm going to give this some more thought.  The sysadm_r already has access to mysqld_t, but perhaps making a new type for labeling the database files in /var/lib/mysql/* is the way to go (start from a clean slate where nobody has access).

--Stephen
