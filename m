Message-ID: <010b01c125b1$45f9c340$020144c0@windows>
From: "Eric Peters" <eric@peters.org>
To: "Stephen Smalley" <sds@tislabs.com>
Cc: <SELinux@tycho.nsa.gov>
References: <Pine.SOL.3.95.1010815130623.5693D-100000@clipper.gw.tislabs.com>
Subject: Re: SE Linux II?
Date: Wed, 15 Aug 2001 10:39:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That helps alot thanks!

Eric

----- Original Message -----
From: "Stephen Smalley" <sds@tislabs.com>
To: "Eric Peters" <eric@peters.org>
Cc: <SELinux@tycho.nsa.gov>
Sent: Wednesday, August 15, 2001 10:38 AM
Subject: Re: SE Linux II?


>
> On Wed, 15 Aug 2001, Eric Peters wrote:
>
> > however still in a state of question about the representation of a
'domain'.
> > My understanding of a class is just aggregated types (read write/etc)
which
> > could fall under the class 'file', yet what is the definition of a
domain?
>
> The term "class" refers to the kind of object, e.g. a directory, a regular
> file, a device file, a TCP socket, a UDP socket, a message queue, etc.
> For each class, a set of permissions are defined to control the
> services/operations provided for that object.
>
> The terms "domain" and "type" refer to a particular security attribute
> in the security context that is used by the Type Enforcement (TE) policy.
> There have been many papers about TE and its variant DTE.  A "domain"
> is simply a security tag for a process, and a "type" is simply a
> security tag for an object.  The TE policy configuration specifies
> authorized permissions for various (domain,type,class) triples for
> operations on objects or (domain,domain,class) triples for operations
> between subjects.  Abstractly, a domain is a set of processes with
> the same set of permissions to objects (an equivalence class of
> processes).  The ability to enter a domain can be limited to specific
> programs by using the entrypoint permission, and the ability to
> transition between domains is controlled.  Typically, a TE policy
> directly authorizes users for specific domains.  The SELinux
> example security server uses roles as an intermediate abstractions,
> authorizing roles for specific domains and users for specific roles.
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
>
>
>
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
