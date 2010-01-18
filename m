Message-ID: <4B54339F.8070501@ak.jp.nec.com>
Date: Mon, 18 Jan 2010 19:10:39 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Jacques Thomas <jthomas@cs.purdue.edu>, SE Linux <selinux@tycho.nsa.gov>,
        method@manicmethod.com
Subject: Re: Type boundaries: questions on the semantics / is the enforcement
 correct ?
References: <4AF71B05.8030707@cs.purdue.edu>	 <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>	 <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>	 <4B14934F.9050401@cs.purdue.edu> <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/01/16 0:51), Stephen Smalley wrote:
> On Mon, 2009-11-30 at 22:53 -0500, Jacques Thomas wrote:
>> KaiGai Kohei wrote:
>>>>>> I also think we have one other a rough option.
>>>>>> It simply applies type boundaries on only sources to restrict its privileges,
>>>>>> and it does not apply any restrictions on target types.
>>>>>>
>>>>>>
>>>>>>
>>>>> Unless there is a clear use for bounds on targets, I would favor this
>>>>> option. (The "rough" one :-) )
>>>>> I see mostly room for confusion with the bounds on target types, because
>>>>> of the contravariance issue.
>>>>>
>>>>>
>>>> I can write and submit a patch along these lines. The patch is
>>>> straightforward: I just have to remove the "dead" code.
>>>>
>>>
>>> Note that libsepol has an option which test type-boundary violations
>>> in usermode just before policy load.
>>> Also check check_avtab_hierarchy_callback() in libsepol/src/hierarchy.c.
>>> (It is called when )
>>>
>>> Historically, this code delivered from hierarchy namespace support by
>>> Joshua Brindle. I'd like to ask him what about this change.
>>>
>>>    MEMO: The hierarchy namespace support implicitly set up type-boundary
>>>          on a couple of types. For example, if we defined httpd_t.cgi type,
>>>          it is implicitly bounded by httpd_t type without TYPEBOUNDS.
>>>
>>> I also have not seen any case example which restrict target types by
>>> the hierarchy namespace support. So, it seems to me we have no matter
>>> to remove the "dead" code.
>>>
>>> Joshua, what's your opinion?
>>>
>>>
>>>
>>>> However, could someone please indicate me how I am supposed to test the
>>>> patch ? In other words, is there a standardized testing procedure that I
>>>> am unaware of ?
>>>>
>>>
>>> http://ltp.sourceforge.net/
>>>
>>> It also contains SELinux testcases including type boundary, but it also
>>> does not contains a case of type boundary on target types.
>>>
> 
> Where does this stand?  IIUC, we are going to just remove the dead code
> from type_attribute_bounds_av() in the kernel and
> check_avtab_hierarchy_callback() in libsepol?

If Jacques is not available right now, I'll submit a patch to remove the
dead code within this week. Please wait for a while.


> With regard to the ltp, note that the last version of the ltp with a
> working selinux testsuite was ltp-full-20090930.  I am still trying to
> work with the ltp maintainers to fix it in cvs head, but that is still
> work in progress.
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
