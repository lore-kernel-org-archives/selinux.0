Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HGeYxv004695
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 12:40:34 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l6HGeXFN008089
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 16:40:33 GMT
Message-ID: <469CF0EC.8030704@manicmethod.com>
Date: Tue, 17 Jul 2007 12:40:12 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [POLICYREP] [RFC/PATCH 2/3] policy package implementation
References: <20070717150336.135143158@manicmethod.com>	 <20070717150431.660417962@manicmethod.com> <1184686730.3833.11.camel@localhost.localdomain>
In-Reply-To: <1184686730.3833.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
>
>> +
>> +namespace policyrep
>> +{
>> +
>> +	struct PolicyPackageImpl {
>> +		Module policy_module;
>>     
>
> Are you sure you want this by value?
>
>   
oops, yes, fixed.

>> +		std::string file_contexts;
>> +		std::string seusers;
>> +		std::string user_extra;
>> +		std::string netfilter_contexts;
>> +	};
>> +
>> +	void PolicyPackage::init() {
>> +		impl = new PolicyPackageImpl;
>> +	}
>> +
>>     
>
> I prefer to order the .cpp file in the same order functions are declared
> in the class. I think it makes it easier to find the function you want.
>
>   

I reordered them, I was still use to having to order based on usage 
(eg., read_package first since its called from one of the constructors.. 
silly C habits :\)

>> +	int PolicyPackage::read_package(std::string filename) {
>> +		xar_t x;
>> +		xar_file_t f;
>> +		xar_iter_t i;
>> +
>> +		i = xar_iter_new();
>> +		if (i == NULL) {
>> +			throw "Unable to allocate iterator";
>>     
>
> Ick - no string exceptions please. Either use an exception in stdexcept
> or define a new one (std::bad_alloc is appropriate here).
>
>   
fixed.

>> +		}
>> +
>> +		x = xar_open(filename.c_str(), READ);
>> +		if (x == NULL) {
>> +			throw "Unable to open policy package";
>> +		}
>> +
>> +		for (f = xar_file_first(x, i); f; f = xar_file_next(i)) {
>> +			size_t sz;
>> +			char *fbuf;
>> +			const char *filename;			
>> +			int32_t ret;
>> +			
>> +			ret = xar_extract_tobuffersz(x, f, &fbuf, &sz);
>> +			if (ret) {
>> +				// This can happen if the file is 0 bytes 
>> +				// or is a symlink, directory, etc. We might want 
>> +				// to put code here to check those cases and bail 
>> +				// but for now we just ignore them and continue.
>> +				continue;
>> +			}
>> +
>> +
>> +			// Currently we use the name of the file to decide what kind of file it is
>> +			// I am fairly uncomfortable with this but it allows us to use xar to create
>> +			// policy packages instead of having our own write_package function that 
>> +			// assigns attributes to files instead of using names. 
>>     
>
> I don't like this either - what is the alternative?
>
>   

Ok, xar has an XML ToC for the file. It also provides an API to set 
arbitrary attributes for each file, so I can do something like 
selinuxfiletype = netfilter_contexts. This means that we would not be 
able to use the command line xar to create packages (I was trying to 
make this as simple as possible). If we move to using attributes we'd 
have to have a custom packager again (ala semodule_package).

A custom packager has advantages, we can basically ensure that the 
package is sane (doesn't have directory trees or multiple 
<something>.netfilter_contexts files, etc. We can also add new 
properties such as the policy name to the xar XML subdocument.

>> +			ret = xar_prop_get(f, "name", &filename);
>> +			if (ret) {
>> +				xar_close(x);
>> +				throw "Error getting name property of file";
>>     
>
> Please define an exception.
>
>   
Why?

>> +			}
>> +			if (strstr(filename, ".mod")) {
>> +				// found module, do stuff
>>     
>
> Err - "do stuff"?
>
>   
There is no module_read function right now so thats just a placeholder.

>> +			} else if (strstr(filename, ".file_contexts")) {
>> +				if (!impl->file_contexts.empty()) {
>> +					// Found more than one file containing in .file_contexts,
>> +					// don't know how to handle that so bail for now
>> +					xar_close(x);
>> +					throw "Multiple file_contexts files in policy package";
>> +				}
>> +				impl->file_contexts = std::string(fbuf);
>> +			} else if (strstr(filename, ".seusers")) {
>> +				if (!impl->seusers.empty()) {
>> +					// Found more than one file containing in .seusers,
>> +					// don't know how to handle that so bail for now
>> +					xar_close(x);
>> +					throw "Multiple seusers files in policy package";
>> +				}
>> +				impl->seusers = std::string(fbuf);
>>     
>
> As we discussed privately - these copies are not great. Perhaps just use
> raw char*.
>
>   

Ok, I don't know if this code is ever going to do anything with those 
and was trying to keep it in a format that would be more accessible if 
we needed to. I can change to char * though and see if anything develops 
that makes std::string make more sense.

>> +			} else if (strstr(filename, ".user_extra")) {
>> +				if (!impl->user_extra.empty()) {
>> +					// Found more than one file containing in .user_extra,
>> +					// don't know how to handle that so bail for now
>> +					xar_close(x);
>> +					throw "Multiple user_extra files in policy package";
>> +				}
>> +				impl->user_extra = std::string(fbuf);
>> +			} else if (strstr(filename, ".netfilter_contexts")) {
>> +				if (!impl->netfilter_contexts.empty()) {
>> +					// Found more than one file containing in .netfilter_contexts,
>> +					// don't know how to handle that so bail for now
>> +					xar_close(x);
>> +					throw "Multiple netfilter_contexts files in policy package";
>> +				}
>> +				impl->netfilter_contexts = std::string(fbuf);
>> +			} else {
>> +				// unrecognized file, just skip it
>> +				continue;
>> +			}
>> +
>> +		}
>> +
>> +		xar_close(x);
>> +
>> +		return 0;
>> +	}
>> +
>> +	PolicyPackage::PolicyPackage() {
>> +		init();
>> +	}
>> +
>> +	PolicyPackage::PolicyPackage(std::string filename) {
>> +		init();
>> +		read_package(filename);
>> +	}
>> +
>> +	PolicyPackage::~PolicyPackage() { delete impl; }
>> +
>> +	const Module PolicyPackage::get_policy_module() const {
>> +		return impl->policy_module;
>> +	}
>>     
>
> This should definitely not be by value. It should also likely not be
> const - this is how the user will retrieve the module after reading to
> use, correct? Then it shouldn't be const (they might want to much with
> it), should be a reference, and shouldn't be const for the class (as
> allowing users to change the module changes the object).
>
>   
Fair enough. I was basically thinking users would read a module and make 
their own copies (eg., copying the data into a merged copy or something) 
but that isn't really how policyrep works so I'll change all these to be 
non-const.

>> +
>> +	const std::string PolicyPackage::get_file_contexts() const {
>> +		return impl->file_contexts;
>> +	}
>> +
>> +	const std::string PolicyPackage::get_seusers() const {
>> +		return impl->seusers;
>> +	}
>> +
>> +	const std::string PolicyPackage::get_user_extra() const {
>> +		return impl->user_extra;
>> +	}
>> +
>> +	const std::string PolicyPackage::get_netfilter_contexts() const {
>> +		return impl->netfilter_contexts;
>> +	}
>> +
>>     
>
> Ditto.
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
