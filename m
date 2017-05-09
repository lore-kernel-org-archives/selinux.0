Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49FLmup014274
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 11:21:49 -0400
Received: by mail-qt0-f177.google.com with SMTP id n4so3609950qte.2
 for <selinux@tycho.nsa.gov>; Tue, 09 May 2017 08:21:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
From: Karl MacMillan <karlwmacmillan@gmail.com>
In-Reply-To: <20170508204053.GC7367@julius>
Date: Tue, 9 May 2017 11:21:23 -0400
Cc: selinux@tycho.nsa.gov
Message-Id: <DFEFDD50-622F-4563-BE88-114B90B49B8F@gmail.com>
References: <20170506161956.GA20145@julius> <20170506171920.GB20145@julius>
 <590F3B98.406@quarksecurity.com> <20170507154759.GA31890@julius>
 <590F78BA.5040800@quarksecurity.com> <20170508085555.GA3701@julius>
 <20170508093229.GB3701@julius>
 <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
 <20170508194931.GB7367@julius>
 <8AE6E08C-5E9B-4166-AD82-EB57DF4CAE5C@gmail.com>
 <20170508204053.GC7367@julius>
To: Dominick Grift <dac.override@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


> On May 8, 2017, at 4:40 PM, Dominick Grift <dac.override@gmail.com> wrote:
> 
> On Mon, May 08, 2017 at 04:09:16PM -0400, Karl MacMillan wrote:
>> 
>>> On May 8, 2017, at 3:49 PM, Dominick Grift <dac.override@gmail.com> wrote:
>>> 
>>> On Mon, May 08, 2017 at 03:36:21PM -0400, Karl MacMillan wrote:
>>>> 
>>>>> 
>>>> 
>>>> I think it’s best to think of these as having three basic layers:
>>>> 
>>>> 1. Basic tools for SELinux policy analysis in Jupyter - these are usable for any policy and make no assumptions about the presence of any types, attributes, object classes, or permissions. So things like the rule searching and information flow analysis fit into this group. This is a large part of the value of SPAN.
>>>> 
>>>> 2. Higher-level policy analysis methods - these are things like the domain_types method and the domain / type summaries. These make some minimal assumptions about attributes like domain. I’ll just mention that these assumptions are very minimal and have been around for a _long_ time. Domain long pre-dates the reference policy, for example. More than attributes this layer is tied to the Linux object classes and permissions.
>>>> 
>>>> 3. Example notebooks - the two example notebooks are just that - examples. They probably provide a useful starting point, but as Josh points out, should simply be modified for your specific use case.
>>>> 
>>>> So the question, then, is should the second layer (the higher-level policy analysis methods) be made configurable. Honestly I think it would be more work than just creating your own versions for a policy that breaks the assumptions. To me, that’s the great advantage of this versus other analysis tools. It’s so simple to create quick tools that meet your needs. And given that the vast majority of Linux and Android systems meet the assumptions I think that this is a reasonable approach.
>>> 
>>> I don't think it will work with android. Some of it maybe but not all of it. for example the source functionality appends "modules" to the search path. So i suspect that will break that functionality for Android.
>> 
>> We’ve not tested it for Android policies so I’m sure there will be some breakage. But I hope it will be fixed to work by us or someone soon.
>> 
>>> Thank you for giving me your opinion. At least now I know where I stand.
>> 
>> Where you stand? I’m not certain what you mean and was not trying to say something about you personally.
> 
> I didnt take it personal, That is not what I meant. To me SELinux is bigger then any single policy be it refpolicy, sepolicy, or dssp
> The perfect tool would support any policy (setools goes a long way there). From your comments I sensed that you might not fully agree with that or that you might not have the ambition for SPAN to be perfect.
> What I am saying is that after your comment I no longer have any illusions that SPAN will ever be perfect (or close to perfect)
> 

Shrug. SELinux is “bigger” than the current set of object classes and access vectors or the components of the security context. Yet we still have to write policy using those. Abstraction is a useful tool, but too much abstraction interferes with getting work done clearly.

Ultimately SPAN has to make some assumptions about how policy works to do any higher-level analysis (a problem that SETools doesn’t really have because it doesn’t do much of the higher-level analysis that I’m talking about). Making that somewhat configurable is fine, but not at the cost of comprehensibility. When we hit that point it’s better just to split the higher-level analysis methods into different versions based the policy type.

