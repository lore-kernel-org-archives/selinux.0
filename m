Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7EKeKrO001861
	for <selinux@tycho.nsa.gov>; Mon, 14 Aug 2006 16:40:20 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k7EKe7oQ011731
	for <selinux@tycho.nsa.gov>; Mon, 14 Aug 2006 20:40:08 GMT
Date: Mon, 14 Aug 2006 16:40:22 -0400
Subject: Re: [RFC] Dynamic discover of object classes
From: Chad Sellers <csellers@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: <selinux@tycho.nsa.gov>, selinux-dev <selinux-dev@tresys.com>
Message-ID: <C10657F6.16513%csellers@tresys.com>
In-Reply-To: <1155585599.4756.23.camel@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/14/06 3:59 PM, "Karl MacMillan" <kmacmillan@mentalrootkit.com> wrote:

> On Mon, 2006-08-14 at 15:24 -0400, Chad Sellers wrote:
>> I sent out an RFC on this subject a long time ago (see below), but I was
>> overcome by events and didn't actually get to implement it. I'm finally
>> getting back to it, but wanted to send out an updated RFC on the subject.
>> The question that still remains is whether to do this entirely in userspace
>> or to create a kernel interface (via selinuxfs) to query the kernel about
>> object class values and permission offsets. I'd prefer to do this in
>> userspace if possible, as that would mean that a userspace object manager
>> could use the same mechanism for querying any security server (i.e. the
>> kernel one or a userspace security server).
>> 
>> So, the basic approach I talked about before is to have the policy compiler
>> write out an auxiliary file with the necessary data, and a userspace object
>> manager would look it up there before checking permissions. The problem with
>> this approach is consistency, as the policy on disk may not be consistent
>> with the one in the security server. This could result in one userspace
>> object manager (say mysql) accidentally checking permissions for another
>> userspace object manager's object class (say apache). We could help this by
>> writing the auxiliary file at policy load time instead of compile time, but
>> this would require the filesystem to be writeable when the policy was
>> loaded. Either way, there are also race conditions associated with
>> synchronizing filesystem data with kernel state.
>> 
>> So, I think I'm back to creating an interface to the kernel to query object
>> class value and permission offsets. A similar interface for the userspace
>> security server will be necessary in the future as well. I'd love to hear
>> any other ideas anyone may have, or any comments on the above approach.
>> 
> 
> The other drawback to the kernel approach is that the kernel would have
> to know about all object classes, but that isn't a large problem.
That's not necessarily true. The userspace security server could provide a
similar interface for its object classes (if the policies were split). Then
libselinux could route the object class/perm lookup request in the same way
that it would route permission checks (again, if the policies were split).

> Just
> to be clear, the policy toolchain and kernel would still have to agree
> on the ids for classes and perms, correct? This is only for userspace
> code doing enforcement?
> 
Yes, all kernel object classes and permissions would have to be agreed on
still. This would only support object classes designed for userspace code
doing enforcement (like dbus, etc.).

> What would the kernel interface look like?
> 
I haven't put too much thought into this yet, but probably a new selinuxfs
file that you would write an object class name to and get back the object
class value followed by the permission names in order. These would be
strings separated by spaces (in a similar fashion to /selinux/user, etc.).
I'm open to other suggestions if you have them.

> Karl
> 
>> Thanks,
>> Chad Sellers
>> 
>> 
>> On 10/17/05 1:28 PM, "Chad Sellers" <csellers@tresys.com> wrote:
>> 
>>> One of the efforts of the selinux policy server project is to make a
>>> functional userspace security server to give access control decisions to
>>> userspace object managers (eg., passwd, dbus, SE-X). This would free up
>>> kernel resources associated with the userspace object classes.
>>> Additionally, as userspace object managers grow in numbers, so will
>>> userspace object classes.  Consequently, we would like to support easy
>>> addition and use of userspace object classes.
>>> 
>>> Currently it is possible to add object classes and permissions to policy.
>>> Unfortunately, there is no infrastructure in place to discover the numeric
>>> class value and permission bitmap assigned when the policy is compiled.
>>> This model is not flexible enough for easy addition and use of userspace
>>> object classes and permissions.
>>> 
>>> We would rather not change the current security server interface for
>>> permission queries, as this works quite well.  Instead, we would like to
>>> modify libselinux so that userspace object managers can translate object
>>> classes into their numeric values.
>>> 
>>> In order to do this, a userspace object manager must be able to discover the
>>> value for the object classes it manages, and must be able to translate its
>>> permissions into bit values to compare against the resulting decision from
>>> the security server.  This would get rid of the need for hardcoded values in
>>> all object classes and libselinux awareness of all possible object classes.
>>> 
>>> To accomplish this goal there are a number of possibilities. We believe that
>>> there are 2 good choices. The first is to add interfaces to selinuxfs and
>>> the userspace security server to query the object class and permissions
>>> values from the in-memory policy. This would require interfaces on the
>>> security server to access the policydb and return the results. The
>>> interfaces would take strings and return integer values. The userspace
>>> security server would implement a similar interface.  These simple
>>> interfaces would allow the userspace object manager (through libselinux) to
>>> query the running policy to discover object classes and their associated
>>> permission bitmaps.  This is a conceptually simple method of discovery, but
>>> requires kernel changes to add this interface.  Additionally, using this
>>> libselinux call on a kernel without object class discovery support could
>>> fall
>>> back to the previous system of utilizing the predefined values in the
>>> headers.
>>> 
>>> The second choice is to discover this information from disk.  The
>>> information is already available in the on-disk policy (assuming policy on
>>> disk and in the security servers is in sync), so the userspace object
>>> manager could query the policy for discovery.  This would mean all userspace
>>> object managers would need to have read access to the policy and would
>>> introduce some overhead to parse the policy.  To solve these problems, an
>>> ancillary file could be built at policy link time which contains the
>>> information required.  This addresses the problems of querying policy
>>> directly, but adds another file to disk and duplicates information already
>>> in the policy.
>>> 
>>> We would like to begin implementing option 1, as this seems to be the
>>> cleanest.  Any feedback would be appreciated.
>> 
>> 
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
