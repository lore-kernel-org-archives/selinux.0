Message-ID: <52A08A87.2030009@tycho.nsa.gov>
Date: Thu, 05 Dec 2013 09:15:35 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Pavel Roschin <roshin@scriptumplus.ru>, selinux@tycho.nsa.gov
Subject: Re: avtab dense hash table
References: <20131205130431.7fe3c727.roshin@scriptumplus.ru>
In-Reply-To: <20131205130431.7fe3c727.roshin@scriptumplus.ru>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/05/2013 04:04 AM, Pavel Roschin wrote:
> Hello, I have some questions about hash tables in SELinux. As I see, all AV
> rules are stored inside hash tables: I found them in kernel source and in
> libsepol source. All types, domains, classes and so on also stored inside hash
> tables.
> 
> Regarding source code of libsepol I see that all hash tables are fixed-size:
> maximum avtab size is 2^13 - 8192 buckets. But in RHEL seinfo shows that there
> are 250000+ allow rules and 170000+ dontaudit rules. Shouldn't that be a huge
> performance kick?
> 
> In Linux kernel, avtab has size 2^11 - 2048 buckets for 256000+ av rules. Huge
> hash table will be transformed into lists and linear search that should be slow
> as hell, shouldn't?
> 
>>From kernel source:
> 
> #define MAX_AVTAB_HASH_BITS 11
> #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
> #define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
> 
> What is the reason of such dense hash maps?

So, first, originally the policy was much smaller.  I'm personally of
the view that people need to take a chainsaw to the refpolicy and look
to greatly coalesce domains/types, and to rework the way policy is
packaged in RHEL/Fedora to only install the policy modules relevant for
the packages that are installed.  See prior discussions from the list on
that.  Certainly you'll find that the policy we wrote from scratch for
Android is vastly smaller and simpler.

Second, most policy lookups should be resolved in the AVC and never
reach the avtab lookup at all.  At least that's the intent.

Third, the avtab hash table size has been tuned over the years to
balance between chain size and the desire to avoid high order
allocations for the hash table itself, e.g.
http://marc.info/?l=selinux&m=126866435230447&w=2

Not saying that we wouldn't take a patch though to improve the
situation.  You just need to show that it doesn't cause adverse side
effects (like high order allocations).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
