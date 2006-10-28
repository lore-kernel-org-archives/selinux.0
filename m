MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: User object manager context location
Date: Sat, 28 Oct 2006 13:58:29 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885146C1@exchange.columbia.tresys.com>
In-Reply-To: <1161986785.17018.139.camel@moss-huskies.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <ewalsh@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Eamon Walsh [mailto:ewalsh@tycho.nsa.gov] 
> 
> On Fri, 2006-10-27 at 15:13 -0400, Joshua Brindle wrote:
> 
> > Apache can impose access control on relabeling vhosts just like 
> > semanage would. It's important to note that there is no 
> enforcement of 
> > contexts attached to policy packages (and no short or mid 
> term plans 
> > to add it AFAIK). Semanage could be used to add them but 
> defaults have 
> > to come from policy packages if we do it that way..
> 
> Enforcement is always performed by the userspace object 
> manager.  No one is suggesting that libsemanage become an 
> enforcer of policy.  The issue is how the userspace object 
> manager determines the proper label for its objects, given 
> information that is intrinsic to that object class, such as 
> the pathname, extension name, d-bus channel name, etc.  A 
> mapping is required.
> 

As an aside, libsemanage will have to become an enforcer of policy (via
the policy server) or we couldn't control someone doing:

semanage login -a -s root my_login

(this is a future plan..)

And the interesting thing is that we are going to have to do *something*
if we continue to pile contexts in modules. The initial policy server
release will only be able to do enforcement on the module part of a
package, if there are contexts that escalate privileges packed with an
otherwise benign policy (perhaps one that doesn't add any rules so there
won't be access control done on it) then clearly that is a problem. This
is really another issue altogether that needs to be solved however..

> The file_contexts configuration, an example of such a 
> mapping, is not part of the "policy" in the strict sense, in 
> that it is not part of the binary policy loaded into the 
> kernel.  I apologize for using the term "policy" sloppily.  
> However it is centralized, restricted to the security 
> administrator, queried through libselinux, and (ideally) 
> managed by libsemanage.
> 
> > I still don't buy this, if for no other reason than the object 
> > labeling (even defaults) are owned by the application, not 
> semanage, 
> > not the policy. These are a resource of the application.
> 
> The application does own the objects and the runtime labels 
> of those objects.  But the mapping that produces the labels 
> should be owned by the security administrator.
> 

Why? First of all, there are cases where runtime and initial contexts
aren't different (policy server, dbus). So in that case do you concede
that the application should own the runtime labels? Do you think it
would be valid for the postgres schema to contain the initial labels?
That would clearly not be stored with the rest of these contexts with
the policy. I don't think it violates any fundamental security
principles though..

> > The sychronization is a bad user burden to impose and IMHO 
> isn't going 
> > to fly, even if it's the better security solution.
> 
> The only user burden involved is that the application 
> administrator would have to ask the security administrator to 
> make certain changes or, if they are the same person, 
> explicitly and consciously change roles.
> It's in keeping with idea of role separation.
> 
> The alternative is to have, for N userspace object managers on the
> system:
> 
> - N different configuration file formats that the security 
> administrator now has to be aware of and have permission to edit.

Which is obviously non-ideal and unscalable. These need infrastructure
to manage or noone will ever use them.

> - N different service administrators who now have the ability 
> to mess up the security configuration on the system.  This is 
> very DACish.

Not really. Individual enforcers can still control who can change them,
as well as MAC on the files (or whatever) containing the labels. 

> - N different upstream projects that you have to convince to 
> accept not only the userspace object manager code, but also 
> new SELinux-specific configuration parameters.  Imagine if we 
> had to convince the coreutils or tar people to incorporate 
> the file contexts mapping.

Except neither of those need mappings, they aren't enforcers. Enforcers
need configuration parameters to work, upstream should understand that
the code being added (the object manager code) has configuration
parameters, this is not a stretch I don't think.

> - N different packages that have to be updated when the next 
> policy package comes out (since the valid set of types _is_ 
> in kernel policy).

Ah! So now we are getting to a good issue. There is nothing preventing
the user object manager from being packaged with its own policy module
that defines the types used by that UOM. In fact, I think this is what
we want, once we have dynamic object class discovery we can even add
classes and permissions in modules so any UOM policy can be completely
independent of the running policy on the system. 

Caveat: this really needs interfaces in the language as well so that it
can make calls into refpolicy to give e.g., user domains access to their
types.

> You'd have to ship apache-targeted, apache-strict, 
> apache-mls, etc. to match the installed policy, and you'd 
> have dependencies like
> apache-targeted-1.2.3-54 requires selinux-policy-targeted == 
> 1.2.3-1234.
> 

I don't think that's true, there is nothing preventing an application
from installing its policy into
/usr/share/selinux/<policytype>/apache.pp and letting the selinux
infrastructure figure out how to handle it, in fact I think that is
precisely what we want.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
