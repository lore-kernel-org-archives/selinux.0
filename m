Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3UG8Rje007314
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 12:08:27 -0400
Received: by mail-qc0-f180.google.com with SMTP id i17so1334203qcy.25
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 09:08:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <32537239.2TmFnM48BI@x2>
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
 <CAB9W1A1a=mkZmuDpMtF-uhYse4z+ArmStHp9k09mS9YJy6zSPA@mail.gmail.com>
 <CAFftDdrAk75mR6QqCQkq9jV-c2bm9iezsGdF=ug0nt_cDn1EHA@mail.gmail.com>
 <32537239.2TmFnM48BI@x2>
Date: Wed, 30 Apr 2014 09:08:28 -0700
Message-ID: <CAB9W1A3-juzF1Ze3uDhtnMdOtMQtOgaG3+z_3vWYQ3TmcJK0=A@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-audit@redhat.com, selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The revised patch switched from result=allowed|denied to
permissive=0|1 in the avc message.  I think Bill's point was with
respect to the code, which still internally is passing around the
result of the decision and inferring the permissive state from it,
rather than the output string itself.

On Wed, Apr 30, 2014 at 9:01 AM, Steve Grubb <sgrubb@redhat.com> wrote:
> On Wednesday, April 30, 2014 08:48:31 AM William Roberts wrote:
>> My only nit would be the variable name result....would it be better named
>> is_permissive or something?
>
> That adds more bytes. My personal taste would be to abbreviate it to save
> bytes. They add up when you have 100's of thousands of events per day.
>
> -Steve
>
>
>> Otherwise LGTM. From the Android camp, this will be very helpful.
>> On Apr 30, 2014 8:43 AM, "Stephen Smalley" <stephen.smalley@gmail.com>
>>
>> wrote:
>> > Attached patch switches to reporting permissive=0|1 and only does it
>> > for avc: denied messages.
>> >
>> > On Wed, Apr 30, 2014 at 8:18 AM, Stephen Smalley
>> >
>> > <stephen.smalley@gmail.com> wrote:
>> > > I could make it permissive=0 or permissive=1 if that is less
>> > > confusing.  It doesn't necessarily correspond to the result of the
>> > > system call, just the avc_has_perm call, as e.g. the kernel checks
>> > > CAP_DAC_OVERRIDE and falls back to CAP_DAC_READ_SEARCH if only
>> > > read/search access was requested, and there are other cases where a
>> > > permission denial has a side effect rather than preventing the system
>> > > call (e.g. CAP_FSETID).
>> > >
>> > > On Wed, Apr 30, 2014 at 6:34 AM, Daniel J Walsh <dwalsh@redhat.com>
>> >
>> > wrote:
>> > >> On 04/30/2014 09:29 AM, Steve Grubb wrote:
>> > >>> On Wednesday, April 30, 2014 08:59:50 AM Daniel J Walsh wrote:
>> > >>>> How about permitted rather then allowed.
>> > >>>
>> > >>> I think permitted is already in an AVC.
>> > >>
>> > >> Not sure where.
>> > >>
>> > >>>> On 04/29/2014 10:59 PM, Eric Paris wrote:
>> > >>>>> On Tue, 2014-04-29 at 16:54 -0700, Stephen Smalley wrote:
>> > >>>>>> Requested for Android in order to distinguish denials that are not
>> >
>> > in
>> >
>> > >>>>>> fact breaking anything yet due to permissive domains versus denials
>> > >>>>>> that are being enforced, but seems generally useful.  result field
>> >
>> > was
>> >
>> > >>>>>> already in the selinux audit data structure and was being passed to
>> > >>>>>> avc_audit() but wasn't being used.  Seems to cause no harm to
>> >
>> > ausearch
>> >
>> > >>>>>> or audit2allow to add it as a field.  Comments?
>> > >>>>>
>> > >>>>> I think it's a great idea, but I'm worried that Steve is going to
>> > >>>>> get
>> > >>>>> grumpy because an AVC record is going to have a result= field which
>> >
>> > is
>> >
>> > >>>>> similar, but not necessarily related to the res= field of a SYSCALL
>> > >>>>> record.
>> > >>>
>> > >>> I think that I'll have to parse this field no matter what. Its
>> >
>> > probably that
>> >
>> > >>> important. In the syscall, we use success= to be the final
>> >
>> > determination.
>> >
>> > >>>>> Seems easily confused (although probably 9999 times out of
>> > >>>>> 10000 they will be the same)
>> > >>>
>> > >>> Why would this ever not be correct? Are there times when we get an AVC
>> >
>> > with a
>> >
>> > >>> denial _and_ the syscall completes successfully?
>> > >>>
>> > >>> I'd suggest using res= since its in the audit dictionary and means
>> >
>> > exactly
>> >
>> > >>> what you are wanting to use it for. In it, 1 is success, 0 is failure.
>> > >>
>> > >> I have seen AVC's where the success=yes in enforcing mode.  Basically
>> > >> the kernel takes a different code path and the syscall succeeds.  Most
>> > >> of these end up as dontaudits.
>> > >>
>> > >>>>> So while I wholeheartedly think we should take the idea, I wonder if
>> > >>>>> someone can dream up a name that isn't confusingly similar...
>> > >>>>>
>> > >>>>> I can't think of anything...
>> > >>>
>> > >>> There is thesaurus.com. :-)
>> > >>>
>> > >>> consequence, outcome, effect, reaction,  conclusion, verdict,
>> > >>> decision,
>> > >>> judgement, finding, ruling, answer, solution, recommendation, order,
>> >
>> >  ...
>> >
>> > >>> -Steve
>> >
>> > --
>> > Linux-audit mailing list
>> > Linux-audit@redhat.com
>> > https://www.redhat.com/mailman/listinfo/linux-audit
>
