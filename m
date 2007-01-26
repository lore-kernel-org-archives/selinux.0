Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0QL9jqR022574
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 16:09:45 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0QLAj0N016150
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 21:10:45 GMT
Subject: Re: [redhat-lspp] Problem SSH-ing into LSPP system with multiple
	categories
From: Tomas Mraz <tmraz@redhat.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: redhat-lspp@redhat.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1169844372.6956.130.camel@localhost.localdomain>
References: <1169842300.6956.129.camel@localhost.localdomain>
	 <1169843274.3194.10.camel@perun.kabelta.loc>
	 <1169844372.6956.130.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 22:10:36 +0100
Message-Id: <1169845836.3194.35.camel@perun.kabelta.loc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-26 at 12:46 -0800, Kylene Jo Hall wrote:
> I couldn't find anything in /var/log/secure but here is what was
> in /var/log/messages from the following attempts:
> ssh testuser/user_r/s2:c0.c1@localhost
> ssh testuser/user_r/s2:c0,c1@localhost
> ssh testuser/user_r/s2:c0-c1@localhost
> 
> Jan 26 14:41:40 rheal3a sshd[2646]: Postponed keyboard-interactive for
> testuser from 127.0.0.1 port 39420 ssh2
> Jan 26 14:41:44 rheal3a sshd[2646]: Postponed keyboard-interactive/pam
> for testuser from 127.0.0.1 port 39 420 ssh2
> Jan 26 14:41:44 rheal3a sshd[2645]: Accepted keyboard-interactive/pam
> for testuser from 127.0.0.1 port 394 20 ssh2
> Jan 26 14:41:44 rheal3a sshd[2645]: fatal: deny MLS level s2:c0,c1 (user
> range s0-s15:c0.c1023)
> Jan 26 14:42:11 rheal3a sshd[2653]: Connection from 127.0.0.1 port 39421
> Jan 26 14:42:11 rheal3a sshd[2654]: Postponed keyboard-interactive for
> testuser from 127.0.0.1 port 39421 ssh2
> Jan 26 14:42:15 rheal3a sshd[2654]: Postponed keyboard-interactive/pam
> for testuser from 127.0.0.1 port 39 421 ssh2
> Jan 26 14:42:15 rheal3a sshd[2653]: Accepted keyboard-interactive/pam
> for testuser from 127.0.0.1 port 394 21 ssh2
> Jan 26 14:42:15 rheal3a sshd[2653]: fatal: Failed to get default
> security context for testuser.
> Jan 26 14:43:35 rheal3a sshd[2662]: Connection from 127.0.0.1 port 39422
> Jan 26 14:43:35 rheal3a sshd[2663]: Postponed keyboard-interactive for
> testuser from 127.0.0.1 port 39422 ssh2
> Jan 26 14:43:39 rheal3a sshd[2663]: Postponed keyboard-interactive/pam
> for testuser from 127.0.0.1 port 39 422 ssh2
> Jan 26 14:43:39 rheal3a sshd[2662]: Accepted keyboard-interactive/pam
> for testuser from 127.0.0.1 port 394 22 ssh2
> Jan 26 14:43:39 rheal3a sshd[2662]: fatal: deny MLS level s2:c0.c1 (user
> range s0-s15:c0.c1023)
> Jan 26 14:44:30 rheal3a sshd[2670]: Connection from 127.0.0.1 port 39423
> Jan 26 14:44:31 rheal3a sshd[2671]: Postponed keyboard-interactive for
> testuser from 127.0.0.1 port 39423 ssh2
> Jan 26 14:44:34 rheal3a sshd[2671]: Postponed keyboard-interactive/pam
> for testuser from 127.0.0.1 port 39 423 ssh2
> Jan 26 14:44:34 rheal3a sshd[2670]: Accepted keyboard-interactive/pam
> for testuser from 127.0.0.1 port 394 23 ssh2
> Jan 26 14:44:34 rheal3a sshd[2670]: fatal: Failed to get default
> security context for testuser.

It seems that s2:c0,c1 and s2:c0.c1 logins are denied by policy. I don't
know why the s2:c0-c1 case fails on getting the default context - seems
like s2:c0-c1 is not a valid context.
-- 
Tomas Mraz
No matter how far down the wrong road you've gone, turn back.
                                              Turkish proverb


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
