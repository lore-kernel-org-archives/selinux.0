Message-ID: <49777FFB.1030504@manicmethod.com>
Date: Wed, 21 Jan 2009 15:05:15 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@tresys.com>
Subject: Policy Access Control 
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We've released policy access control prototypes in the past but for 
several reasons they weren't suitable for upstream. This includes the 
invasiveness of the patches, performance issues and so on. So we've 
attempted to implement access control in a less invasive and better 
performing way.

This patch basically does policy access control syntactically. For 
example, rather than controlling what access vectors expand to, we 
control them syntactically, using attribute labeling for rules, and 
add_to_attrib and add_type to add a type to an attribute.

This version also uses KaiGai's bounded types to implement the type 
hierarchy, rather than the name based hierarchy from before.

This is an early patch release for comments and review. It doesn't apply 
to trunk yet because of the added module interfaces, it applies to 
commit ff08b104a9f4ece55831265db0e94edd16781f22. Please pardon the huge 
patch, we'll split it out when we submit this for merging. Rather than 
attaching it to this email I put it on oss at:
http://oss.tresys.com/files/policy-server/pac.diff

This should also not be considered for use in production as it lacks 
some vital object classes, such as file contexts. File context support 
can be implemented later when an fcglob implementation is available.

Currently the checking is disabled by default, you must add 
metapolicy-check = {permissive, enforcing, system} in 
/etc/selinux/semanage.conf to enable it.

This also doesn't use an external server as in past releases, rather it 
implements the access control directly in libsepol.

Below are descriptions of all metapolicy permissions. A policy consists 
of six policy components: permission classes, users, roles, types, 
attributes, and booleans. In terms of metapolicy enforcement attributes 
are distinct from types. These six components are labeled by the policy 
management server. Their representative types are then checked using 
normal allow rules. The permission for the check is based upon how the 
component is being utilized.

common policy
All policy components inherit from the policy permission class.

•	add - An add permission is checked for every policy component 
definition. A definition is any location where a component may be 
created. Statements within a module's require and optional blocks are 
considered declarations, not definitions, as they simply advertise the 
existence of a component but do not actually allocate entries within the 
policy's symbol tables.

•	remove - The remove permission is checked for all components that 
cease or potentially cease to exist in the final policy. These are 
invoked when a policy module removal is requested.

class policy.class inherits policy
As the policy server currently relies on the kernel for access 
decisions, policies may neither add nor remove classes, nor may they add 
permissions to existing classes.

•	add_rule - The add_rule permission is checked against the class 
specified in type  and AV rules.

•	remove_rule - remove an AV or type rule with the object class


class policy.user inherits policy
The class policy.user governs permissions associated with adding and 
removing users from a policy. Since users may be authorized for multiple 
roles there is no atomic "modify" permission. To effect a modify, the 
new role should be added and the old one removed. Be aware that granting 
add but not add_role permission effectively creates a user with no login 
permission.

•	add_role - The add_role permission is checked each time a role is 
added to a user's authorized list.

•	add_seuser - The add_seuser permission is checked each time an seuser 
is added that maps to the specified SELinux user. (Not currently 
implemented)

•	remove_role - invoked when a role is removed from the user's 
authorized list.

•	remove_seuser - invoked when an seuser is removed that previously 
mapped to the user. (Not currently implemented)


class policy.role inherits policy

•	add_rule - add_rule is checked against the source or target role in 
role allow statements and the destination role in role_transition 
statements.

•	remove_rule - remove a role allow or role_transition rule with the role

•	add_type - The add_type permission is checked whenever a new type is 
added to a role.

•	remove_type - invoked when a type is removed from the roles authorized 
list

•	add_to_user - invoked when this role is added to a user's role set

•	remove_from_user - invoked when this role is removed from a user's 
role set


class policy.type inherits policy
The class policy.type governs both the addition and removal of types but 
also their use within type and AV rules.

•	add_rule - permission to add an AV or type rule with this type in it 
(as the source, target or default)

•	remove_rule - permission to remove an AV or type rule with this type 
in it (as the source, target or default)

•	add_to_role - add this type to the set of types a role is authorized 
to use

•	remove_from_role - remove this type from the set of authorized types 
for a role

•	add_to_attrib - add this type to an attribute

•	remove_from_attrib - remove this type from an attribute


class policy.attribute inherits policy
The metapolicy treats attributes differently from types even though they 
share the same namespace. Attributes have their own add and remove 
permissions which govern their creation and removal. Although they are 
just a grouping mechanism, it was deemed imperative that policies be 
able to limit the addition of attributes. For example, a malicious 
module might attempt to elevate its privileges by adding itself to 
privuser. Therefore there is a permission that controls how one may add 
types to existing attributes.

•	add_rule - add a type or AV rule with this attribute

•	remove_rule - remove an AV rule or type rule with this attribute in it

•	add_type - The add_type permission is checked whenever a type is being 
added to an attribute, either by declaring a new type and its attributes 
or appending to an existing attribute by way of typeattribute statements.

•	remove_type - The remove_type permission is checked whenever a type is 
removed from an attribute, when a module is removed.


class policy.bool inherits policy
Like users and roles, booleans are created and set using the same 
declaration. Booleans may not be further modified; thus they have no 
class-specific permissions.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
