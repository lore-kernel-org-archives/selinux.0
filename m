Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p89LdTwT006099
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 17:39:29 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p89LdRvK012548
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 21:39:28 GMT
Message-ID: <4E6A8707.9080602@manicmethod.com>
Date: Fri, 09 Sep 2011 17:37:11 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Userspace top-level Makefile (was Re: [PATCH] Fix LIBDIR
 usage for load_policy)
References: <1315587716.2170.16.camel@vortex>  <1315588656.2170.26.camel@vortex>  <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>  <1315590383.2170.32.camel@vortex> <1315591143.2170.36.camel@vortex> <1315603187.2482.22.camel@vortex>
In-Reply-To: <1315603187.2482.22.camel@vortex>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Guido Trentalancia wrote:
> -all install relabel clean test indent:
> +all relabel test indent:
>   	@for subdir in $(SUBDIRS); do \
> -		(cd $$subdir&&  $(MAKE) $@) || exit 1; \
> +		(cd $$subdir&&  $(MAKE) $@&&  $(MAKE) install) || exit 1; \
> +	done
> +	@for subdir_bin in $(SUBDIRS_BIN); do \
> +		(cd $$subdir_bin&&  $(MAKE) $@) || exit 1; \
> +	done
> +
> +install:
> +	@for subdir in $(SUBDIRS); do \
> +		(cd $$subdir&&  $(MAKE) install) || exit 1; \
> +	done
> +	@for subdir_bin in $(SUBDIRS_BIN); do \
> +		(cd $$subdir_bin&&  $(MAKE) install) || exit 1; \
>   	done
>
>   install-pywrap swigify:
> @@ -17,6 +29,14 @@ install-pywrap swigify:
>   		(cd $$subdir&&  $(MAKE) $@) || exit 1; \
>   	done
>

Nack. We can't require install in the build target and bail if it fails, this is 
completely unfriendly to developers who don't want to install all the libraries 
on their system during development, and those are the people using git.

If you are doing work on libselinux and you install it to your system before 
testing it locally you can easily break your machine and have to boot from a 
rescue disk.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
