Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11JVD53017827
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 14:31:13 -0500 (EST)
Subject: Re: Advice on bringing up SE Linux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Villalovos, John L" <john.l.villalovos@intel.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1107284400.26936.212.camel@moss-spartans.epoch.ncsc.mil>
References: <60C14C611F1DDD4198D53F2F43D8CA3B035B5359@orsmsx410>
	 <1107284400.26936.212.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1107285883.26936.216.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 14:24:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-01 at 14:00, Stephen Smalley wrote:
> Any output in /var/log/messages from the attempt to write the policy to
> /selinux/load?  Any difference if you run load_policy on the binary
> policy instead of directly cat'ing it?

Actually, cat is quite likely to fail, as it likely tries to read and
write the file in chunks, whereas the kernel wants the entire policy
pushed in a single transaction.  load_policy is what you want.

/sbin/init is what normally loads the policy during startup.  Are you
using the modified /sbin/init (included in Fedora)?  What is in your
/etc/selinux/config?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
