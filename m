Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UIHdXu015179
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 14:17:39 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3UIHbj8012632
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 18:17:37 GMT
Message-ID: <463632BD.2000704@redhat.com>
Date: Mon, 30 Apr 2007 14:17:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov, Tim Waugh <twaugh@redhat.com>
Subject: Re: cups sends mail, connects to smbd port and binds to ports	600-1023
References: <200704201852.l3KIqJnR027114@redsox.boston.devel.redhat.com> <1177954715.3570.133.camel@sgc>
In-Reply-To: <1177954715.3570.133.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2007-04-20 at 14:52 -0400, dwalsh@redhat.com wrote:
>   
>> --- nsaserefpolicy/policy/modules/services/cups.te	2007-03-26 10:39:04.000000000 -0400
>> +++ serefpolicy-2.5.12/policy/modules/services/cups.te	2007-04-11 17:07:34.000000000 -0400
>> @@ -151,9 +151,11 @@
>>  corenet_tcp_bind_reserved_port(cupsd_t)
>>  corenet_dontaudit_tcp_bind_all_reserved_ports(cupsd_t)
>>  corenet_tcp_connect_all_ports(cupsd_t)
>> +corenet_tcp_connect_smbd_port(cupsd_t)
>>  corenet_sendrecv_hplip_client_packets(cupsd_t)
>>  corenet_sendrecv_ipp_client_packets(cupsd_t)
>>  corenet_sendrecv_ipp_server_packets(cupsd_t)
>> +corenet_tcp_bind_all_rpc_ports(cupsd_t)
>>     
>
> Any info on why it binds to these ports?
>
>   
Tim, why does cupsd bind to ports 600-1023?
>>  dev_rw_printer(cupsd_t)
>>  dev_read_urand(cupsd_t)
>> @@ -294,6 +296,10 @@
>>  ')
>>  
>>  optional_policy(`
>> +	sendmail_domtrans(cupsd_t)
>> +')
>>     
>
> Wouldn't mta_send_mail() be better?
>   
Yes
>   
>> +
>> +optional_policy(`
>>  	seutil_sigchld_newrole(cupsd_t)
>>  ')
>>     
>  
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
