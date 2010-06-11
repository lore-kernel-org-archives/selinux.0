Message-ID: <4C11D94F.3090802@ak.jp.nec.com>
Date: Fri, 11 Jun 2010 15:35:59 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: libselinux APIs should take "const" qualifier?
References: <4BA32D3B.9010502@ak.jp.nec.com> <1269005549.25642.5.camel@moss-pluto.epoch.ncsc.mil> <4BA82DE4.2000601@ak.jp.nec.com>
In-Reply-To: <4BA82DE4.2000601@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

BTW, is nobody interested in this patch?

(2010/03/23 11:56), KaiGai Kohei wrote:
> (2010/03/19 22:32), Stephen Smalley wrote:
>> On Fri, 2010-03-19 at 16:52 +0900, KaiGai Kohei wrote:
>>> Right now, security_context_t is an alias of char *, declared in selinux.h.
>>>
>>> Various kind of libselinux API takes security_context_t arguments,
>>> however, it is inconvenience in several situations.
>>>
>>> For example, the following query is parsed, then delivered to access
>>> control subsystem with the security context as "const char *" cstring.
>>>
>>>     ALTER TABLE my_tbl SECURITY LABEL TO 'system_u:object_r:sepgsql_table_t:SystemHigh';
>>>                   const char *<----    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>
>>> In this case, we want to call selinux_trans_to_raw_context() to translate
>>> the given security context into raw format. But it takes security_context_t
>>> argument for the source context, although this pointer is read-only.
>>> In the result, compiler raises warnings because we gave "const char *" pointer
>>> into functions which take security_context_t (= char *).
>>>
>>> Any comments?
>>>
>>> It seems to me the following functions' prototype should be qualified by
>>> "const".
>>
>> That seems reasonable and should have no impact on library ABI.
>> On the other hand, others have pointed out that security_context_t is
>> not a properly encapsulated data type at all, and perhaps should be
>> deprecated and replaced with direct use of char*/const char* throughout.
>>
>> There are other library API issues as well that have come up in the
>> past, such as lack of adequate namespacing (with approaches put forth),
>> but we don't ever seem to get a round tuit.
> 
> At first, I tried to add const qualifiers read-only security_context_t
> pointers, but didn't replace them by char */const char * yet, right now.
> 
> BTW, I could find out the following code:
> 
>    int security_compute_create(security_context_t scon,
>                                security_context_t tcon,
>                                security_class_t tclass,
>                                security_context_t * newcon)
>    {
>            int ret;
>            security_context_t rscon = scon;
>            security_context_t rtcon = tcon;
>            security_context_t rnewcon;
> 
>            if (selinux_trans_to_raw_context(scon,&rscon))
>                    return -1;
>            if (selinux_trans_to_raw_context(tcon,&rtcon)) {
>                    freecon(rscon);
>                    return -1;
>            }
>        :
> 
> In this case, scon and tcon can be qualified by const, and the first
> argument of selinux_trans_to_raw_context() can take const pointer.
> But it tries to initialize rscon and tscon by const pointer, although
> these are used to store raw security contexts.
> The selinux_trans_to_raw_context() always set dynamically allocated
> text string on the second argument, so we don't need to initialize it
> anyway. I also removed these initializations in this patch.
> 
> Does the older mcstrans code could return without allocation of raw
> format when the given scon is already raw format? I don't know why
> these are initialized in this manner.
> 
> Thanks.


-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
