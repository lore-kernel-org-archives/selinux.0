Message-ID: <485F9BA2.6030205@kaigai.gr.jp>
Date: Mon, 23 Jun 2008 21:48:34 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH]	libselinux:	add	support	for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com>	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>	 <483C6BEA.8040101@tycho.nsa.gov>	 <1211981040.5008.105.camel@gorn.columbia.tresys.com>	 <483EF06E.7080406@tycho.nsa.gov> <1212085228.31546.5.camel@gorn>	 <483F48AB.7030406@tycho.nsa.gov> <1212150456.31546.16.camel@gorn>	 <4843CB24.1040000@ak.jp.nec.com>  <48442E7E.9050303@tycho.nsa.gov>	 <1212431955.31546.94.camel@gorn>  <48451C0C.6060303@ak.jp.nec.com>	 <1212496632.31546.105.camel@gorn.columbia.tresys.com>	 <4846142F.8090100@ak.jp.nec.com>	 <1212589930.4140.16.camel@gorn.columbia.tresys.com>	 <48473ECC.6020501@ak.jp.nec.com>	 <1212672916.15752.7.camel@gorn.pebenito.net> <4848C96F.50201@ak.jp.nec.com>				 <484C9E55.30702@ak.jp.nec.com> <1213121355.27496.23.camel@gorn>			  <48524E79.6000508@ak.jp.nec.com> <1213364255.11146.18.camel@gorn>		  <4858B106.206@ak.jp.nec.com> <1213796498.11146.120.camel@gorn>	  <485B52D2.6020101@ak.jp.nec.com> <1214224508.11146.206.camel@gorn>
In-Reply-To: <1214224508.11146.206.camel@gorn>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2008-06-20 at 15:48 +0900, KaiGai Kohei wrote:
>> Christopher J. PeBenito wrote:
>>> On Wed, 2008-06-18 at 15:53 +0900, KaiGai Kohei wrote:
>>>> Christopher J. PeBenito wrote:
>>>>>>> 2. the stored procedure type names have been in the back of my mind for
>>>>>>> long time but I couldn't come up with a good naming scheme.  This
>>>>>>> especially bugged me for the sepgsql_trusted_domain_t and
>>>>>>> sepgsql_trusted_proc_t.  Why not just go with what we do with regular
>>>>>>> domains and executables: sepgsql_trusted_proc_t and
>>>>>>> sepgsql_trusted_proc_exec_t?
>>>>>> I don't have a clear reason for the naming of them.
>>>>>> sepgsql_trusted_proc_t and sepgsql_trusted_proc_exec_t are more suitable
>>>>>> for the purpose, I also think.
>>>>> It seems that we should also rename $1_sepgsql_proc_t for consistency.
>>>> Sorry for late reply.
>>>>
>>>> At first, $1_sepgsql_proc_t lost the term of "trusted", so its name
>>>> does not shows its purpose.
>>> No, I mean having a $1_sepgsql_proc_t and $1_sepgsql_proc_exec_t.
>> Do you intend the following domain transition?
>>   user_t + user_sepgsql_proc_exec_t -> user_sepgsql_proc_t
>>
>> Is there any reason why users should not invoke their functions
>> without domain transition?
> 
> I don't think we need a transition.  Mainly I think the procedure should
> be $1_sepgsql_proc_exec_t so there is naming consistency for stored
> procedures.

I agree it.
Do you need a patch?

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
