Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HIUSlj016315
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 14:30:28 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HIUQFN027054
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 18:30:26 GMT
Subject: Re: [POLICYREP] [RFC/PATCH 1/3] policy package class
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <469CECFF.5030506@manicmethod.com>
References: <20070717150336.135143158@manicmethod.com>
	 <20070717150405.334131301@manicmethod.com>
	 <1184686310.3833.3.camel@localhost.localdomain>
	 <469CECFF.5030506@manicmethod.com>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 14:30:24 -0400
Message-Id: <1184697024.3833.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-17 at 12:23 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Tue, 2007-07-17 at 11:03 -0400, method@manicmethod.com wrote:
> >   
> >> plain text document attachment (00-policy_package-header.patch)
> >> --
> >>
> >> --- a/libpolicyrep/include/policyrep/policy_package.hpp	(revision 0)
> >> +++ b/libpolicyrep/include/policyrep/policy_package.hpp	(revision 0)
> >> @@ -0,0 +1,38 @@
> >> +/* Author: Joshua Brindle <method@manicmethod.com> */
> >> +
> >> +#ifndef __policy_package_hpp__
> >> +#define __policy_package_hpp__
> >> +
> >> +
> >> +#include <policyrep/policy.hpp>
> >> +
> >> +namespace policyrep
> >> +{
> >> +	struct PolicyPackageImpl;
> >> +	class PolicyPackage
> >> +	{
> >> +	public:
> >> +		PolicyPackage();
> >> +		PolicyPackage(std::string filename);
> >> +		~PolicyPackage();
> >> +
> >>     
> >
> > Destructors should always be virtual - otherwise subclassing is
> > difficult.
> >   
> 
> I don't think there is any reason to ever subclass a policy package. Its 
> different from the ast components.

Except that if the destructor is not virtual you cannot effectively
subclass without breaking binary compatibility. Also - in this case
there is no real downside to virtual by default, so why not do it?

> >   
> >> +		const Module get_policy_module() const;
> >> +
> >> +		const std::string get_file_contexts() const;
> >> +		const std::string get_seusers() const;
> >> +		const std::string get_user_extra() const;
> >> +		const std::string get_netfilter_contexts() const;
> >> +
> >>     
> >
> > why not const std::string&? I also think we should always default to
> > virtual.
> >
> >   
> because this won't be subclassed I don't think these should be virtual.
> 

See above. What about the return type, though?

> >> +	protected:
> >> +		void init();
> >> +		int read_package(std::string filename);	
> >> +
> >> +	private:
> >> +		PolicyPackageImpl* impl;
> >>     
> >
> > We need to make a decision on whether this is going to be protected or
> > private and stick with that. I've done protected so far - if you want to
> > change it please say why and send a patch changing all existing classes.
> >
> >   
> 
> Same argument. If this isn't subclassed it shouldn't be protected, other 
> classes are different that way.
> >> +	};
> >> +
> >> +	typedef boost::shared_ptr<PolicyPackage> PolicyPackagePtr;
> >> +
> >>     
> >
> > This may not be needed here - it is currently only definitely used for
> > objects that are part of the ast.
> >
> >   
> 
> I like it, it will enable users to have several pointers to the package 
> and have them dealt with correctly. Do you disagree?
> 

No - I was just noting that it wasn't strictly necessary. If you find it
useful I'm fine with it.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
