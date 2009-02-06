MIME-Version: 1.0
In-Reply-To: <566C419E-5A34-4E5E-947E-4E0AF57863F3@nall.com>
References: <58C746BE-D2EA-4B17-B7F8-37F57E0AD806@nall.com>
	 <1233942173.10320.58.camel@localhost.localdomain>
	 <1233944128.4921.1.camel@gorn.columbia.tresys.com>
	 <566C419E-5A34-4E5E-947E-4E0AF57863F3@nall.com>
Date: Fri, 6 Feb 2009 15:47:50 -0600
Message-ID: <cadfc0e40902061347n6661e216v71d9d1cf9f3b6249@mail.gmail.com>
Subject: Re: security_compute_av_raw confusion
From: Xavier Toth <txtoth@gmail.com>
To: Joe Nall <joe@nall.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Feb 6, 2009 at 1:59 PM, Joe Nall <joe@nall.com> wrote:
>
> On Feb 6, 2009, at 12:15 PM, Christopher J. PeBenito wrote:
>
>> On Fri, 2009-02-06 at 12:42 -0500, Stephen Smalley wrote:
>>>
>>> On Fri, 2009-02-06 at 10:21 -0600, Joe Nall wrote:
>>>>
>>>> I confused by the behavior of security_compute_av_raw in fedora rawhide
>>>> ...
>>>> rc = security_compute_av_raw(ctx, raw, SECCLASS_CONTEXT,
>>>> CONTEXT__CONTAINS, &avd);
>>>> log_debug("ctx=%s raw=%s avd.allowed=%d rc=%d\n", ctx, raw,
>>>> avd.allowed, rc);
>>>> ...
>>>>
>>>> with ctx and raw identical user contexts, it works as expected:
>>>>
>>>> ctx=user_u:user_r:user_t:s15:c0.c1023
>>>> raw=user_u:user_r:user_t:s15:c0.c1023 avd.allowed=2 rc=0
>>>>
>>>> with ctx and raw identical system contexts, it behaves differently:
>>>>
>>>> ctx=system_u:system_r:setrans_t:s15:c0.c1023
>>>> raw=system_u:system_r:setrans_t:s15:c0.c1023 avd.allowed=1 rc=0
>>>>
>>>> both in mls/permissive. No obvious avcs.
>>>
>>> The refpolicy only allows context contains permission for the user
>>> domains since that was the only usage of it originally, when checking
>>> whether a user-supplied context was contained by the seusers-defined
>>> range.  It is allowed by the interfaces in userdomain.if.  If you want
>>> it applied to all domains, you'll need to make it part of domain_type().
>>
>> If it makes sense, I have no trouble doing that upstream.  Joe, what do
>> you think?
>
> Works for me. At a minimum we need:
>
> gen_require(`
>        type setrans_t;
>        class context contains;
> ')
> allow setrans_t self:context contains;
>
> for Eamon's color mcstrans patch to work. See Ted's earlier email:
>
> http://engardelinux.org/modules/index/list_archives.cgi?list=selinux&page=0015.html&month=2009-01
>
> I got to rediscover the issue and have Stephen explain it again :)
>
> joe
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>

Maybe Chris can commit the patch I submitted to the refpolicy list on
12/30/2008.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
