Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3NEvXlT021716
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 10:57:33 -0400
Received: from mail-fx0-f164.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3NEvW5A005614
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 14:57:32 GMT
Received: by fxm8 with SMTP id 8so638909fxm.18
        for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 07:57:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1240491283.19211.805.camel@gorn.columbia.tresys.com>
References: <dd18b0c30904220938y781d0009y7c2229aa28952c2e@mail.gmail.com>
	 <49F0618C.4080101@redhat.com>
	 <1240491283.19211.805.camel@gorn.columbia.tresys.com>
Date: Thu, 23 Apr 2009 07:57:30 -0700
Message-ID: <dd18b0c30904230757o37aeb208g84fd9642d53ce64a@mail.gmail.com>
Subject: Re: [refpolicy] runcon cant really run(constraint issue?)
From: Justin Mattock <justinmattock@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, tresys <refpolicy@oss.tresys.com>,
        SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 23, 2009 at 5:54 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On Thu, 2009-04-23 at 08:39 -0400, Daniel J Walsh wrote:
>> On 04/22/2009 12:38 PM, Justin Mattock wrote:
>> > looking into using runcon
>> > it seems I'm confronted with an
>> > avc, that just keeps showing up:
>> > allow staff_t user_t:process { siginh rlimitinh transition noatsecure };
>> > (even after adding this to the policy).
>> >
>> > What I'm doing is this:
>> > runcon name:user_r:user_t:s0-s0:c0.c255 firefox
>> > the initial role I'm in is staff_r(transitioning to user_r for
>> > firefox to run in)
>> >
>> > Does this seem like the right thing to do,
>> > or do I need to use newrole -r *
>> > for something like firefox?
>> >
>> I guess the correct question is what is your security goal.
>>
>> You are not currently allowed to transition from a staff_u user to a
>> user_r role.  In order to make this happen you would need to use semange
>> to make sure your SELinux user "name" had both staff_r and user_r, and
>> then you would need to add a rule to policy that says staff_r can become
>> user_r.
>
> There is also a transition constraint when the role is changing.  You
> have to be coming from a domain that is allowed to do role changing,
> such as newrole_t.  User domains (except unconfined_t) are not allowed.
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

my goal was to simple run a program(while changing roles) without having
to open a terminal and type(yes I admit I am a lazy a**)
runcon does work(after changing its context to newrole_exec_t)
as for security, probably not as safe(but finally I can turn my
computer on and not have people laugh at me with all of these
squares on the desktop)

As for the policy itself It seems I can't run gnome-vfs
etc...the dbus avc's as root are allowed system_dbus_t, but
any other is rejected by checkpolicy, meaning ausers_dbus_t.
I do have another system without all of the gnome-vfs etc..
which runs fine.

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
