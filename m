Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i09E1ZRb029659
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 09:01:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i09E0Uxr024650
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 14:00:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i09E0UYc024647
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 14:00:30 GMT
Subject: Re: load_policy atomicity
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Tim Ebringer <EB17151@jp.ibm.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <OF9293072A.D07D7FEF-ON49256E16.00015505-49256E16.000193AF@jp.ibm.com>
References: 
	 <OF9293072A.D07D7FEF-ON49256E16.00015505-49256E16.000193AF@jp.ibm.com>
Content-Type: text/plain
Message-Id: <1073656882.29816.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 09 Jan 2004 09:01:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-08 at 19:17, Tim Ebringer wrote:
> Assuming there are no logical problems with a new policy, can a reload
> generate any nasty side effects within the policy enforcement module
> (race conditions, deadlocks, etc.)? In other words, is a policy reload
> atomic such that it will not try and load a new policy halfway through
> an access control or relabelling decision?

It should be atomic.  The new policy is loaded into temporary structures
initially, then certain sanity checks are applied to it, and then it is
installed as the active policy, with the last step performed while
holding the policy write lock.  The access vector cache is then reset
and provided with the new policy sequence number.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