Either way, I’m open to including the customizations or separate code in SPAN.

>> 
>> I was not familiar with DSSP before (I’ve not done much with SELinux for a while), but Josh pointed it out to me. From looking at it very briefly and thinking through the assumptions in SPAN my guess is that it would take very few changes to make SPAN work with DSSP, even the source policy stuff (which, honestly, is just a very small part mainly useful for diffing constraints).
>> 
>> And as a side note - it’s nice to see someone trying to write a policy from scratch in CIL. Do you have a “domain” attribute or at least a similar concept?
> 
> Sure, but i cannot use "domain" for this because DSSP leverages namespaces. The equivalent in DSSP is “subj.subj_type_attribute"
> 

This is just my opinion of course, but it seems counterproductive to put what is clearly a global concept into a namespace. And _every_ policy that I know of for something like two decades has had a domain attribute. Do you really get enough benefits out of this change to outweigh the pain caused by changing such a long-running convention?

> So if the configuration file would have something like:
> 
> # process_types = domain
> 
> Then i would be happy because then i could edit it like:
> 
> process_types = subj.subj_type_attribute
> 

I just committed a change that adds a domain_attribute instance variable into the Policy class, allowing you to change this. You would use it like this:

p = span.load_policy(“some_dssp_policy.cil”)
p.domain_attribute = “subj.subj_type_attribute”
p.domain_types() # This now looks for the subj.subj_type_attribute instead of domain

If you want to send patches for similar changes I’ll be happy to review them.

Note that a configuration file is not really appropriate I don’t think. This is a Python library and it’s better to just do the configuration in code. If you have several changes that are needed for a dssp policy feel free to propose a load_dssp_policy top-level function that sets the defaults as necessary.

>> 
>>> I will not be able to leverage this solution to any significant extend, and the notebook and its depenedencies are pretty expensive to have just for something that only works to some extent.
>> 
>> I’m curious what you mean by “only works to some extent”. Any bug reports would be welcome.
> 
> Let me rephrase then: "not to the fullest extent"
> 
> But you gave me the impression that not all bug reports would be "welcome" when you said: "the vast majority of Linux and Android systems meet the assumptions I think that this is a reasonable approach.”
> 

These are not “bugs” they are design decisions to prioritize the policies that are on shipping systems.

I’m open to contributions, but can’t really add support for DSSP on my own as I have no experience with it.

>> 
>> And if you mean specifically in the context of DSSP, like I said I bet the changes would be minimal. So if you are interested in giving it a try I’ll be happy to look at the changes needed and give you a hand.
> 
> I agree, and ive said that when I said: "a few rough edges" Its close the usable with DSSP. It just needs to deal with some of the current assumptions:
> 
> ill point out some:
> 
> 1. return self.grep(name, "*.te", self.modules_path) # what about .cil suffixed files?
> 2. return self.find_def("attribute " + name) # in CIL this is typeattribute
> 3. return self.grep(type_name, "*.fc", self.modules_path) # CIL has its context specs in the .cil suffixed file
> 4. 
> return self.diff_relative("/policy/mls", other_source) # these should be customizable
> return self.diff_relative("/policy/mcs", other_source) # these should be customizable
> return self.diff_relative("/policy/constraints", other_source) # these should be customizable

These are from the small policy source object - which is very tied to reference policy. I’ve just renamed that to RefPolicySource. Feel free to send a patch to add a DsspPolicySource.

> 5. any references to type attributes should be customizable: ie. process_types = ... filesystem_types = … etc
> 

The only one I really saw was domain, which I’ve made configurable. But I didn’t search exhaustively. Again, feel free to send patches.

Thanks - Karl

>> 
>> Thanks - Karl
>> 
>>> Atleast this inspired me to implement policy for pip and notebook in my personal security policy. So it was not all in vain.
>>> 
>>>> 
>>>> Thanks - Karl
>>>> 
>>>>> 
>>>>>> 
>>>>>> -- 
>>>>>> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
>>>>>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02> <https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02>>
>>>>>> Dominick Grift
>>>>> 
>>>>> 
>>>>> 
>>>>> -- 
>>>>> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
>>>>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02> <https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02>>
>>>>> Dominick Grift
>>>> 
>>> 
>>> -- 
>>> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
>>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02>
>>> Dominick Grift
>> 
> 
> -- 
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
