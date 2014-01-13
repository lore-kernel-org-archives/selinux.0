Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0DFD2pt027500
 for <selinux@tycho.nsa.gov>; Mon, 13 Jan 2014 10:13:02 -0500
Message-ID: <52D4026F.9030307@redhat.com>
Date: Mon, 13 Jan 2014 10:12:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Luis Ressel <aranea@aixah.de>, selinux@tycho.nsa.gov
Subject: Re: Web Application access to files in /mnt/
References: <52D0613F.3030805@kensnet.org>
 <1389390257.20258.71.camel@x220.localdomain>
 <20140112180520.32098337@gentp.lnet>
In-Reply-To: <20140112180520.32098337@gentp.lnet>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/12/2014 12:05 PM, Luis Ressel wrote:

The label should probably be

system_u:object_r:httpd_sys_content_t:s0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLUAm8ACgkQrlYvE4MpobPuSQCg4M2Hw8L5Bzvp8cPeZXYHvAz/
YPgAnjJcO64o2hozRWonY7LH8Wh5AvGj
=OOh1
-----END PGP SIGNATURE-----
