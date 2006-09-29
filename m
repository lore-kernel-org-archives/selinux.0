Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TJDjGo032400
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 15:13:45 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TJDBu8006158
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 19:13:11 GMT
Message-ID: <451D706C.7070503@redhat.com>
Date: Fri, 29 Sep 2006 15:13:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Matt Anderson <mra@hp.com>, selinux@tycho.nsa.gov
Subject: Re: SELINUX_ERR using chcon to set a printer to Secret
References: <451C1B7A.7010203@hp.com>  <451C239F.7070003@hp.com>	 <1159473365.2850.62.camel@sgc.columbia.tresys.com>	 <451D5D06.6080401@redhat.com> <1159554192.14286.19.camel@sgc.columbia.tresys.com>
In-Reply-To: <1159554192.14286.19.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2006-09-29 at 13:51 -0400, Daniel J Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> On Thu, 2006-09-28 at 15:33 -0400, Matt Anderson wrote:
>>>   
>>>       
>>>> When I add the policy:
>>>>
>>>> allow secadm_t printer_device_t:chr_file { getattr relabelfrom relabelto };
>>>>
>>>> I'm able to perform the relabel from secadm_r.  This meets my needs wrt
>>>> CUPS, but could one of the policy gurus point what in the policy allows
>>>> secadm_r to do this?
>>>>     
>>>>         
>>> You need MLS upgrade and/or downgrade permissions:
>>>
>>> mls_file_upgrade(secadm_t)
>>> mls_file_downgrade(secadm_t)
>>>
>>>   
>>>       
>> No those rules are already there.  I think the problem is in
>>     
>
> I was specifying what made secadm able to do that, as Matt asked :)
>
>   
>> files_relabel_all_files
>>
>> I believe it needs this patch
>> -       allow $1 { file_type $2 }:blk_file { getattr relabelfrom };
>> -       allow $1 { file_type $2 }:chr_file { getattr relabelfrom };
>> +       allow $1 { file_type $2 }:blk_file { getattr relabelfrom 
>> relabelto };
>> +       allow $1 { file_type $2 }:chr_file { getattr relabelfrom 
>> relabelto };
>>     
>
> I don't agree with this, because there shouldn't be any blk_files and
> chr_files that are file_type.
>
>   

Ok I misread the entire discussion. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
