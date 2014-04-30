Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3UFIf2v002310
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 11:18:41 -0400
Received: by mail-lb0-f182.google.com with SMTP id l4so1349822lbv.13
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 08:18:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5360FC01.9090904@redhat.com>
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
 <1398826782.10979.9.camel@localhost> <5360F3C6.4090501@redhat.com>
 <1734421.ihMzWMu7WD@x2> <5360FC01.9090904@redhat.com>
Date: Wed, 30 Apr 2014 08:18:39 -0700
Message-ID: <CAB9W1A1=Q7OAv9pDw5oj0Lrj8dt5aAL_t9TffcVPbnsT1zexjQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Steve Grubb <sgrubb@redhat.com>, selinux <selinux@tycho.nsa.gov>,
 Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I could make it permissive=0 or permissive=1 if that is less
confusing.  It doesn't necessarily correspond to the result of the
system call, just the avc_has_perm call, as e.g. the kernel checks
CAP_DAC_OVERRIDE and falls back to CAP_DAC_READ_SEARCH if only
read/search access was requested, and there are other cases where a
permission denial has a side effect rather than preventing the system
call (e.g. CAP_FSETID).

On Wed, Apr 30, 2014 at 6:34 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>
> On 04/30/2014 09:29 AM, Steve Grubb wrote:
>> On Wednesday, April 30, 2014 08:59:50 AM Daniel J Walsh wrote:
>>> How about permitted rather then allowed.
>> I think permitted is already in an AVC.
> Not sure where.
>>
>>> On 04/29/2014 10:59 PM, Eric Paris wrote:
>>>> On Tue, 2014-04-29 at 16:54 -0700, Stephen Smalley wrote:
>>>>> Requested for Android in order to distinguish denials that are not in
>>>>> fact breaking anything yet due to permissive domains versus denials
>>>>> that are being enforced, but seems generally useful.  result field was
>>>>> already in the selinux audit data structure and was being passed to
>>>>> avc_audit() but wasn't being used.  Seems to cause no harm to ausearch
>>>>> or audit2allow to add it as a field.  Comments?
>>>> I think it's a great idea, but I'm worried that Steve is going to get
>>>> grumpy because an AVC record is going to have a result= field which is
>>>> similar, but not necessarily related to the res= field of a SYSCALL
>>>> record.
>> I think that I'll have to parse this field no matter what. Its probably that
>> important. In the syscall, we use success= to be the final determination.
>>
>>
>>>> Seems easily confused (although probably 9999 times out of
>>>> 10000 they will be the same)
>> Why would this ever not be correct? Are there times when we get an AVC with a
>> denial _and_ the syscall completes successfully?
>>
>> I'd suggest using res= since its in the audit dictionary and means exactly
>> what you are wanting to use it for. In it, 1 is success, 0 is failure.
>>
> I have seen AVC's where the success=yes in enforcing mode.  Basically
> the kernel takes a different code path and the syscall succeeds.  Most
> of these end up as dontaudits.
>>>> So while I wholeheartedly think we should take the idea, I wonder if
>>>> someone can dream up a name that isn't confusingly similar...
>>>>
>>>> I can't think of anything...
>> There is thesaurus.com. :-)
>>
>> consequence, outcome, effect, reaction,  conclusion, verdict, decision,
>> judgement, finding, ruling, answer, solution, recommendation, order,  ...
>>
>> -Steve
>
