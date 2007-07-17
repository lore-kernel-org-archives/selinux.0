Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HIZxJP017193
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 14:35:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HIZwFN027679
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 18:35:58 GMT
Subject: Re: [POLICYREP] [RFC/PATCH 2/3] policy package implementation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <469CF0EC.8030704@manicmethod.com>
References: <20070717150336.135143158@manicmethod.com>
	 <20070717150431.660417962@manicmethod.com>
	 <1184686730.3833.11.camel@localhost.localdomain>
	 <469CF0EC.8030704@manicmethod.com>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 14:35:55 -0400
Message-Id: <1184697355.3833.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-17 at 12:40 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
[...]
> >> +			// Currently we use the name of the file to decide what kind of file it is
> >> +			// I am fairly uncomfortable with this but it allows us to use xar to create
> >> +			// policy packages instead of having our own write_package function that 
> >> +			// assigns attributes to files instead of using names. 
> >>     
> >
> > I don't like this either - what is the alternative?
> >
> >   
> 
> Ok, xar has an XML ToC for the file. It also provides an API to set 
> arbitrary attributes for each file, so I can do something like 
> selinuxfiletype = netfilter_contexts. This means that we would not be 
> able to use the command line xar to create packages (I was trying to 
> make this as simple as possible). If we move to using attributes we'd 
> have to have a custom packager again (ala semodule_package).
> 

It would be simpler though, correct? And what about an unpackager?

> A custom packager has advantages, we can basically ensure that the 
> package is sane (doesn't have directory trees or multiple 
> <something>.netfilter_contexts files, etc. We can also add new 
> properties such as the policy name to the xar XML subdocument.
> 

That sounds better than relying on file extension to me.

> >> +			ret = xar_prop_get(f, "name", &filename);
> >> +			if (ret) {
> >> +				xar_close(x);
> >> +				throw "Error getting name property of file";
> >>     
> >
> > Please define an exception.
> >
> >   
> Why?
> 

Because none of the standard exception types seemed to fit and string
exceptions are not a good idea.

> >> +			}
> >> +			if (strstr(filename, ".mod")) {
> >> +				// found module, do stuff
> >>     
> >
> > Err - "do stuff"?
> >
> >   
> There is no module_read function right now so thats just a placeholder.
> 

There is if the module is source :)

> >> +			} else if (strstr(filename, ".file_contexts")) {
> >> +				if (!impl->file_contexts.empty()) {
> >> +					// Found more than one file containing in .file_contexts,
> >> +					// don't know how to handle that so bail for now
> >> +					xar_close(x);
> >> +					throw "Multiple file_contexts files in policy package";
> >> +				}
> >> +				impl->file_contexts = std::string(fbuf);
> >> +			} else if (strstr(filename, ".seusers")) {
> >> +				if (!impl->seusers.empty()) {
> >> +					// Found more than one file containing in .seusers,
> >> +					// don't know how to handle that so bail for now
> >> +					xar_close(x);
> >> +					throw "Multiple seusers files in policy package";
> >> +				}
> >> +				impl->seusers = std::string(fbuf);
> >>     
> >
> > As we discussed privately - these copies are not great. Perhaps just use
> > raw char*.
> >
> >   
> 
> Ok, I don't know if this code is ever going to do anything with those 
> and was trying to keep it in a format that would be more accessible if 
> we needed to. I can change to char * though and see if anything develops 
> that makes std::string make more sense.
> 
> >> +			} else if (strstr(filename, ".user_extra")) {
> >> +				if (!impl->user_extra.empty()) {
> >> +					// Found more than one file containing in .user_extra,
> >> +					// don't know how to handle that so bail for now
> >> +					xar_close(x);
> >> +					throw "Multiple user_extra files in policy package";
> >> +				}
> >> +				impl->user_extra = std::string(fbuf);
> >> +			} else if (strstr(filename, ".netfilter_contexts")) {
> >> +				if (!impl->netfilter_contexts.empty()) {
> >> +					// Found more than one file containing in .netfilter_contexts,
> >> +					// don't know how to handle that so bail for now
> >> +					xar_close(x);
> >> +					throw "Multiple netfilter_contexts files in policy package";
> >> +				}
> >> +				impl->netfilter_contexts = std::string(fbuf);
> >> +			} else {
> >> +				// unrecognized file, just skip it
> >> +				continue;
> >> +			}
> >> +
> >> +		}
> >> +
> >> +		xar_close(x);
> >> +
> >> +		return 0;
> >> +	}
> >> +
> >> +	PolicyPackage::PolicyPackage() {
> >> +		init();
> >> +	}
> >> +
> >> +	PolicyPackage::PolicyPackage(std::string filename) {
> >> +		init();
> >> +		read_package(filename);
> >> +	}
> >> +
> >> +	PolicyPackage::~PolicyPackage() { delete impl; }
> >> +
> >> +	const Module PolicyPackage::get_policy_module() const {
> >> +		return impl->policy_module;
> >> +	}
> >>     
> >
> > This should definitely not be by value. It should also likely not be
> > const - this is how the user will retrieve the module after reading to
> > use, correct? Then it shouldn't be const (they might want to much with
> > it), should be a reference, and shouldn't be const for the class (as
> > allowing users to change the module changes the object).
> >
> >   
> Fair enough. I was basically thinking users would read a module and make 
> their own copies (eg., copying the data into a merged copy or something) 
> but that isn't really how policyrep works so I'll change all these to be 
> non-const.
> 

One other note - if the caller is expected to take ownership for the
lifetime of the object (which seems possible), then it should return a
pointer or a shared_ptr.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
