Message-ID: <002a01c125c1$ed4ee110$020144c0@windows>
From: "Eric Peters" <eric@peters.org>
To: <SELinux@tycho.nsa.gov>
References: <Pine.SOL.3.95.1010815080617.24997B-100000@clipper.gw.tislabs.com>
Subject: RBAC/Types Hierarchy
Date: Wed, 15 Aug 2001 12:38:49 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'll try to push this on a new thread and keep it more "open" for anyone on
the list to respond :)

> You could certainly modify or replace the example SELinux security server
> to implement such a policy model.  That is relatively straightforward, and
> does not require any changes to the rest of the kernel to support new
> policy models.  The policy models that we chose to provide in the example
> security server are Type Enforcement and Role-Based Access Control (and,
> optionally, Multi-Level Security).  These policy models group users and
> processes into equivalence classes known as roles and domains, and define
> permissions based on these equivalence classes.  That tends to be much
> easier to manage than a policy based on individual users, although you can
> certainly define a unique role/domain for a particular user if you want.
>
> With regard to the hierarchical relationship among users that you
> describe, the example policy models don't really provide implicit support
> for it, although you can explicitly represent such relationships through
> the assignment of permissions.  A more complete Role-Based Access Control
> implementation would directly support such relationships.

I believe due to the nature of the extended hierarchy, that I will need to
have an explicit representation of the permissions.  I'm essentially looking
to implement a web hosting solution, which would allow a "controlling"
account to read/write, send signals to processes, (and possibly su?!? - via
explicit transitions) to the "child" accounts.  My current idea is to have a
new domain for every user, a new role for every user, and corresponding

/home/thisuser(|/.*)                     system_u:object_r:thisuser_home_t

entries in the file_contexts such that in the rbac config, when a
"controlling" account is defined, in addition to his "controllinguser_t"
type,
role controllinguser_r types {
        controllinguser_t
        thisuser_t
}

The thisuser_t can be associated, and transitions setup for
controllinguser_r to thisuser_r.

When installing SELinux, the install process requires an effective reboot
after changing the file_contexts so that the new contexts can be enforced on
the system.

This means of having so many domains, types, and roles, would require alot
of "maintenance" when new accounts are added/deleted/edited - however I'm
going to have to be managing that anyhow.  My real "question" is can the
setfiles, (assuming I suppose, it gets a domain established so in runtime it
can properly transition to the required roles and set file contexts), and
updating the policies be entirely done in a "run time" environment, or would
I need to go about redressing this need as well.  The means I've gone about
installing SELinux don't seem very sympathetic to this runtime change :)


Thanks again for all your time,

Eric




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
