Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JIPPoh013368
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 14:25:25 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JIPOk7026840
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 18:25:24 GMT
Message-ID: <446E0D9A.5040105@redhat.com>
Date: Fri, 19 May 2006 14:25:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <446C9926.5070802@redhat.com>	 <1148047494.31984.56.camel@sgc.columbia.tresys.com>	 <446DD270.4090703@redhat.com> <1148060451.31984.67.camel@sgc.columbia.tresys.com>
In-Reply-To: <1148060451.31984.67.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2006-05-19 at 10:13 -0400, Daniel J Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> On Thu, 2006-05-18 at 11:56 -0400, Daniel J Walsh wrote:
>>>       
>>>> Added unconfined_execmem_exec_t so that I can change the global 
>>>> allow_execmem to off.  OpenOffice, valgrind and mplayer need it.  
>>>> Probably could eliminate java, and wine domain and change to this.
>>>>     
>>>>         
>>> I think this would be better if we had this transparently integrated
>>> into the unconfined policy.  So we just add the rules to unconfined.te,
>>> and put the domain transition into unconfined_domtrans().  The
>>> differences between the two domains is just the execmem, so it should be
>>> ok.  In fact this might be a simple example of hierarchy.
>>>       
>
> So basically, we want unconfined_execmem_t to be the exact same as
> unconfined_t, except have execmem too.  So the best way to do that would
> be to have the unconfined interfaces also act on unconfined_execmem_t.
> For example:
>
> interface(`unconfined_domtrans',`
> 	domain_auto_trans($1,unconfined_exec_t,unconfined_t)
> 	domain_auto_trans($1,unconfined_execmem_exec_t,unconfined_execmem_t)
> ')
>   
No because this would allow xdm, xdm_xserver_t, firstboot ... to 
transion.  All we want is

domain_auto_trans(unconfined_t,unconfined_execmem_exec_t,unconfined_execmem_t)

> interface(`unconfined_dbus_send',`
> 	allow $1 { unconfined_t unconfined_execmem_t }:dbus send_msg;
> ')
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
