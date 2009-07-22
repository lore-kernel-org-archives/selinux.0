Subject: Re: Policy database
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefano Carucci <stecarucci@hotmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <SNT115-W292B7844AE1B90E6F0CD4DC11B0@phx.gbl>
References: <SNT115-W292B7844AE1B90E6F0CD4DC11B0@phx.gbl>
Content-Type: text/plain
Date: Wed, 22 Jul 2009 15:53:30 -0400
Message-Id: <1248292410.28321.557.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-22 at 18:46 +0000, Stefano Carucci wrote:
> Thank you for your help Stephen. I have a couple of further questions:
> 
> 1) The AVC is implemented as a hash-table as the avtab in the
> policydb. Unlike the latter, the structure involves hlist_node and
> hlist_head. Where are they defined?

That's the native Linux kernel type for doubly linked lists with a
single pointer list head commonly used for hash tables.  See
include/linux/list.h.
The AVC has been extensively rewritten by others since we first
contributed it and thus is more "nativized" for Linux than the policy
avtab.  The AVC is also much more performance critical.

> 2) I read that performance degradation due to SELinux is 5 to 7% as a
> rough guess. Would you say that the rule retrieval functionality (in
> general, from both the AVC and the policydb) can entail a significant
> role in such estimate, considering the whole system? What is the most
> functionality in SELinux?

Most access checks should be resolved by the AVC and thus not incur the
overhead of a full compute_av.  Most other policy lookups are now also
cached, e.g. the port, node, and netif SID caches.

Network performance testing should be done with network_peer_controls=1,
which is the default in F11.

Another source of overhead is fetching the SELinux security contexts for
inodes, but modern releases should keep the contexts inline within the
inodes rather than in separate data blocks (as long as the inode size is
sufficient).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
