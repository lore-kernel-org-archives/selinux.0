Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81IXKrT023478
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 14:33:20 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81IWUY2021979
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 18:32:31 GMT
Subject: Re: DBus session bus -> separate security class?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <rcoker@redhat.com>
In-Reply-To: <1094062139.11084.49.camel@nexus.verbum.private>
References: <1094054625.11084.34.camel@nexus.verbum.private>
	 <1094056754.13328.73.camel@moss-spartans.epoch.ncsc.mil>
	 <1094062139.11084.49.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1094063486.13328.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 01 Sep 2004 14:31:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-01 at 14:08, Colin Walters wrote:
> That does sound more general.  So were this implemented, the policy
> might look like this:
> 
> type_transition cupsd_t $1_t:dbus $1_cupsd_t;
> allow $1_cupsd_t $1_t:dbus { send_msg };
> 
> Is that correct?

Hmm...I was thinking that one would compute a derived type when a
service is acquired based on the peer context and bus context, and then
perform checks between the sender's context (obtained via getpeercon, no
derivation on send) and the derived context computed earlier when the
service was acquired.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
