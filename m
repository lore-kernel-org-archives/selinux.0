Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB9IiFPA024919
 for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2015 13:44:15 -0500
Received: by wmuu63 with SMTP id u63so235169987wmu.0
 for <selinux@tycho.nsa.gov>; Wed, 09 Dec 2015 10:43:52 -0800 (PST)
Date: Wed, 9 Dec 2015 19:43:50 +0100
From: Dominick Grift <dac.override@gmail.com>
To: "Higgs, Stephen" <Stephen.Higgs@icfi.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: mcs design help
Message-ID: <20151209184349.GA22046@x250>
References: <17785f5ed91b4948872f64fa18dfb31f@VNUCITEX02.ICFI.icfconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <17785f5ed91b4948872f64fa18dfb31f@VNUCITEX02.ICFI.icfconsulting.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Dec 09, 2015 at 06:22:17PM +0000, Higgs, Stephen wrote:
> Hi All,
> 
> I'm looking for any implementation suggestions for my following the following: on a database server that restricts logins to confined users, allow selinux users with sysadm_r the ability to administer most aspects of the system, but restrict access to some mysql database files.
> 
> I approached this by labeling the mysql database files with an mcs category (c127), and then added a domain transition to the mysqld process to run with a context that includes c127.  The confined login was configured to initialize with s0:c0.  Finally (and I'm really not sure this was the best way), I needed to ensure the administrator could not disable/circumvent selinux so I added the following restriction to the newrole and setenforce binaries (c0.c1023).
> 
> My test user (also in the sudoers file) can do administrative functions, cannot access the database files, and cannot disable selinux.  Any suggestions on how to improve on what I have done?

I would not use MCS for this but instead use TE

Also i would leave sysadm_r:sysadm_t a generic admin, so i would
probably create a custom dbadm_r role.

> 
> --Stephen
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWaHZhAAoJENAR6kfG5xmcGeUL/216fJ/2FJjDpW1U/n5BaN13
iUi6v5dH1RrMgaiY4poCJ7rrTn3Wpof7/KwMWjqjxsck9osmCrDvjBPwJuDwzbMe
lTUgi1uvcc10TAncWZgnNcf8Tut+TUeOGGIoQ2r7JZNZ5gK/xmNVdWexl8WPydcq
eS/vPtglah50MvQk2NowMHV+MLH2gan10WD0sMjAY/H/jq0gLQat4MyTbjQvhPWU
qQehPmy9O7rD2Vz71C801B7yQKEq5BJEwU+88a26Nq46qkRvsbTup6jC5fO14MjJ
ElOydUKb7kqAkOZLW+QYM9ZI316Qp9CiPsW6AJOe4Mdco9e9x9exPYgdcEI9i9+x
JuhmLK2IlfDS98J/6brLRgU8K38YJOc+qaYH1Y5XW3JgAL4djXA+BwhrOg84cgK5
0BY1sC3xwmuvIZuQzAqhtHuM7FaXSaSQemga+oZEeNa8D5PcGxk0aEG+94SQcVg+
Gsy187V9lJ4J+LOQzJYN1kZC082CW+2jBYW/SgZGdQ==
=EKw1
-----END PGP SIGNATURE-----
