Date: Wed, 15 Aug 2001 08:35:16 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Eric Peters <eric@peters.org>
cc: SELinux@tycho.nsa.gov
Subject: Re: SE Linux II?
In-Reply-To: <001c01c12527$610738a0$020144c0@windows>
Message-ID: <Pine.SOL.3.95.1010815080617.24997B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 14 Aug 2001, Eric Peters wrote:

> Is there an anonymous CVS server available for download?

Umm, no.  If we could put it out via anonymous CVS, then
why wouldn't we be able to put it out on the web site?  Same
obstacle.  But I wouldn't worry - it should be available soon.

> This question is a little out of blue I suppose, but i'm looking to
> hopefully setup a system of directory permission access so I can have:
> 
> /home/user1
> /home/user1/subuser1
> /home/user1/subuser1/subuser1subuser1
> /home/user1/subuser1/subuser1subuser2
> /home/user1/subuser2
> 
> Type of heirachy where the user1 can access everything under his
> /home/user1, subuser1 can access everything under his subuser1 home
> directoyr, and subuser2 acccess to his directory and etc.
> 
> Would something like this be implemented out of the box with SELinux, or
> could I potentially modify SELinux with relative ease to accomplish this
> type of access.  basically I want the "controlling" account "user1" to be
> able and access any "subuser1", "subuser2" files, where "subuser1" also has
> access to his child accounts "subuser1subuser1", and "subuser1subuser2"
> (user1 could also access these/his "children's"-"child" accounts)

You could certainly modify or replace the example SELinux security server
to implement such a policy model.  That is relatively straightforward, and
does not require any changes to the rest of the kernel to support new
policy models.  The policy models that we chose to provide in the example
security server are Type Enforcement and Role-Based Access Control (and,
optionally, Multi-Level Security).  These policy models group users and
processes into equivalence classes known as roles and domains, and define
permissions based on these equivalence classes.  That tends to be much
easier to manage than a policy based on individual users, although you can
certainly define a unique role/domain for a particular user if you want.

With regard to the hierarchical relationship among users that you
describe, the example policy models don't really provide implicit support
for it, although you can explicitly represent such relationships through
the assignment of permissions.  A more complete Role-Based Access Control
implementation would directly support such relationships.  

For more information, I would recommend reading our papers published in
the Proceedings of the Freenix track of the 2001 Usenix Annual Technical
Conference and in the Proceedings of the 2001 Ottawa Linux Symposium.
Hopefully, they will also be up on the web site soon.  Until then,
you can find the Usenix paper at the Usenix web site 
(www.usenix.org/publications/library/proceedings/usenix01) if
you are a member and the Ottawa paper at the LWN web site 
(lwn.net/2001/features/OLS/pdf).  

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
