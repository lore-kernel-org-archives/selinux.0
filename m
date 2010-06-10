Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5ABCIO3018469
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 07:12:18 -0400
Received: from house.lunarmania.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5ABDleH028702
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 11:13:48 GMT
Message-ID: <4C10C88A.90501@rubix.com>
Date: Thu, 10 Jun 2010 19:12:10 +0800
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: mcs_systemhigh use
References: <4C10AD2B.9080802@rubix.com> <1276168170.809.219.camel@gorn.columbia.tresys.com>
In-Reply-To: <1276168170.809.219.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On 6/10/2010 7:09 PM, Christopher J. PeBenito wrote:
> On Thu, 2010-06-10 at 17:15 +0800, Andy Warner wrote:
>    
>> In the policy for the Trusted RUBIX DBMS, we assign file contexts
>> using the following (only one representative dir, 'backups', shown):
>>
>> ifdef(`enable_mls',`
>> /var/lib/RUBIXdbms/backups(/.*)?
>> gen_context(system_u:object_r:rubix_backup_t,mls_systemhigh)
>> ')
>> ifdef(`enable_mcs',`
>> /var/lib/RUBIXdbms/backups(/.*)?
>> gen_context(system_u:object_r:rubix_backup_t,mcs_systemhigh)
>> ')
>>
>> When using the mls policy, I get the expected level of mls_systemhigh
>> (s15:c0.c1023). But when using the targeted policy, I get an
>> unexpected value for mcs_systemhigh. I would expect to get
>> s0:c0.c1023, but get s0. I have verified this behavior on Fedora 9 and
>> 12. Is my assumption wrong about what mcs_systemhigh should be or am I
>> missing something?
>>
>> Relevant output from 'semanage fcontext -l'
>> /var/lib/RUBIXdbms/backups(/.*)?                   all files
>> system_u:object_r:rubix_backup_t:s0
>>      
> Actually, you shouldn't need any of those ifdefs.  The gen_context()
> macro is sensitive to if MLS or MCS is enabled.  The first parameter is
> the first three fields of the context.  The second parameter is the MLS
> label, and there is a third optional parameter to specify the MCS
> categories for the file (there are no examples in refpolicy).  So this
> is sufficient:
>
> /var/lib/RUBIXdbms/backups(/.*)?     gen_context(system_u:object_r:rubix_backup_t,mls_systemhigh,mcs_allcats)
>
> The thing to note is that gen_context() abstracts away the sensitivity
> (s0) portion of the label, so there is an mcs_allcats macro.
>    

Thanks for the reply. So, then is the mcs_systemhigh basically meaningless?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
