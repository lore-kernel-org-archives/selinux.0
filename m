Subject: RE: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Frank Mayer'" <mayerf@tresys.com>, ivg2@cornell.edu,
   "'James Morris'" <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506281541.j5SFfQqc029318@gotham.columbia.tresys.com>
References: <200506281541.j5SFfQqc029318@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 12:21:40 -0400
Message-Id: <1119975700.22225.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-06-28 at 11:41 -0400, Karl MacMillan wrote:
> I went ahead and investigated this a little empirically. I horribly hacked
> checkpolicy to not expand attributes on avtab insertion and then compared the
> number of nodes generated with this and a non-hacked compiler using the latest
> FC4 strict policy. Results:
> 
> attributes inserted: 33473
> attributes expanded: 402196
> 
> Obviously this would be quite an improvement. Out of curiosity, I also looked at
> datum usage - i.e., how many of the 3 datums were used on average. Single means
> single datum (e.g., there was only an allow rule), double means two (e.g. there
> was an allow and an auditallow), etc. Results:
> 
> attributes inserted: single: 33473 double: 2943 triple: 0
> attributes expanded: single: 381570 double: 20626 triple: 0
> 
> The lack of triple made me wonder whether the packing was in fact working - it
> is not that surprising, but it is suspicious. So I created a small test case and
> verified that it is possible to use all three datums by inserting and allow,
> dontaudit, and auditallow with the same keys (not that this makes sense).
> 
> Patch below (not really useful - just a hack).

Thanks.  Yes, I think that this optimization (preserving attributes in
the binary policy and avtab) is going to provide us with the largest
improvement in memory usage and in speeding up policydb reads/writes.  I
also think it will be the easiest to implement while preserving backward
compatibility; I don't think it requires changes to the existing avtab
structures, unlike the other optimizations that were suggested.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
