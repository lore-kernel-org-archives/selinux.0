Message-ID: <465C7C3E.7080206@tycho.nsa.gov>
Date: Tue, 29 May 2007 15:17:18 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] libselinux: Namespacing
References: <1178827922.3504.141.camel@moss-spartans.epoch.ncsc.mil>	 <1178829062.24335.86.camel@localhost.localdomain>	 <1178887062.3504.147.camel@moss-spartans.epoch.ncsc.mil> <1178908626.11064.18.camel@localhost.localdomain>
In-Reply-To: <1178908626.11064.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Fri, 2007-05-11 at 08:37 -0400, Stephen Smalley wrote:
>> On Thu, 2007-05-10 at 16:31 -0400, Karl MacMillan wrote:
>>> On Thu, 2007-05-10 at 16:12 -0400, Stephen Smalley wrote:
>>>> libselinux presently lacks proper namespacing of its functions.  This
>>>> patch is just for comment on an approach to gradually fixing that
>>>> problem, starting with just a trivial example for a single function.
>>>> The idea is to switch over the real function to being properly
>>>> namespaced, provide an alias under the old name in the symbol table for
>>>> binary compatibility, and make the old name a macro in the public
>>>> headers that expands to the new name so that source rebuilds against the
>>>> new library will start using the new name.  Then at some point in the
>>>> future, we drop the old name macro from the source API, forcing an
>>>> update to external sources to build against newer headers, while leaving
>>>> the alias present in the symbol table as long as we need compatibility
>>>> with existing binaries.  Thoughts?
>>>>
>>> Sounds good to me - will this impact the python bindings? If we do have
>>> to change the bindings we should take as an opportunity to fix the
>>> namespace issues there. For example, bo reason to have
>>> selinux.selinux_booleans_path - should be changed to
>>> selinux.booleans_path.
>> Yes, it would affect the python bindings too; not sure what needs to be
>> done there for backward compatibility.
>>
> 
> Shouldn't be hard to provide the backwards compatibility - either
> through swig or a pure python module.
> 
>> We also have to decide what to do about functions that already have
>> their own prefix, like the security_ functions and the avc_ functions;
>> I'm inclined to leave those alone as already being adequately
>> namespaced.
>>
> 
> I'd vote for changing them. The consistency is nice in general (I'm not
> certain that it is obvious enough to everyone which prefix applies to
> which function) and it will make wrapping in languages that support
> proper namespacing simpler.

I'm fine with changing over the security_ stuff but what to do for the 
avc stuff?  Either a double prefix selinux_avc_ which is kind of long, 
or drop the _avc_ in which case there is a conflict between 
security_compute_create and avc_compute_create.  Maybe "seavc_"?

Same question about the labeling interface I have in the works, which 
would introduce a bunch of functions prefixed "selabel_".


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
