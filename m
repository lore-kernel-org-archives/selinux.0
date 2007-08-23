Subject: Re: colons valid in identifiers in compilers?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Spencer R. Shimko" <sshimko@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <C2F3424A.D494%sshimko@tresys.com>
References: <C2F3424A.D494%sshimko@tresys.com>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 15:20:12 -0400
Message-Id: <1187896812.1451.642.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-23 at 13:55 -0400, Spencer R. Shimko wrote:
> All,
> 
> We were experimenting with labeling aliased interfaces yesterday.  Of course
> it doesn't work in the kernel, the denials are on the physical interface
> label and the aliased interface labels are never checked (and rightly so).
> 
> The strange part is that, according to the lexer and parser sources, a colon
> should never be a valid identifier.  E.g. eth0:1 should never be valid in a
> netifcon statement:
> 
> netifcon eth0:1 system_u:system_r:netif01_t system_u:system_r:unlabeled_t
> 
> The statement above should be invalid but it isn't throwing a compiler
> error.  You can test this using:
> 
> # semanage interface -a -t http_port_t eth0:1
> 
> Subsequently running checkpolicy in debug mode reveals that the aliased
> interface label does appear in the binary policy.
> 
> According to the compiler sources a colon is not part of a valid identifier
> (line 203 in policy_scan.l).  Why is the above succeeding given the lexer's
> definition of an identifier?

Changes via semanage don't go through checkpolicy at all, so the
checkpolicy lexer/parser are irrelevant.  It is purely up to what the
libsemanage parser allows, and what the libsepol interface allows (which
doesn't care).  Interesting point though.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
