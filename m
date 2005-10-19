Subject: Re: Loading things into policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil>
References: <43559474.1080905@cornell.edu>
	 <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 13:51:03 -0400
Message-Id: <1129744263.2375.254.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 13:20 -0400, Stephen Smalley wrote:
> I'm not clear on why you wouldn't support overrides for ports,
> particularly as the base policy maps everything else left unspecified in
> the reserved port range to reserved_port_t.  You might argue that should
> be moved out of the base module and into the local file, but I expect
> some people will need to override the base module port contexts for
> specific needs no matter how much we prune it.  User overrides also can
> make sense, e.g. some people may want to strip root of sysadm_r

BTW, the ordering of the object context specifications matters for nodes
(hosts) and ports.  See what checkpolicy does for nodes (hosts) in
define_ipv4/ipv6_node_context and for ports in define_port_context.

Given this, you can support selective overrides within the reserved port
range just by inserting the individual port or more specific port range
entry at the beginning of the list, so that they will be matched before
reaching the general catch-all range for all reserved ports otherwise
unspecified.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
