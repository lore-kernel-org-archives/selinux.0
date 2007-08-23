Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7NHuEHq012446
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2007 13:56:14 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7NHuENC006183
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2007 17:56:14 GMT
Date: Thu, 23 Aug 2007 13:55:22 -0400
Subject: colons valid in identifiers in compilers?
From: "Spencer R. Shimko" <sshimko@tresys.com>
To: <selinux@tycho.nsa.gov>
Message-ID: <C2F3424A.D494%sshimko@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

All,

We were experimenting with labeling aliased interfaces yesterday.  Of course
it doesn't work in the kernel, the denials are on the physical interface
label and the aliased interface labels are never checked (and rightly so).

The strange part is that, according to the lexer and parser sources, a colon
should never be a valid identifier.  E.g. eth0:1 should never be valid in a
netifcon statement:

netifcon eth0:1 system_u:system_r:netif01_t system_u:system_r:unlabeled_t

The statement above should be invalid but it isn't throwing a compiler
error.  You can test this using:

# semanage interface -a -t http_port_t eth0:1

Subsequently running checkpolicy in debug mode reveals that the aliased
interface label does appear in the binary policy.

According to the compiler sources a colon is not part of a valid identifier
(line 203 in policy_scan.l).  Why is the above succeeding given the lexer's
definition of an identifier?

Thanks,
Spencer
-- 
Spencer Shimko
Tresys Technology, LLC
sshimko@tresys.com
(410) 290-1411 x 125


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
