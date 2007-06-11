Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BEAJ5s016004
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 10:10:19 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5BEAIQ2011901
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 14:10:18 GMT
Message-ID: <466D57BF.9070700@redhat.com>
Date: Mon, 11 Jun 2007 10:10:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: apps_uml changes
References: <200705301540.l4UFekZN011834@localhost.localdomain> <1181570689.16029.13.camel@sgc.columbia.tresys.com>
In-Reply-To: <1181570689.16029.13.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2007-05-30 at 11:40 -0400, dwalsh@redhat.com wrote:
>   
>> Remove TODO
>>     
>
> Are you sure that none of these rules are needed?
>
>   
No but I am sick of looking at them.  Unless the UML developers/testers 
come in and test it with ref policy, I am not sure we want to hang onto 
these things indefinitely.
>> --- nsaserefpolicy/policy/modules/apps/uml.if	2007-05-29 14:10:48.000000000 -0400
>> +++ serefpolicy-3.0.1/policy/modules/apps/uml.if	2007-05-30 09:25:53.000000000 -0400
>> @@ -193,33 +193,6 @@
>>  		nis_use_ypbind($1_uml_t)
>>  	')
>>  
>> -	ifdef(`TODO',`
>> -		# for X
>> -		optional_policy(`
>> -			ifelse($1, sysadm,`
>> -			',`
>> -				optional_policy(`
>> -					allow $1_uml_t xdm_xserver_tmp_t:dir search;
>> -				')
>> -				allow $1_uml_t $1_xserver_tmp_t:sock_file write;
>> -				allow $1_uml_t $1_xserver_t:unix_stream_socket connectto;
>> -			')
>> -		')
>> -
>> -		optional_policy(`
>> -			# for uml_net
>> -			domain_auto_trans($1_uml_t, uml_net_exec_t, uml_net_t)
>> -			allow uml_net_t $1_uml_t:unix_stream_socket { read write };
>> -			allow uml_net_t $1_uml_t:unix_dgram_socket { read write };
>> -			dontaudit uml_net_t privfd:fd use;
>> -			can_access_pty(uml_net_t, $1_uml)
>> -			dontaudit uml_net_t $1_uml_rw_t:dir { getattr search };
>> -		')
>> -		#TODO
>> -		optional_policy(`
>> -			allow $1_uml_t $1_xauth_home_t:file { getattr read };
>> -		')
>> -	')
>>  ')
>>  
>>  ########################################
>>     


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
