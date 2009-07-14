Subject: Re: [RFC] Common Intermediary Language
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Caleb Case <ccase@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        mgoldman@tresys.com, jbrindle@tresys.com
In-Reply-To: <150846cc0907141021k36388ef8h31ff3b24609d2ea6@mail.gmail.com>
References: <150846cc0907141021k36388ef8h31ff3b24609d2ea6@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 14 Jul 2009 16:34:15 -0400
Message-Id: <1247603655.2551.14.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-14 at 13:21 -0400, Caleb Case wrote:
> The current kernel policy language has a number of limitations. These
> limitations make it difficult for the needs of policy writers to be
> met.
> 
> An example of this is an administrator who wants to create an Apache
> policy that is based on the default Apache policy. The administrator
> wants to tweak the policy a little, but also wants to track changes
> from the distribution to the original Apache policy.
> 
> Another example is an administrator that wants to take a permissive
> distribution policy and tighten it down. The administrator doesn't
> want to replace the entire policy, just remove a few permissions from
> it (maybe even removing permissions that aren't there already).
> 
> This is just the problems from the administrator's point of view.
> Consider the problems from a 3rd party software provider, the
> distribution, and individual software users.
> 
> For example, a distribution wants to ship a policy that works for a
> broad range of uses, but that compromises some security for
> flexibility. The administrator of a system only needs a limited set of
> that flexibility, but also wants to get policy updates from the
> distribution.
> 
> The current language also makes it difficult to integrate well with
> High Level Languages (HLL). HLL needs a more featureful language to
> target, but adding these features to the kernel policy language would
> unnecessarily complicate the kernel security server.
> 
> The current module language suffers from the order dependence of
> policy resulting in the base policy problem. All policy modules are
> dependent on it, it can't be easily upgraded, and some features end up
> baked into the base policy.
> 
> The Common Intermediary Language (CIL) is designed to solve these
> problems and many others that come up during policy development. It
> provides a common target for higher-level/domain-specific languages.
> It is not intended as a language that most policy developers will
> write in.
> 
> The CIL is the combination of two languages: a transformation language
> and a policy language.
> 
> The transformation language provides a number of useful features. For
> example, it allows you to copy existing policy and rename it (as if it
> were a template). Another example: it allows distributions to ship
> _read-only_ policy while still allowing administrators to make changes
> to it. The transform language acts similar to a semantic diff. The
> supported operations are add, delete, move, and copy with the
> potential add new operations as required. It is an embedded language
> that exists inline with the policy language.
> 
> The policy language is a mid-level language that incorporates aspects
> of the kernel policy language and provides some additional features
> over the current policy language:
> 
> * symbol scoping and protection
> 
> The policy language is hierarchical in nature. Because of this policy
> can be written such that private types are protected from use by other
> modules (such as in an allow rule).
> 
> * parameterized blocks of policy
> 
> Policy can be grouped into blocks that take arguments. They are
> similar in concept to interfaces in Reference Policy.
> 
> * generic sets
> 
> Sets of types, roles, users, and other policy elements can be
> represented. They are similar to attributes in the kernel language.
> 
> * selections
> 
> Policy elements can be selected with a syntax similar to that of
> FCGlob or XPath.
> 
> * labeling
> 
> Labeling is integrated into the policy language. This maintains the
> relationship between policy rules and associated labeling.
> 
> * debug support
> 
> The CIL supports debugging symbols that allow tracing back generated
> CIL to its original source files.
> 
> * order independence
> 
> The CIL is completely order independent.
> 
> * policy access control
> 
> The CIL's hierarchical nature lends itself to policy access control.
> Policy access control will be able to not only dictate which types,
> roles, etc. you can use, but which semantic chunks of policy you can
> edit and how you can edit them. Furthermore, modifications can be kept
> separate from the original policy source.
> 

Sound good so far.  

Did you just want comments on the general description given above at
this time, or are you planning on sending a more detailed proposal to
the list?

Some examples to show what the CIL would look like might be helpful.
 
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
