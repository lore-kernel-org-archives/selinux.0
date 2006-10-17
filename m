Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9HM3Agg012868
	for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2006 18:03:10 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9HM1lsW013085
	for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2006 22:01:47 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k9HM3192005254
	for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2006 18:03:01 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id k9HM311r000525
	for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2006 18:03:01 -0400
Received: from vpn-14-122.rdu.redhat.com (vpn-14-122.rdu.redhat.com [10.11.14.122])
	by pobox.corp.redhat.com (8.13.1/8.12.8) with ESMTP id k9HM30Xg011577
	for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2006 18:03:00 -0400
Subject: performance of security_context_to_sid
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 17 Oct 2006 18:02:59 -0400
Message-Id: <1161122579.3163.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It has come to my attention that it seems as though calls to
security_context_to_sid are causing performance degradation.  It was
originally intended that converting a context string to an in kernel sid
would be a rare operation and would only happen on non speed critical
paths.  The example in question is the loading of someone's mail program
in which there are thousands of tiny files (messages) in a directory and
we are converting each and every context into a sid as those inodes are
brought into the kernel from disk.

Why is converting a context string to a sid a performance?  That
conversion information is stored in a hash table keyed on the sid.
Since the sid to context operation is more common that decision is
appropriate.  But that means searching in the reverse direction intended
for the hash table is basically a linear search of an unordered list.
The other part of this operation is the conversion of the context text
string into a kernel context struct.  I haven't done the profiling yet
to see if this part of the operation is particularly expensive but I
plan to see how much that costs in comparison to searching the sidtab in
reverse to decide if anything can or needs to be done there.

The sidtab data currently stores the context struct and the sid.  So my
first thought is to have a second hash table which keys based on
something in the context.  Actually I was just thinking of adding the
u32 user, role, and type and use that as the hash key.  I assume that
would give a reasonable distribution of values in the lest significant
bits.  Which would allow me to reuse most of the work in the sidtab hash
table.  As long as I don't find that converting the string context to a
kernel context struct is very expensive I can reuse the data in the
original sidtab symbol table and help to keep the memory impact down.  

My second thought was that of just a small cache.  I'd guess (just kind
of pulled out of the air) about 10 translations from context to sid
would be enough.  The cache would seem to eliminate most problems with
the creation of new in kernel inodes (coming from disk) for lots of
small files all likely having the same type.  I could create the
pathological worst case where I do lookups and never repeat the same
context, but still searching through such a small cache (as compared to
the sid tab) doesn't seem in my mind it would have a noticeable
performance penalty, although if done wrong could have serialization
issues that don't exist with the current search for the information in
the sidtab.  This does have the added complexity of having to deal with
new locking (although it wouldn't be that complex) and would have to
deal with re-using and freeing nodes at times other than policy load.

I'm wondering if anyone has any comments or thoughts.  I'm leaning
towards a new hash table which uses information from the kernel context
struct as it's key in parallel with the current sidtab in order to speed
up the conversions in this direction.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
