Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB7G5FES008323
	for <selinux@tycho.nsa.gov>; Fri, 7 Dec 2007 11:05:15 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB7G5EHF002122
	for <selinux@tycho.nsa.gov>; Fri, 7 Dec 2007 16:05:14 GMT
Message-ID: <47596E7D.1020705@redhat.com>
Date: Fri, 07 Dec 2007 11:02:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to update boolean descriptions to match what I had in	policycoreutils.
References: <475850A2.1050402@redhat.com> <1197042599.12626.113.camel@gorn.columbia.tresys.com>
In-Reply-To: <1197042599.12626.113.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Thu, 2007-12-06 at 14:42 -0500, Daniel J Walsh wrote:
>> Hopefully these descriptions are a little better.
> 
>>  policy/global_tunables              |   35 +++++++++++++---------------
>>  policy/modules/apps/java.te         |    7 -----
>>  policy/modules/services/apache.te   |   44 +++++++++++++++++++++++++++++-------
>>  policy/modules/services/bind.te     |    2 -
>>  policy/modules/services/ftp.te      |    4 +--
>>  policy/modules/services/kerberos.te |    2 -
>>  policy/modules/services/openvpn.te  |    2 -
>>  policy/modules/services/postfix.te  |   12 +++++++++
>>  policy/modules/services/rpc.te      |    4 +--
>>  policy/modules/services/rsync.te    |    4 +--
>>  policy/modules/services/samba.te    |   12 ++++-----
>>  policy/modules/system/mount.te      |    2 -
>>  policy/modules/system/userdomain.te |    9 -------
>>  13 files changed, 81 insertions(+), 58 deletions(-)
> 
> I applied the changes for the tunables that already exist, there were
> some other ones that leaked into the patch.  It brought to my attention
> that there are a few in global that only apply to unconfined.  I want to
> move that to unconfined, but there is a possibility of an upgrade
> problem now that unconfined is separated out into its own module on RH.
> Does the RPM always install the base and the modules in one single
> semodule command?
> 
Yes
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHWW59rlYvE4MpobMRAq+3AKDgHh1z+xlFAjXLK3hZLC1BRp7zyACgsA9O
uOtlVo/KMQIgOBJm5ZKMZB4=
=g3LG
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
