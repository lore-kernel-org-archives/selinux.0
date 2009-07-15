Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6GJ7rL0000557
	for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2009 15:07:53 -0400
Received: from mail-vw0-f177.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6GJ8esR010234
	for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2009 19:08:40 GMT
Received: by vwj7 with SMTP id 7so350804vwj.32
        for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2009 12:07:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1247603655.2551.14.camel@moss-lions.epoch.ncsc.mil>
References: <150846cc0907141021k36388ef8h31ff3b24609d2ea6@mail.gmail.com>
	 <1247603655.2551.14.camel@moss-lions.epoch.ncsc.mil>
Date: Wed, 15 Jul 2009 15:46:18 -0400
Message-ID: <150846cc0907151246p41a89391yf0dc1ebde25841c7@mail.gmail.com>
Subject: Re: [RFC] Common Intermediary Language
From: Caleb Case <ccase@tresys.com>
To: jwcart2@tycho.nsa.gov
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        mgoldman@tresys.com, jbrindle@tresys.com
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 14, 2009 at 4:34 PM, James Carter<jwcart2@tycho.nsa.gov> wrote:
> On Tue, 2009-07-14 at 13:21 -0400, Caleb Case wrote:
>> The current kernel policy language has a number of limitations. These
>> limitations make it difficult for the needs of policy writers to be
>> met.
>>
>> An example of this is an administrator who wants to create an Apache
>> policy that is based on the default Apache policy. The administrator
>> wants to tweak the policy a little, but also wants to track changes
>> from the distribution to the original Apache policy.
>>
>> Another example is an administrator that wants to take a permissive
>> distribution policy and tighten it down. The administrator doesn't
>> want to replace the entire policy, just remove a few permissions from
>> it (maybe even removing permissions that aren't there already).
>>
>> This is just the problems from the administrator's point of view.
>> Consider the problems from a 3rd party software provider, the
>> distribution, and individual software users.
>>
>> For example, a distribution wants to ship a policy that works for a
>> broad range of uses, but that compromises some security for
>> flexibility. The administrator of a system only needs a limited set of
>> that flexibility, but also wants to get policy updates from the
>> distribution.
>>
>> The current language also makes it difficult to integrate well with
>> High Level Languages (HLL). HLL needs a more featureful language to
>> target, but adding these features to the kernel policy language would
>> unnecessarily complicate the kernel security server.
>>
>> The current module language suffers from the order dependence of
>> policy resulting in the base policy problem. All policy modules are
>> dependent on it, it can't be easily upgraded, and some features end up
>> baked into the base policy.
>>
>> The Common Intermediary Language (CIL) is designed to solve these
>> problems and many others that come up during policy development. It
>> provides a common target for higher-level/domain-specific languages.
>> It is not intended as a language that most policy developers will
>> write in.
>>
>> The CIL is the combination of two languages: a transformation language
>> and a policy language.
>>
>> The transformation language provides a number of useful features. For
>> example, it allows you to copy existing policy and rename it (as if it
>> were a template). Another example: it allows distributions to ship
>> _read-only_ policy while still allowing administrators to make changes
>> to it. The transform language acts similar to a semantic diff. The
>> supported operations are add, delete, move, and copy with the
>> potential add new operations as required. It is an embedded language
>> that exists inline with the policy language.
>>
>> The policy language is a mid-level language that incorporates aspects
>> of the kernel policy language and provides some additional features
>> over the current policy language:
>>
>> * symbol scoping and protection
>>
>> The policy language is hierarchical in nature. Because of this policy
>> can be written such that private types are protected from use by other
>> modules (such as in an allow rule).
>>
>> * parameterized blocks of policy
>>
>> Policy can be grouped into blocks that take arguments. They are
>> similar in concept to interfaces in Reference Policy.
>>
>> * generic sets
>>
>> Sets of types, roles, users, and other policy elements can be
>> represented. They are similar to attributes in the kernel language.
>>
>> * selections
>>
>> Policy elements can be selected with a syntax similar to that of
>> FCGlob or XPath.
>>
>> * labeling
>>
>> Labeling is integrated into the policy language. This maintains the
>> relationship between policy rules and associated labeling.
>>
>> * debug support
>>
>> The CIL supports debugging symbols that allow tracing back generated
>> CIL to its original source files.
>>
>> * order independence
>>
>> The CIL is completely order independent.
>>
>> * policy access control
>>
>> The CIL's hierarchical nature lends itself to policy access control.
>> Policy access control will be able to not only dictate which types,
>> roles, etc. you can use, but which semantic chunks of policy you can
>> edit and how you can edit them. Furthermore, modifications can be kept
>> separate from the original policy source.
>>
>
> Sound good so far.
>
> Did you just want comments on the general description given above at
> this time, or are you planning on sending a more detailed proposal to
> the list?

I was hoping to introduce the basic ideas of the CIL and get some
feedback on them. After that I was intending to send a more detailed
proposal for the language (including the grammer and syntax).

Any comments you have are greatly appreciated!

>
> Some examples to show what the CIL would look like might be helpful.

Without getting too wrapped around the axle with details (or syntax),
here is an example of removing an rule:

del /*/(Allow:Type * * /(Class file)/(Permission execute))

First, 'del' is the delete transform, so we are deleting whatever
follows. Second, '/' begins a selection, in this case we are selecting
all of the TE allow rules. Specifically, it selects all allow rules
with any source or target with the class 'file' and the permission
'execute'. The effect of this transformation is that any allow rules
that the selection matches will be deleted. Supposing that an allow
rule had multiple permissions, then only the execute permission would
be removed.

Another example, lets say there is an Apache policy provided by the
distribution policy and you want to create your own kind of Apache
policy based on it:

copy /(Block apache []) => Block myapache []

Maybe you decided that you didn't want everything in the Apache policy:

copy /(Block apache []) => Block myapache []
        except Type helper

This would copy everything from the Apache policy except the 'helper' type.

A simple example policy with a domain and exec type:

Def Block example []
	Def Type self
	Def Type exec

This defines the policy 'example' and defines two types under it
'self' and 'exec'. This would be similar to the following in
refpolicy:

policy_module(example, 1.0.0)

type example_t;		<-- Def Type self
type example_exec_t;	<-- Def Type exec

'self' is a special type for the name of the block you are in. Also,
the types are namespaced to the block they are defined in. The
namespacing is what allows copying to work intelligently:

copy /(Block example []) => Block myexample []

This produces a 'myexample' policy similar to this refpolicy:

policy_module(myexample, 1.0.0)

type myexample_t;	<-- Def Type self
type myexample_exec_t;	<-- Def Type exec

An example of something like an interface from refpolicy:

Def Block example []
	Def Type self
	Def Type exec

	Def Block exec [(Type source)]
		Def Allow:Type (Type source) (Type exec) /(Class file)/(Permission
execute_no_trans)

Here I have defined an 'example' policy, but added an sub-block 'exec'
which takes one parameter 'source' and gives 'source' access to our
'exec' type. The 'exec' policy block can be called:

Def Type foo
Call /(Block example [])/(Block exec [Type]) [(Type foo)]

I've defined a type 'foo', selected the block I want to call, and then
passed 'foo' as the parameter.

An interesting possibility in CIL is that abstract application policy
for all applications that need to have a domain, exec type, an exec
interface, etc. can be defined. Then a policy writer can just use the
copy transformation to create a specific version and add/remove any
additional policy that is needed. The net result should be a much more
concise system policy.

Hopefully this has been thought provoking ;o} I appreciate any
feedback you have!

Thanks,

Caleb

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
