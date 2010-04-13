Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3DFLRgP010082
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 11:21:27 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3DFKvXo012412
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 15:20:58 GMT
Message-ID: <4BC48BF2.4050603@redhat.com>
Date: Tue, 13 Apr 2010 11:21:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Benedict, Phillip M" <phillip.m.benedict@lmco.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: MLS telnet question
References: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com>
In-Reply-To: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/09/2010 08:02 AM, Benedict, Phillip M wrote:
> 
> Hello,
> 
> I am trying to come to a solution regarding the use of telnet on our MLS system. ( I know, ... the decision to use it was made above me ) . :(
> 
> What we have is a RHEL 5.3 system with the RedHat MLS policy installed.
> The system has multiple physical NICs attached to different networks.
> Each network is designated for it's own sensitivity level. ( so we might have one network for s1:c20, one for s2:c40 etc...)
> User accounts are created with sensitivity labeling via semange. ( so we might have: user1 with s1:c20, and user2 with s2:c40 etc... )
> The network does not carry any cipso data for evaluation by my server, so I don't think I can use netlabel.
> 
> Questions:
> If I use IPTables/SECMARK to apply sensitivity labels to the packets as they come into the system, will xinetd spawn the telnet session with a matching sensitivity?  ( currently the telnet sessions are spawned at SystemLow-SystemHigh )
I believe it should, and you should report a bug if it does not.
> If telnet is spawned with the appropriate sensitivity, will SELinux disallow a users login who do not have  a matching sensitivity?
> 
Yes.
> 
> Thanks,
> Mike Benedict
> 
> 
I
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvEi/IACgkQrlYvE4MpobPGuACbBVy4vjbEYk9eUZhsDc3ek0X9
X1MAn1bT6PppPbFq8C15UVxp53+MElrz
=U9Q2
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
