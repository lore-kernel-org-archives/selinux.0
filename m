Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VCaZrT011734
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 08:36:35 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VCaY5m022242
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 12:36:34 GMT
Subject: Re: banning copying of binaries (e.g. mozilla etc).
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040831122506.GE11456@lkcl.net>
References: <20040830222355.GI31497@lkcl.net>
	 <1093951787.8517.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20040831122506.GE11456@lkcl.net>
Content-Type: text/plain
Message-Id: <1093955694.8517.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 31 Aug 2004 08:34:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-31 at 08:25, Luke Kenneth Casson Leighton wrote:
>  ... so it acts a bit like a firewall in this respect?

Yes, but on the basis of process domains.  Not intended to replace a
traditional firewall, but to allow control of data flow among domains
via socket IPC.  To completely support this, one needs labeled
networking, but the existing mechanism lets you at least control locally
based on process domain, port type, netif type, and node type.

>  and, can the _user_ decide to add rules such as mozilla can access
>  port 8080?

This can be checked on the client side, as the client OS can perform a
check based on the sending process domain and the destination port
type.  In order to do it on the server side as well, we would need
labeled networking to convey the sending process domain to the server
OS.  The policy administrator can define such rules.  For user-definable
rules, you would need a policy daemon that allows users to apply
specific well-defined changes to the policy without completely changing
it.

>  whereas with the "targetted" policy it's the other way round.

That's not really accurate.  The targeted policy still has to define
everything that is allowed.  It is true that in the targeted policy,
most processes are placed into an unconfined_t domain that is allowed to
do anything by the policy, and only a specific set of processes are
placed into separate domains that are limited.

>  i would like to provide a mechanism whereby any binary that has an
>  associated DENY-firewall rule with it, that someone cannot simply
>  copy that binary to a different name, run _that_ binary and thereby
>  bypass the DENY-firewall rule [associated with the original binary].

As I said, you can prevent a domain from executing anything it can
create/write, and this is good practice for daemons, but difficult to
impose on users.  Simply preventing copying is pointless.

>  .... in fact.... come to think of it.... isn't there a lesson to be
>  learned here with the targetted policy?
> 
>  if the rules are by default "allow all" and "deny individual", then
>  surely by copying a binary and running it, it's possible to bypass
>  the "deny individual" rules???
> 
>  tell me that's not so...

That isn't the way targeted policy works.  It still has to specify
everything allowed; it just allows more.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
