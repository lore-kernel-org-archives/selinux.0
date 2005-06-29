Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5THd5gA014454
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 13:39:05 -0400 (EDT)
Received: from mail37-res-R.bigfish.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5THcC79014195
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 17:38:12 GMT
Message-ID: <42C2DC80.8070904@unify.com>
Date: Wed, 29 Jun 2005 10:38:08 -0700
From: Ron Kuris <rk@unify.com>
MIME-Version: 1.0
To: Casey Schaufler <casey@schaufler-ca.com>
CC: gyurdiev@redhat.com, Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: wish-list item for selinux policy analyss
References: <20050629165658.82487.qmail@web31609.mail.mud.yahoo.com>
In-Reply-To: <20050629165658.82487.qmail@web31609.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Casey Schaufler wrote:

| I say amen to points 1-3. I add ...
|
| 4) A derived policy set will only tell you what the programs do,
| not what they are intended to do. Should I leave doors unlocked
| because burglers attempt to use them? If no burgler tries my door
| for a year does that mean having a lock on my door is unnecessary?

I think the logic here is backwards.  If nobody is using that door for
a year, then that door is a candidate for becoming a wall instead of a
door.  Otherwise, you end up in a maze of twisty passages, where
nobody knows what doors are needed and why.  Fewer doors means less
memory also, which can be important for embedded systems.

I think this wish-list item doesn't tell you what you can remove from
a policy.  However, it might tell you which rules are candidates to be
changed to a "deny" rule (or lack of an "allow" rule really).  Lets
say a particular program used to create temp files but they don't any
more.  Chances are, the rule will stay around, unless you realize it
isn't getting used any more, in which case you might want to
investigate it.

I do the same thing with iptables.  I have rules for services/ports
that have counters.  If the counters are zero, I look at the service
and decide whether or not I still need that service any more.

Ron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCwtx/VkC/44kdyuYRAre/AKDlOMgNkc5M790lbwWM3sT7M9UCrgCg264u
Om80p6tVIIr77yhxpXj7mnw=
=MBlJ
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
