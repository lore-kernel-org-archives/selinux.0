Message-ID: <4B8FDEB7.1080102@manicmethod.com>
Date: Thu, 04 Mar 2010 11:24:23 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Jacques Thomas <jthomas@cs.purdue.edu>,
        SE Linux <selinux@tycho.nsa.gov>, KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [PATCH 2/2] libsepol: remove dead code in check_avtab_hierarchy_callback()
References: <4AF71B05.8030707@cs.purdue.edu>	 <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>	 <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>	 <4B14934F.9050401@cs.purdue.edu>	 <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil>	 <4B54339F.8070501@ak.jp.nec.com> <4B5685EC.1000500@ak.jp.nec.com>	 <4B6BAFD0.2050607@ak.jp.nec.com>	 <1265381454.18100.50.camel@moss-pluto.epoch.ncsc.mil>	 <4B7104C9.30903@ak.jp.nec.com>  <4B7A04C6.9020808@ak.jp.nec.com>	 <1266333947.5252.51.camel@moss-pluto.epoch.ncsc.mil>	 <4B7B2F15.5020909@ak.jp.nec.com>	 <1266414665.4945.15.camel@moss-pluto.epoch.ncsc.mil>	 <4B7E3ECC.1040505@ak.jp.nec.com>	 <1266592834.32011.67.camel@moss-pluto.epoch.ncsc.mil>	 <4B8B29C4.4020708@ak.jp.nec.com> <1267454064.601.22.camel@moss-pluto.epoch.ncsc.mil> <4B8E1925.1020403@ak.jp.nec.com> <4B8FD977.2000207@manicmethod.com>
In-Reply-To: <4B8FD977.2000207@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> KaiGai Kohei wrote:
>> (2010/03/01 23:34), Stephen Smalley wrote:
>>> On Mon, 2010-03-01 at 11:43 +0900, KaiGai Kohei wrote:
>>>> (2010/02/20 0:20), Stephen Smalley wrote:
>>>>> On Fri, 2010-02-19 at 16:33 +0900, KaiGai Kohei wrote:
>>>>>> (2010/02/17 22:51), Stephen Smalley wrote:
>>>>>>> On Wed, 2010-02-17 at 08:49 +0900, KaiGai Kohei wrote:
>>>>>>>>> I'd say we revert the changeset and restore the prior behavior.
>>>>>>>>> I don't think we should impose the latter convention on policy
>>>>>>>>> writers.
>>>>>>>> OK, fair enough for me.
>>>>>>>>
>>>>>>>> This patch revert the commit of
>>>>>>>> 7d52a155e38d5a165759dbbee656455861bf7801
>>>>>>>> which removed a part of type_attribute_bounds_av as a dead code.
>>>>>>>> However, at that time, we didn't find out the target side
>>>>>>>> boundary allows
>>>>>>>> to handle some of pseudo /proc/<pid>/* entries with its
>>>>>>>> process's security
>>>>>>>> context well.
>>>>>>> Does Jacques' original concern about the code still hold true?
>>>>>>> http://marc.info/?l=selinux&m=125770868309928&w=2
>>>>>>> http://marc.info/?l=selinux&m=125851264424682&w=2
>>>>>> This patch just tries to revert the changes by previous my patch,
>>>>>> and returns to the start point, so it also reverts the Jacques'
>>>>>> original concern.
>>>>>>
>>>>>> At that time, IIRC, Jacques concerned about the logic being unclear.
>>>>>> Then, I introduced two options. The one is rough; that removes
>>>>>> boundary
>>>>>> checks in the target side. The other option tried to mask union
>>>>>> bits of
>>>>>> both of violated permissions on subject and target side boundaries
>>>>>> (*1).
>>>>>>
>>>>>> (*1) type_attribute_bounds_av(Sc,Tc, ...)
>>>>>> {
>>>>>> masked = 0;
>>>>>>
>>>>>> if (Sc has its bounds)
>>>>>> masked |= P(Sc,Tc)& ~P(Sp,Tc);
>>>>>>
>>>>>> if (Tc has its bounds)
>>>>>> masked |= P(Sc,Tc)& ~P(Sc,Tp);
>>>>>>
>>>>>> avd->allowed&= ~masked;
>>>>>> }
>>>>>>
>>>>>> However, the later option also requires policy writers special
>>>>>> treatments
>>>>>> to handle pseudo file entries labeled with parent's domain.
>>>>>>
>>>>>> For example, when web server (httpd_t) launches a thread and
>>>>>> assign an
>>>>>> individual bounded security context (webapp_t), we don't need to take
>>>>>> a special treatment to access pseudo files labeled as webapp_t in the
>>>>>> original logic.
>>>>>>
>>>>>> If we adopt the logic introduced at (*1), when we write webapp_t's
>>>>>> policy,
>>>>>> we have to allow webapp_t domain to access files labeled as
>>>>>> httpd_t, not
>>>>>> only webapp_t, because permissions between webapp_t and webapp_t
>>>>>> will be
>>>>>> eventually masked by one's between httpd_t domain and webapp_t
>>>>>> type or
>>>>>> webapp_t domain and httpd_t type.
>>>>> That seems wrong to me - we don't want webapp_t to be able to access
>>>>> the /proc/pid entries of other tasks running in httpd_t. We only want
>>>>> it to be able to access its own /proc/pid entries in webapp_t. Yes?
>>>>>
>>>> Sorry for the late replying, because I've been unavailable last week.
>>>>
>>>> Yes, I also think it is unnatural to require webapp_t to have access
>>>> rights to /proc/pid entries labeled as httpd_t, if and when we adopt
>>>> the above logic.
>>>>
>>>> However, it does not solve the matter that Jacques pointed out the
>>>> meaning of the original logic is unclear.
>>>>
>>>> In addition, I pointed out the original logic can allow webapp_t
>>>> domain some permissions on the webapp_t type without permissions
>>>> of httpd_t which bounds webapp_t.
>>>>
>>>> Example)
>>>> allow httpd_t httpd_t : file { read };
>>>> allow webapp_t webapp_t : file { read };
>>>>
>>>> In this case, webapp_t can read from files labeled as webapp_t, and
>>>> it is not masked because httpd_t also has same permissions on itself.
>>>>
>>>> It seems to me httpd_t should have permissions on webapp_t types from
>>>> the perspective of the definition of type boundary, even if we need to
>>>> modify existing security policy a bit.
>>>> (BTW, existing refpolicy does not use boundary right now.)
>>>>
>>>> I think we want webapp_t to have access rights (except for ones allowed
>>>> explicitly) on the httpd_t, but it is not unnatural that httpd_t have
>>>> access rights on webapp_t types. It performs boundary of the webapp_t's
>>>> permissions as literal.
>>> I think I need to revisit the original design of the hierarchical types
>>> support, and how it compares with the extension policy logic that
>>> inspired it (described in Section 4.2.2.3.2 on page 39 of:
>>> http://www.cs.utah.edu/flux/fluke/html/ftls.ps.gz )
>>
>> It seems to me this article does not mention about a case when source and
>> target SIDs are in different parent-child-trees individually.
>>
>> For example, when webapp_t being a child of httpd_t tries to access files
>> labeled as webapp_content_t being a child of httpd_sys_content_t, it was
>> unclear for me what is an expected behavior.
>> (Perhaps, other part of the article may introduce it, but the volume of
>> the article is a bit large. :( )
>>
>
> The original hierarchy specified that if httpd_t had e.g., write access
> to httpd_sys_content_t then webapp_t could be given write access to
> webapp_content_t without httpd_t having direct access to webapp_content_t.
>
> This was done so that, in policy access controls, parents could be
> decoupled from children while still allowing child subjects to access
> child objects. One application of this was to have parents that,
> themselves, did not have access to children objects (or were not active
> at all).
>

Interestingly I can't find a complete description of the type hierarchy 
either in the tech notes or on the list. However, if you look at the 
original patch at http://marc.info/?l=selinux&m=111263146201885&w=2 in 
the check_avtab_hierarchy_callback() function you'll see:

...
/* search for access allowed between type 1's parent and type 2 */
...
/* next we try type 1 and type 2's parent */
...
and last (t is the subject parent, t2 is the object parent)
if (t && t2) { ... }

I believe this is still correct behavior.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
