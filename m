Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8CCfuN8019936
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 08:41:56 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8CCfs3H012085
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 12:41:54 GMT
Message-ID: <4E6DFDE5.2070709@manicmethod.com>
Date: Mon, 12 Sep 2011 08:41:09 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Userspace top-level Makefile (was Re: [PATCH] Fix LIBDIR
 usage for load_policy)
References: <1315587716.2170.16.camel@vortex>	    <1315588656.2170.26.camel@vortex>	    <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>	    <1315590383.2170.32.camel@vortex> <1315591143.2170.36.camel@vortex>	   <1315603187.2482.22.camel@vortex> <4E6A8707.9080602@manicmethod.com>	  <1315607702.2482.28.camel@vortex> <4E6A9C4D.6010303@redhat.com>	 <1315609967.2482.39.camel@vortex> <4E6A9E26.9080806@redhat.com>	 <4E6D429A.7060403@manicmethod.com> <1315793570.2209.22.camel@vortex>
In-Reply-To: <1315793570.2209.22.camel@vortex>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Guido Trentalancia wrote:
> On Sun, 2011-09-11 at 19:22 -0400, Joshua Brindle wrote:
>> Eric Paris wrote:
>>> On 09/09/2011 07:12 PM, Guido Trentalancia wrote:
<snip>>>
>> gcc doesn't care and I swear we use to have ../ directories in the
>> include path, not sure what happened to those :X
>
> Honestly, I don't know, I can't remember. From reading a bit of git log,
> perhaps I can speculate it wasn't there, but what I am hitting is also
> cross-dependencies between the objects in the library directories (so
> for example libsepol symbols being required by objects in the libselinux
> directory).
>

Probably pre-git

> @@ -126,7 +126,7 @@ install: all
>   	install -m 755 $(LIBSO) $(SHLIBDIR)
>   	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
>   	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
> -	cd $(LIBDIR)&&  ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
> +	cd $(LIBDIR)&&  ln -sf $(LIBSO) $(TARGET)
>
>   install-pywrap: pywrap
>   	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux

What is the purpose of this? It definitely doesn't seem right to me :\

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
