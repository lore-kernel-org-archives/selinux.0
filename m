Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12D8X53021845
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 08:08:33 -0500 (EST)
Subject: RE: Advice on bringing up SE Linux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Villalovos, John L" <john.l.villalovos@intel.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <60C14C611F1DDD4198D53F2F43D8CA3B035B5599@orsmsx410>
References: <60C14C611F1DDD4198D53F2F43D8CA3B035B5599@orsmsx410>
Content-Type: text/plain
Message-Id: <1107349320.890.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 08:02:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-01 at 15:50, Villalovos, John L wrote:
> I will work on trying to get load_policy compiled up for what we have
> going and see if I can get it to work that way.

Note that you don't need the full load_policy logic to just perform a
basic load, especially given that you are using a pre-boolean policy
version.  You should be able to strip load_policy down to just opening
the policy file, mmap'ing it, and calling security_load_policy from
libselinux (or if you don't want to build libselinux, you could just
handcode load_policy to open /selinux/load and write the mmap'd policy
file to it).  The boolean support in the current load_policy isn't
critical, and is completely irrelevant for a version 15 policy.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
