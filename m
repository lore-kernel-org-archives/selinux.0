Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2IJantJ008228
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 15:36:49 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2IJaje0003294
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 19:36:45 GMT
Message-ID: <47E0156B.6090403@redhat.com>
Date: Tue, 18 Mar 2008 15:18:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Henley, Tim-P64420" <Timothy.Henley@gdc4s.com>
CC: selinux@tycho.nsa.gov
Subject: Re: unconfined_t Domain with MLS Policy
References: <EC684739C863494FB46F604CEDEC3E241BBA2F@AZ25EXM01.gddsi.com>
In-Reply-To: <EC684739C863494FB46F604CEDEC3E241BBA2F@AZ25EXM01.gddsi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Henley, Tim-P64420 wrote:
> Is the unconfined_t Domain available when running with the MLS Policy? I
> was attempting to assign a Perl script to the domain using chcon (with
> the -t switch). The result is that I get an "Invalid argument" error
> message. I'm doing this on a development box (the Perl script is for dev
> use only) as a means of trying to avoid having to stop and write a
> policy for every script/executable I create during development. Is this
> how I should be handling this or is there a more appropriate way to do
> this? Thanks in advance.
>  
> Regards,
> Tim Henley
> 
You could grab an unconfined.pp and install it.  But MLS does not have
this out of the box.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfgFWsACgkQrlYvE4MpobP+2ACdFaQ8LMW6V6IOY2VRKkEW0Mv0
oswAoORCC/BOv8E0aAQXr7GnLbMEHS6J
=pt8L
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
