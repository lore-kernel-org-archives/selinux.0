Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Dhruv Gami'" <dgami@uncc.edu>, "'SELINUX'" <SELinux@tycho.nsa.gov>
Subject: RE: Basic question on policy design
Date: Thu, 4 Dec 2003 08:29:43 -0500
Message-ID: <000401c3ba6a$ad593430$8100a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3FCE05F9.8090006@uncc.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

By now you might have received several responses, but here are some pointers.
Basic documentation is sparse but others are developing some.  You can look on
our web site (www.tresys.com/selinux) for slides from a 3-day class we presented
a couple times for additional information; these slides are several months old
but generally accurate.

> The TE Configuration file defines an extensible set of types. Using
> the allow statement, allowable permissions between pairs of types are
> specified for each object class.
> 
> allow type_1 type_2:class { perm_1 ... perm_n };

type_1 is the source (subject or process) type and type_2 is the target
(object) type.  "class" is the object class pertaining to type_2 only.
For example:

	allow user_t bin_t : file {read execute };

generally means processes with the user_t type can have read and execute
permission for object instances of class file that have the bin_t type.  Of
course it's more complicated in the general case; you really have to learn by
trial the semantic meaning of all the various object classes and their
permissions.

> The meaning of this above rule is not too clear to me.
> 1. what exactly is the relationship between type_1 and type_2 ?

This specifies allowed access by the source type (type_1) to the
target type (type_2) for the specified object class[es] and 
permission[s].

> 2. is the class associated with type_2 only ?

Yes.  Generally speaking the object class of the source is typically
a process (subject), but in the network area it can be things like
messages.  Think process for source object class and you'll be right 
the vast majority of the time.

> 3. Are type_1 and type_2 interchangable in the above rule ?

No.

> 4. is there any rule that type_1 should be subject and type_2 should
> be an object type ?

See above.

type_transition is even more difficult to understand semantically at first!  See
the referenced slides for some insights.  Good luck.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
