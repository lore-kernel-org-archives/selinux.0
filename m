Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4VBFnTi031721
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 07:15:49 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4VBFmtC008721
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 11:15:49 GMT
Message-ID: <465EAE60.2050002@redhat.com>
Date: Thu, 31 May 2007 07:15:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: dwalsh@redhat.com, cpebenito@tresys.com, selinux@tycho.nsa.gov
Subject: Re: djbdns needs optional_policy
References: <200705301451.l4UEpKo6008223@localhost.localdomain> <20070531102457.GA16057@peter.simplex.ro>
In-Reply-To: <20070531102457.GA16057@peter.simplex.ro>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Petre Rodan wrote:
> Hi Daniel,
>
> On Wed, May 30, 2007 at 10:51:20AM -0400, dwalsh@redhat.com wrote:
>   
>> --- nsaserefpolicy/policy/modules/services/djbdns.te	2007-05-29 14:10:57.000000000 -0400
>> +++ serefpolicy-3.0.1/policy/modules/services/djbdns.te	2007-05-30 07:35:54.000000000 -0400
>> @@ -44,4 +44,7 @@
>>  libs_use_ld_so(djbdns_axfrdns_t)
>>  libs_use_shared_libs(djbdns_axfrdns_t)
>>  
>> -ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
>> +optional_policy(`
>> +	ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
>> +')
>> +
>>     
>
> http://marc.info/?l=selinux&m=117621284727331&w=2
>
> what is the reason for your tweak? 
>
> bye,
> peter
>
>   
It's been a while, but I believe if ucspictcp and djbdns are built as 
modules the packages will not build correctly. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
