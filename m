Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HFcsfS030193
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 11:38:54 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HFcrQA027138
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 15:38:53 GMT
Subject: Re: [POLICYREP] [RFC/PATCH 2/3] policy package implementation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: method@manicmethod.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070717150431.660417962@manicmethod.com>
References: <20070717150336.135143158@manicmethod.com>
	 <20070717150431.660417962@manicmethod.com>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 11:38:49 -0400
Message-Id: <1184686730.3833.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-17 at 11:03 -0400, method@manicmethod.com wrote:
> plain text document attachment (01-policy_package.diff)
> --
> 
> --- a/libpolicyrep/src/policy_package.cpp	(revision 0)
> +++ b/libpolicyrep/src/policy_package.cpp	(revision 0)
> @@ -0,0 +1,166 @@
> +/*
> + * Author : Joshua Brindle <jbrindle@tresys.com>
> + *
> + * Copyright (C) 2007 Tresys Technology, llc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +
> +extern "C" {
> +#include <xar/xar.h>
> +#include <string.h>
> +}
> +
> +#include <policyrep/policy.hpp>
> +#include <policyrep/policy_package.hpp>
> +
> +#include <sstream>
> +#include <iostream>
> +
> +namespace policyrep
> +{
> +
> +	struct PolicyPackageImpl {
> +		Module policy_module;

Are you sure you want this by value?

> +		std::string file_contexts;
> +		std::string seusers;
> +		std::string user_extra;
> +		std::string netfilter_contexts;
> +	};
> +
> +	void PolicyPackage::init() {
> +		impl = new PolicyPackageImpl;
> +	}
> +

I prefer to order the .cpp file in the same order functions are declared
in the class. I think it makes it easier to find the function you want.

> +	int PolicyPackage::read_package(std::string filename) {
> +		xar_t x;
> +		xar_file_t f;
> +		xar_iter_t i;
> +
> +		i = xar_iter_new();
> +		if (i == NULL) {
> +			throw "Unable to allocate iterator";

Ick - no string exceptions please. Either use an exception in stdexcept
or define a new one (std::bad_alloc is appropriate here).

> +		}
> +
> +		x = xar_open(filename.c_str(), READ);
> +		if (x == NULL) {
> +			throw "Unable to open policy package";
> +		}
> +
> +		for (f = xar_file_first(x, i); f; f = xar_file_next(i)) {
> +			size_t sz;
> +			char *fbuf;
> +			const char *filename;			
> +			int32_t ret;
> +			
> +			ret = xar_extract_tobuffersz(x, f, &fbuf, &sz);
> +			if (ret) {
> +				// This can happen if the file is 0 bytes 
> +				// or is a symlink, directory, etc. We might want 
> +				// to put code here to check those cases and bail 
> +				// but for now we just ignore them and continue.
> +				continue;
> +			}
> +
> +
> +			// Currently we use the name of the file to decide what kind of file it is
> +			// I am fairly uncomfortable with this but it allows us to use xar to create
> +			// policy packages instead of having our own write_package function that 
> +			// assigns attributes to files instead of using names. 

I don't like this either - what is the alternative?

> +			ret = xar_prop_get(f, "name", &filename);
> +			if (ret) {
> +				xar_close(x);
> +				throw "Error getting name property of file";

Please define an exception.

> +			}
> +			if (strstr(filename, ".mod")) {
> +				// found module, do stuff

Err - "do stuff"?

> +			} else if (strstr(filename, ".file_contexts")) {
> +				if (!impl->file_contexts.empty()) {
> +					// Found more than one file containing in .file_contexts,
> +					// don't know how to handle that so bail for now
> +					xar_close(x);
> +					throw "Multiple file_contexts files in policy package";
> +				}
> +				impl->file_contexts = std::string(fbuf);
> +			} else if (strstr(filename, ".seusers")) {
> +				if (!impl->seusers.empty()) {
> +					// Found more than one file containing in .seusers,
> +					// don't know how to handle that so bail for now
> +					xar_close(x);
> +					throw "Multiple seusers files in policy package";
> +				}
> +				impl->seusers = std::string(fbuf);

As we discussed privately - these copies are not great. Perhaps just use
raw char*.

> +			} else if (strstr(filename, ".user_extra")) {
> +				if (!impl->user_extra.empty()) {
> +					// Found more than one file containing in .user_extra,
> +					// don't know how to handle that so bail for now
> +					xar_close(x);
> +					throw "Multiple user_extra files in policy package";
> +				}
> +				impl->user_extra = std::string(fbuf);
> +			} else if (strstr(filename, ".netfilter_contexts")) {
> +				if (!impl->netfilter_contexts.empty()) {
> +					// Found more than one file containing in .netfilter_contexts,
> +					// don't know how to handle that so bail for now
> +					xar_close(x);
> +					throw "Multiple netfilter_contexts files in policy package";
> +				}
> +				impl->netfilter_contexts = std::string(fbuf);
> +			} else {
> +				// unrecognized file, just skip it
> +				continue;
> +			}
> +
> +		}
> +
> +		xar_close(x);
> +
> +		return 0;
> +	}
> +
> +	PolicyPackage::PolicyPackage() {
> +		init();
> +	}
> +
> +	PolicyPackage::PolicyPackage(std::string filename) {
> +		init();
> +		read_package(filename);
> +	}
> +
> +	PolicyPackage::~PolicyPackage() { delete impl; }
> +
> +	const Module PolicyPackage::get_policy_module() const {
> +		return impl->policy_module;
> +	}

This should definitely not be by value. It should also likely not be
const - this is how the user will retrieve the module after reading to
use, correct? Then it shouldn't be const (they might want to much with
it), should be a reference, and shouldn't be const for the class (as
allowing users to change the module changes the object).

> +
> +	const std::string PolicyPackage::get_file_contexts() const {
> +		return impl->file_contexts;
> +	}
> +
> +	const std::string PolicyPackage::get_seusers() const {
> +		return impl->seusers;
> +	}
> +
> +	const std::string PolicyPackage::get_user_extra() const {
> +		return impl->user_extra;
> +	}
> +
> +	const std::string PolicyPackage::get_netfilter_contexts() const {
> +		return impl->netfilter_contexts;
> +	}
> +

Ditto.

> +
> +} // namespace policyrep
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
