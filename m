From: Steven Harp <steven.harp@adventiumlabs.org>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: What policy is the system running?
Date: Wed, 3 Nov 2004 11:28:48 -0600
References: <20041103160311.51639.qmail@web50604.mail.yahoo.com>
In-Reply-To: <20041103160311.51639.qmail@web50604.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200411031129.01034.steven.harp@adventiumlabs.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 03 November 2004 10:03 am, Steve G wrote:
> >We could do an md5 checksum of the binary policy as it is written to 
> >/selinuxfs/load then export this via /selinux/policy_md5sum.
> 
> I'm not sure I like this approach...they may have just recompiled a policy
> (overwriting the one in memory) and have either no policy that matches or perhaps
> multiple policies that match.

Agreed. The policyname approach alluded earlier would be more
useful.  Policy author gets to pick a name, version numbers etc,
supplemented by automatic information about when/where compiled.
This would convey the useful information for management.  Working with
a set of machines running various different policies under continuous
development, I can testify this sort of feature would really be
valued. I'd speculate this much would be easy to add to /selinux fs. 

Steve H


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBiRVVPcFX9H2zuSkRAm/+AJ4w5273zTrHRYhIa8NJaneIGu8dbgCgjrhp
s5NvovzYfUgTVV4GAah3F9c=
=BJPU
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
