Message-ID: <44C51644.3000705@gentoo.org>
Date: Mon, 24 Jul 2006 14:49:40 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joe Nall <joe@nall.com>, Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        David Quigley <dpquigl@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
Subject: Re: Existence of "helper" functions (specifcally MLS)
References: <44BFECE8.80501@us.ibm.com>	 <1153748747.1641.18.camel@moss-terrapins.epoch.ncsc.mil>	 <A5B53838-B8A8-47B0-9E4A-72A794702EBD@nall.com>	 <1153751437.6122.74.camel@moss-spartans.epoch.ncsc.mil>	 <3CA9DB29-D76C-41BE-ABE7-2F710F6658D2@nall.com>	 <1153755260.6122.85.camel@moss-spartans.epoch.ncsc.mil>	 <FA715F0C-F9E5-4F23-807A-A3F97F1402A3@nall.com> <1153765166.6122.107.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1153765166.6122.107.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-07-24 at 11:48 -0500, Joe Nall wrote:
>   
>>> The relationship between s0 and s1 is not implicit in the names; s0
>>> could dominate s1; that is entirely defined by the policy itself.
>>>       
>> I had totally missed that. I mapped the s[n] to the integers we
>> use on the CMW without any thought that they were arbitrary.
>>     
>
> There is an explicit dominance definition in the policy that establishes
> the relationship.
>
>   
>> We have an application that combines data of multiple levels and has to
>> compute the aggregate classification before saving it to a file or  
>> sharing
>> it with another process. Will there be a function to compute an  
>> aggregate
>> context from a list of contexts?
>>     
>
>   
This sounds like you want to ditch TE altogether and revert to MLS 
entirely. That is, it seems like you have to since there is no such 
thing as an aggregate type. How could we possibly reconcile the user, 
role and type fields in a list of contexts? This seems like an enormous 
step backward and makes the application (whatever it is) incapable of 
using the stronger points of SELinux and from being applied to 
environments outside of the miltary/government realm.

I wonder if the hierarchal namespace for  roles and types could be 
useful here.. that would impose even more limitations on what the 
contexts could look like though but its probably better than simply 
ignoring those parts of the context.

> For that kind of specialized application, I suspect we'd create an
> interface to libsepol for that purpose rather than extending the kernel
> interface.  The other issue for that kind of function is whether the
> label encoding library needs to be brought into play to deal with
> complex relationships among the compartments that only it presently
> knows about (which ideally the kernel would understand too, but that
> isn't presently the case).
>   

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
