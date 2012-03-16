Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2GDTc1N015760
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 09:29:38 -0400
Received: by yhjj72 with SMTP id j72so4710052yhj.12
        for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 06:29:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F62EE4B.7090600@itechfrontiers.com>
References: <CAPweEDzK22daM9ue26tMZ_6HbrFwEZxTfVUXhea31GFO4x0=Qw@mail.gmail.com>
	<4F62EE4B.7090600@itechfrontiers.com>
Date: Fri, 16 Mar 2012 13:29:36 +0000
Message-ID: <CAPweEDz1zgwBdTaFwMJ4-BZgcrWROvv2rJq42Hi0wiq9evjZoA@mail.gmail.com>
Subject: Re: B2G
From: lkcl luke <luke.leighton@gmail.com>
To: "Patrick K., ITF" <cto@itechfrontiers.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 16, 2012 at 7:39 AM, Patrick K., ITF <cto@itechfrontiers.com> wrote:
> On 3/16/2012 1:46 AM, lkcl luke wrote:
>> allo again: it's been a while since i've been actively been involved
>> with selinux.
>>
>> i just wanted to alert people to the proposal that i put forward to
>> the mozilla B2G team that they consider deploying the FLASK security
>> model (specifically SE/Linux).
>> https://wiki.mozilla.org/Apps/Security#FLASK_for_enforcing_permissions
>> (that's a publicly-editable wiki if anyone wants to comment/edit)
>>
>
> Sounds great, but wouldn't it be more proper to call Flask a Security
> Architecture rather than a Security model?

 ah thank you for the corrections, patrick.  i've updated the wiki
page for them, accordingly.

>> so they've got quite a big - and cool - task ahead of them, and they
>> need a replacement for the android security model.  that's where i
>> went "eyy, i know something that would cope, that would be up to the
>> job and would mean no linux kernel coding required, it's called
>> SE/Linux" :)
>
> Have you seen this page?  SEAndroid
>
> http://selinuxproject.org/page/SEAndroid

 have now - thank you :)


>> second: did that idea of dynamically allowing bits of binary-compiled
>> se-linux permissions ever get implemented?  last time i was on this
>> list (eek, 2004?), the whole SE/Linux precompiled blob was just that:
>> one huge humungous gelatinous blob that you couldn't mess with, not
>> without doing a tooootal recompile using the m4 macros.
>>
>
>
> Excuse me do you mean changing roles or policies on the fly in userland?
> Wouldn't that violate Security models and policies in example MAC, RBAC, MLS
> and anything mandatory?

 ah it's ok - stephen knows what i'm referring to.  apologies patrick,
there's some context i may not have correctly explained, which stephen
remembers.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
