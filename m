Subject: Re: [RFC] Common Intermediary Language
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Caleb Case <ccase@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        mgoldman@tresys.com, jbrindle@tresys.com
In-Reply-To: <150846cc0907151246p41a89391yf0dc1ebde25841c7@mail.gmail.com>
References: <150846cc0907141021k36388ef8h31ff3b24609d2ea6@mail.gmail.com>
	 <1247603655.2551.14.camel@moss-lions.epoch.ncsc.mil>
	 <150846cc0907151246p41a89391yf0dc1ebde25841c7@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 17 Jul 2009 11:44:41 -0400
Message-Id: <1247845481.9257.143.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-15 at 15:46 -0400, Caleb Case wrote:
> On Tue, Jul 14, 2009 at 4:34 PM, James Carter<jwcart2@tycho.nsa.gov> wrote:
> > On Tue, 2009-07-14 at 13:21 -0400, Caleb Case wrote:

> >
> > Did you just want comments on the general description given above at
> > this time, or are you planning on sending a more detailed proposal to
> > the list?
> 
> I was hoping to introduce the basic ideas of the CIL and get some
> feedback on them. After that I was intending to send a more detailed
> proposal for the language (including the grammer and syntax).
> 
> Any comments you have are greatly appreciated!
> 
> >
> > Some examples to show what the CIL would look like might be helpful.
> 
> Without getting too wrapped around the axle with details (or syntax),
> here is an example of removing an rule:
> 
> del /*/(Allow:Type * * /(Class file)/(Permission execute))
> 
> First, 'del' is the delete transform, so we are deleting whatever
> follows. Second, '/' begins a selection, in this case we are selecting
> all of the TE allow rules. Specifically, it selects all allow rules
> with any source or target with the class 'file' and the permission
> 'execute'. The effect of this transformation is that any allow rules
> that the selection matches will be deleted. Supposing that an allow
> rule had multiple permissions, then only the execute permission would
> be removed.
> 
> Another example, lets say there is an Apache policy provided by the
> distribution policy and you want to create your own kind of Apache
> policy based on it:
> 
> copy /(Block apache []) => Block myapache []
> 
> Maybe you decided that you didn't want everything in the Apache policy:
> 
> copy /(Block apache []) => Block myapache []
>         except Type helper
> 
> This would copy everything from the Apache policy except the 'helper' type.
> 
> A simple example policy with a domain and exec type:
> 
> Def Block example []
> 	Def Type self
> 	Def Type exec
> 
> This defines the policy 'example' and defines two types under it
> 'self' and 'exec'. This would be similar to the following in
> refpolicy:
> 

So "self" wouldn't have any special meaning like it does now?

> policy_module(example, 1.0.0)
> 
> type example_t;		<-- Def Type self
> type example_exec_t;	<-- Def Type exec
> 
> 'self' is a special type for the name of the block you are in. Also,
> the types are namespaced to the block they are defined in. The
> namespacing is what allows copying to work intelligently:
> 
So "self" has special meaning for a block.  Are you saying that it has
the name of the block?  So "allow self t : p c;" would be "allow example
t : p c;"?

> copy /(Block example []) => Block myexample []
> 
> This produces a 'myexample' policy similar to this refpolicy:
> 
> policy_module(myexample, 1.0.0)
> 
> type myexample_t;	<-- Def Type self
> type myexample_exec_t;	<-- Def Type exec
> 

You're not saying that "_t" is going to be automatically added are you?

> An example of something like an interface from refpolicy:
> 
> Def Block example []
> 	Def Type self
> 	Def Type exec
> 
> 	Def Block exec [(Type source)]
> 		Def Allow:Type (Type source) (Type exec) /(Class file)/(Permission
> execute_no_trans)
> 
> Here I have defined an 'example' policy, but added an sub-block 'exec'
> which takes one parameter 'source' and gives 'source' access to our
> 'exec' type. The 'exec' policy block can be called:
> 
> Def Type foo
> Call /(Block example [])/(Block exec [Type]) [(Type foo)]
> 
> I've defined a type 'foo', selected the block I want to call, and then
> passed 'foo' as the parameter.
> 
> An interesting possibility in CIL is that abstract application policy
> for all applications that need to have a domain, exec type, an exec
> interface, etc. can be defined. Then a policy writer can just use the
> copy transformation to create a specific version and add/remove any
> additional policy that is needed. The net result should be a much more
> concise system policy.
> 

This would be nice.

> Hopefully this has been thought provoking ;o} I appreciate any
> feedback you have!
> 

You gave examples of del and copy, and it isn't too hard to imagine how
add would be used, but what would "move" be used for?

How would type hierarchies be supported?

If something like type inheritance was added to the kernel, what, if
anything, would need to change in the CIL to support it?

I can see how if I had a type A that accessed type B and I have another
type C that also needed to access type B, that I could copy A's block
and use it for C.  But what if A accesses B and I have a type C that
needs to do similar accesses on D?

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
