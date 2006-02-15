Subject: Re: [SEPOL] Nodes, Ports: always prepend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <43F24C42.1010407@cornell.edu>
References: <43F24C42.1010407@cornell.edu>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 10:02:55 -0500
Message-Id: <1140015775.14253.379.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-14 at 16:31 -0500, Ivan Gyurdiev wrote:
> The current algorithm for modifcation of nodes and ports is:
> - look for an exact match, if one is found, replace
> - otherwise prepend to ocontext list.
> 
> This approach can (and will) cause problems if ordering is significant 
> for the modify() requests.
> Two overlapping port ranges or network nodes, one that overrides policy, 
> and one that is new, added in the wrong order can be caused to shadow 
> each other. This can happen regardless of what order they were added in 
> - either request can have a match within policy, and be pushed behind 
> the other one, invalidating the ordering.
> 
> This will be an issue for ordering, so change the algorithm to always 
> prefix there.
> For ports, we've banned overlapping port ranges from libsemanage, so 
> this isn't an issue. However, with respect to libsepol this is an 
> unnecessary limitation, so this patch also changes the algorithm to 
> always prefix ports as well, which will allow an addition of an ordered 
> set of ports, if the caller requires that.

Looks ok, but we can then also purge those local variables that are no
longer being used (prev, head, c).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
