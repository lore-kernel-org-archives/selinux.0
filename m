Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HL159q030106
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 17:01:05 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HL15FN023291
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 21:01:05 GMT
Subject: Re: [POLICYREP] [RFC/PATCH 1/3] policy package class
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <469D27B2.7020903@manicmethod.com>
References: <20070717150336.135143158@manicmethod.com>
	 <20070717150405.334131301@manicmethod.com>
	 <1184686310.3833.3.camel@localhost.localdomain>
	 <469CECFF.5030506@manicmethod.com>
	 <1184697024.3833.22.camel@localhost.localdomain>
	 <469D27B2.7020903@manicmethod.com>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 17:01:02 -0400
Message-Id: <1184706062.10625.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2007-07-17 at 16:33 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Tue, 2007-07-17 at 12:23 -0400, Joshua Brindle wrote:
> >   
> >> Karl MacMillan wrote:
> >>     
> >>> On Tue, 2007-07-17 at 11:03 -0400, method@manicmethod.com wrote:
> >>>   
> >>>       
> >>>> plain text document attachment (00-policy_package-header.patch)
> >>>> --
> >>>>
> >>>> --- a/libpolicyrep/include/policyrep/policy_package.hpp	(revision 0)
> >>>> +++ b/libpolicyrep/include/policyrep/policy_package.hpp	(revision 0)
> >>>> @@ -0,0 +1,38 @@
> >>>> +/* Author: Joshua Brindle <method@manicmethod.com> */
> >>>> +
> >>>> +#ifndef __policy_package_hpp__
> >>>> +#define __policy_package_hpp__
> >>>> +
> >>>> +
> >>>> +#include <policyrep/policy.hpp>
> >>>> +
> >>>> +namespace policyrep
> >>>> +{
> >>>> +	struct PolicyPackageImpl;
> >>>> +	class PolicyPackage
> >>>> +	{
> >>>> +	public:
> >>>> +		PolicyPackage();
> >>>> +		PolicyPackage(std::string filename);
> >>>> +		~PolicyPackage();
> >>>> +
> >>>>     
> >>>>         
> >>> Destructors should always be virtual - otherwise subclassing is
> >>> difficult.
> >>>   
> >>>       
> >> I don't think there is any reason to ever subclass a policy package. Its 
> >> different from the ast components.
> >>     
> >
> > Except that if the destructor is not virtual you cannot effectively
> > subclass without breaking binary compatibility. Also - in this case
> > there is no real downside to virtual by default, so why not do it?
> >
> >   
> 
> Fine.
> 
> >>>   
> >>>       
> >>>> +		const Module get_policy_module() const;
> >>>> +
> >>>> +		const std::string get_file_contexts() const;
> >>>> +		const std::string get_seusers() const;
> >>>> +		const std::string get_user_extra() const;
> >>>> +		const std::string get_netfilter_contexts() const;
> >>>> +
> >>>>     
> >>>>         
> >>> why not const std::string&? I also think we should always default to
> >>> virtual.
> >>>
> >>>   
> >>>       
> >> because this won't be subclassed I don't think these should be virtual.
> >>
> >>     
> >
> > See above. What about the return type, though?
> >
> >   
> 
> I just don't see it as advantageous, since functions aren't part of the 
> mangled class struct the ABI won't change if they are added later as 
> virtuals (assuming there is no other virtuals below that will change 
> alignment and everything else is private).

Not certain what you mean, but you can't convert a function to virtual
later and retain ABI.

>  Also, if we determine that, 
> e.g. seusers have no business in modules we can remove the functions 
> without destroying the rest of the function alignments which will only 
> affect the API not the ABI,

Err - of course it will effect the ABI. The runtime behavior will be
_vastly_ different. It is, I think, better to break ABI in these cases
so that you don't get undefined runtime behavior.

>  for this reason I'd prefer to avoid virtuals 
> unless there is a real possibility of the class being subclassed.
> 

But there is at least some chance - what if I want to create a different
kind of package? Or a fake package that is just some files on disk? The
whole point is that a class that the potential of subclassing adds real
flexibility to the code.

> On the std::string&, I've seen arguments against making std::strings 
> pointers because then you don't need to deal with initialization and the 
> string data itself is on the heap anyway, whats the advantage to making 
> these pointers?

Umm - I'm suggesting that you should return references not pointers. It
avoids copies and allows the caller to change the strings.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
