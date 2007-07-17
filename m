Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HKYIOX027969
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 16:34:18 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l6HKYGTM027216
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 20:34:17 GMT
Message-ID: <469D27B2.7020903@manicmethod.com>
Date: Tue, 17 Jul 2007 16:33:54 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [POLICYREP] [RFC/PATCH 1/3] policy package class
References: <20070717150336.135143158@manicmethod.com>	 <20070717150405.334131301@manicmethod.com>	 <1184686310.3833.3.camel@localhost.localdomain>	 <469CECFF.5030506@manicmethod.com> <1184697024.3833.22.camel@localhost.localdomain>
In-Reply-To: <1184697024.3833.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Tue, 2007-07-17 at 12:23 -0400, Joshua Brindle wrote:
>   
>> Karl MacMillan wrote:
>>     
>>> On Tue, 2007-07-17 at 11:03 -0400, method@manicmethod.com wrote:
>>>   
>>>       
>>>> plain text document attachment (00-policy_package-header.patch)
>>>> --
>>>>
>>>> --- a/libpolicyrep/include/policyrep/policy_package.hpp	(revision 0)
>>>> +++ b/libpolicyrep/include/policyrep/policy_package.hpp	(revision 0)
>>>> @@ -0,0 +1,38 @@
>>>> +/* Author: Joshua Brindle <method@manicmethod.com> */
>>>> +
>>>> +#ifndef __policy_package_hpp__
>>>> +#define __policy_package_hpp__
>>>> +
>>>> +
>>>> +#include <policyrep/policy.hpp>
>>>> +
>>>> +namespace policyrep
>>>> +{
>>>> +	struct PolicyPackageImpl;
>>>> +	class PolicyPackage
>>>> +	{
>>>> +	public:
>>>> +		PolicyPackage();
>>>> +		PolicyPackage(std::string filename);
>>>> +		~PolicyPackage();
>>>> +
>>>>     
>>>>         
>>> Destructors should always be virtual - otherwise subclassing is
>>> difficult.
>>>   
>>>       
>> I don't think there is any reason to ever subclass a policy package. Its 
>> different from the ast components.
>>     
>
> Except that if the destructor is not virtual you cannot effectively
> subclass without breaking binary compatibility. Also - in this case
> there is no real downside to virtual by default, so why not do it?
>
>   

Fine.

>>>   
>>>       
>>>> +		const Module get_policy_module() const;
>>>> +
>>>> +		const std::string get_file_contexts() const;
>>>> +		const std::string get_seusers() const;
>>>> +		const std::string get_user_extra() const;
>>>> +		const std::string get_netfilter_contexts() const;
>>>> +
>>>>     
>>>>         
>>> why not const std::string&? I also think we should always default to
>>> virtual.
>>>
>>>   
>>>       
>> because this won't be subclassed I don't think these should be virtual.
>>
>>     
>
> See above. What about the return type, though?
>
>   

I just don't see it as advantageous, since functions aren't part of the 
mangled class struct the ABI won't change if they are added later as 
virtuals (assuming there is no other virtuals below that will change 
alignment and everything else is private). Also, if we determine that, 
e.g. seusers have no business in modules we can remove the functions 
without destroying the rest of the function alignments which will only 
affect the API not the ABI, for this reason I'd prefer to avoid virtuals 
unless there is a real possibility of the class being subclassed.

On the std::string&, I've seen arguments against making std::strings 
pointers because then you don't need to deal with initialization and the 
string data itself is on the heap anyway, whats the advantage to making 
these pointers?
>>>> +	protected:
>>>> +		void init();
>>>> +		int read_package(std::string filename);	
>>>> +
>>>> +	private:
>>>> +		PolicyPackageImpl* impl;
>>>>     
>>>>         
>>> We need to make a decision on whether this is going to be protected or
>>> private and stick with that. I've done protected so far - if you want to
>>> change it please say why and send a patch changing all existing classes.
>>>
>>>   
>>>       
>> Same argument. If this isn't subclassed it shouldn't be protected, other 
>> classes are different that way.
>>     



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
