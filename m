Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8DCc1EB017980
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2007 08:38:01 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8DCbxmr002743
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2007 12:37:59 GMT
Message-ID: <46E92F1B.2080203@redhat.com>
Date: Thu, 13 Sep 2007 08:37:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I have put my latest policy patch up on	http://dwalsh.fedorapeople.org/20070912/
References: <46E84D34.9030909@redhat.com> <1189675109.2917.11.camel@vogon>
In-Reply-To: <1189675109.2917.11.camel@vogon>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefan Schulze Frielinghaus wrote:
> On Wed, 2007-09-12 at 16:33 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> I have a txt file describing the changes for each patch.
>>
>> These are all my changes as of this morning.
> 
> I tried the patch for mozilla (apps_mozilla.patch) and I get a lot of
> errors:
> 
> $ patch --dry-run mozilla.if apps_mozilla.patch
> patching file mozilla.if
> Hunk #1 FAILED at 36.
> Hunk #2 FAILED at 54.
> Hunk #3 FAILED at 106.
> Hunk #4 FAILED at 147.
> Hunk #5 FAILED at 198.
> Hunk #6 FAILED at 226.
> Hunk #7 FAILED at 251.
> Hunk #8 FAILED at 267.
> Hunk #9 FAILED at 308.
> Hunk #10 FAILED at 480.
> 10 out of 10 hunks FAILED -- saving rejects to file mozilla.if.rej
> patching file mozilla.te
> Hunk #1 FAILED at 6.
> 1 out of 1 hunk FAILED -- saving rejects to file mozilla.te.rej
> 
> I'm using the files mozilla.{if,te} from SVN trunk repository of the
> refpolicy. Do I have to use another version?
> 
> The changes look like to confine the mozilla app on a targeted policy,
> right? Discussed before
> here:http://marc.info/?l=fedora-selinux-list&m=116485986019158&w=2
> 
These patches are from the strict-targeted-merge pool at tresys.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG6S8brlYvE4MpobMRAnBeAJ9JrRnn9MuOVKpSNe1xH0rSz1kn6wCeNE15
8kI+X4ZnE4PYvvvnz3WspNg=
=qEIi
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
