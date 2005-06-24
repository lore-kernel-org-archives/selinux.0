Message-Id: <200506241805.j5OI5fqc018169@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>, <ivg2@cornell.edu>
Cc: "'James Morris'" <jmorris@redhat.com>, <selinux@tycho.nsa.gov>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Fri, 24 Jun 2005 14:05:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <200506241605.j5OG5tqc016540@gotham.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> One more idea - remove the multiple data fields in avtab_datum and
> have multiple entries for each key representing different rule types.
> If a small enough percentage of keys have only 1 type of rule
> (probably allow) then this should be a win. Haven't done the analysis
> of a real policy yet to know if this is a win, but seems like it
> would be (and anecdotal evidence from libapol suggests that it will
> be - this is similar to how the libapol av hash works).      

Just to expand on this, we have contemplated making this change in the past.
Here's a quick analysis: An avtab_datum_t is 4 x 32 bit words = 16 bytes .
An avtab node has a 3 x 32 bit (12 bytes) key, an avtab_datum (16 bytes) and
a next pointer (4 bytes) for 32 bytes total. 32 bytes times 100,000s rules
== mucho memory.

Taking am arbitrary sample policy and looking at the stats with apol, I have
298,894 allow rules, 2,076 type_trans rules, 25 type_change rules, 3
auditallow rules, and 53,719 dontaudit rules. Assume that all the
type_change rules share a common key with one of the type_trans rules, and
that all the audit rules share a common key with allow rules (a generally
safe assumption IMHO), we should have 300,970 avtab entries of which only
53,744 use more than one datum. 

So if we eliminated the 3 datum fields and just have one, and use the rule
type already encoded in the specified flag as part of the key (and we
partially do this now anyway), we would add 53,744 avtab entries but reduce
the size of each entry by 8 bytes for a (32-8 = 24) 24 byte avtab node size.


So the avtab that we have now would be 300,970 x 32 bytes = ~9.6MB versus
the alternative avtab of 354,714 * 24 = ~8.5MB or about a ~1.1MB savings
(about 10%) with very little code change and essentially zero performance
impact. If the audit-to-allow rule ration stays 1-10, then this change makes
sense.

I suspect we can look around and find other examples where small or no
performance tradeoffs can made for large size savings. For example if we
make the specified flag 16 bit instead of 32 (we're using less then 16 now),
we could save another ~.7MB of memory, or a total of ~1.8MB or about 19%.
Coupled with smaller policies in the future, we should be able to make
significant progress with less pain than a complete restructure of the
policydb.

If we go ahead and keep attributes around (as we have in the loadable module
work), then the savings can be much greater, but we'd have to study the
performance impacts better. The implementation changes would also be more
radical. For example the same sample policy above that had ~300K allow rules
in the binary policy had only ~27K allow rules in the source policy before
expansion. Some rules will expand anyway because of multiple classes, but I
believe most expansion is due to attribute expansion.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
