Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6SDnmgA021078
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 09:49:48 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6SDi1I0027164
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 13:44:01 GMT
Message-ID: <42E8E10C.70205@tresys.com>
Date: Thu, 28 Jul 2005 09:43:40 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: gyurdiev@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [RFC] selinux management API
References: <42D7CC53.9030803@tresys.com> <1121442990.4488.87.camel@celtics.boston.redhat.com> <42D7FC9A.7000901@tresys.com> <200507281836.06447.russell@coker.com.au>
In-Reply-To: <200507281836.06447.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Saturday 16 July 2005 04:12, Joshua Brindle <jbrindle@tresys.com> wrote:
>  
>
>>I think this summarizes the dialog well Ivan, thanks.
>>
>>Attached is an updated header file that uses structs for all
>>    
>>
>
>int semanage_module_install(semanage_handle_t *,
>                            char *module_data, size_t data_len);
>int semanage_module_upgrade(semanage_handle_t *,
>                            char *module_data, size_t data_len);
>int semanage_module_install_base(semanage_handle_t *,
>                                 char *module_data, size_t data_len);
>
>Is the plan to support binary or text modules for these operations?  If binary 
>modules then module_data should have type void *.
>
>  
>
Yea, I'd like to make this able to handle the monolithic policy and 
modules but I haven't figured out exactly how that is going to work yet.

I think that for the monolithic case you may be limited to only the 
special modifiers (eg., users, ports, booleans, etc) and so this would 
not apply to it, I'm not quite sure yet though.

>Also more liberal use of const would be good.  I expect that the above 
>functions will not change the module data so const void * would probably be 
>the correct type.  I realise that this is still in the design phase, but I 
>think that we are ready to design which data gets modified by the library 
>code and which doesn't.
>  
>
sure but only if it doesn't ripple throughout the rest of the library

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
