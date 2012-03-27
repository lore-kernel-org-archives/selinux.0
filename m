Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RI2n7x007702
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 14:02:49 -0400
Message-ID: <4F7200C7.4060008@redhat.com>
Date: Tue, 27 Mar 2012 14:02:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 41/73] policycoreutils: mcstransd: write a pid file FIXME
References: <4F71E181.80300@redhat.com> <1332863630.15547.22.camel@lenny>
In-Reply-To: <1332863630.15547.22.camel@lenny>
Content-Type: multipart/mixed;
 boundary="------------030800030406070804090909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030800030406070804090909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/27/2012 11:53 AM, Colin Walters wrote:
> On Tue, 2012-03-27 at 11:49 -0400, Daniel J Walsh wrote:
>> This patch looks good to me. acked.
>> 
>> systemd expects a pid file to be written by unit services.
> 
> It doesn't if the service is non-forking.  In fact moving to non-forking services that don't write pid files is a major improvement that systemd brings over sysvinit, because the state is 100% reliable.  Pid files create the possibility of desynchronization if the service crashes, but the pid file remains.
> 
> So a better fix would be to change mcstransd to have a --no-fork option, and update the unit file to use it.
> 
> 
> 
> -- This message was distributed to subscribers of the selinux mailing list. If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes as the message.

How about. this patch.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9yAMYACgkQrlYvE4MpobNgMwCgxJ0rYn5VJyybfV5OeuYNIrCU
CbUAnA5BoNnWx2/JXS5IzHgbfrn/IDJb
=FH0Q
-----END PGP SIGNATURE-----

--------------030800030406070804090909
Content-Type: text/x-patch;
 name="0143-Add-an-f-option-to-run-mcstransd-in-the-foreground.-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0143-Add-an-f-option-to-run-mcstransd-in-the-foreground.-.pa";
 filename*1="tch"


--------------030800030406070804090909--
