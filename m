Subject: RE: User object manager context location
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158851468B@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158851468B@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 18:06:25 -0400
Message-Id: <1161986785.17018.139.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 15:13 -0400, Joshua Brindle wrote:

> Apache can impose access control on relabeling vhosts just like semanage
> would. It's important to note that there is no enforcement of contexts
> attached to policy packages (and no short or mid term plans to add it
> AFAIK). Semanage could be used to add them but defaults have to come
> from policy packages if we do it that way..

Enforcement is always performed by the userspace object manager.  No one
is suggesting that libsemanage become an enforcer of policy.  The issue
is how the userspace object manager determines the proper label for its
objects, given information that is intrinsic to that object class, such
as the pathname, extension name, d-bus channel name, etc.  A mapping is
required.

The file_contexts configuration, an example of such a mapping, is not
part of the "policy" in the strict sense, in that it is not part of the
binary policy loaded into the kernel.  I apologize for using the term
"policy" sloppily.  However it is centralized, restricted to the
security administrator, queried through libselinux, and (ideally)
managed by libsemanage.

> I still don't buy this, if for no other reason than the object labeling
> (even defaults) are owned by the application, not semanage, not the
> policy. These are a resource of the application. 

The application does own the objects and the runtime labels of those
objects.  But the mapping that produces the labels should be owned by
the security administrator.

> The sychronization is a bad user burden to impose and IMHO isn't going
> to fly, even if it's the better security solution.

The only user burden involved is that the application administrator
would have to ask the security administrator to make certain changes or,
if they are the same person, explicitly and consciously change roles.
It's in keeping with idea of role separation.

The alternative is to have, for N userspace object managers on the
system:

- N different configuration file formats that the security administrator
now has to be aware of and have permission to edit.
- N different service administrators who now have the ability to mess up
the security configuration on the system.  This is very DACish.
- N different upstream projects that you have to convince to accept not
only the userspace object manager code, but also new SELinux-specific
configuration parameters.  Imagine if we had to convince the coreutils
or tar people to incorporate the file contexts mapping.
- N different packages that have to be updated when the next policy
package comes out (since the valid set of types _is_ in kernel policy).
You'd have to ship apache-targeted, apache-strict, apache-mls, etc. to
match the installed policy, and you'd have dependencies like
apache-targeted-1.2.3-54 requires selinux-policy-targeted == 1.2.3-1234.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
