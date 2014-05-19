Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4J3C6AR006409
 for <selinux@tycho.nsa.gov>; Sun, 18 May 2014 23:12:06 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so5137311pad.39
 for <selinux@tycho.nsa.gov>; Sun, 18 May 2014 20:12:07 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.89.151])
 by mx.google.com with ESMTPSA id qj3sm27169497pbc.91.2014.05.18.20.12.05
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 18 May 2014 20:12:06 -0700 (PDT)
Message-ID: <537975E8.8020104@gmail.com>
Date: Mon, 19 May 2014 08:39:28 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Presidency of user/role/type permissions.
References: <5371EA55.703@gmail.com> <53720F8C.8000205@tresys.com>
 <5372239D.3010007@redhat.com> <53730743.1050900@gmail.com>
 <537308E1.4050705@gmail.com> <53736433.1030107@redhat.com>
 <5374FC0B.1080804@gmail.com> <537510AB.7050601@redhat.com>
In-Reply-To: <537510AB.7050601@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/16/14 00:38, Daniel J Walsh wrote:
> On 05/15/2014 01:40 PM, dE wrote:
>> On 05/14/14 18:10, Daniel J Walsh wrote:
>>> As far as roles/type combinations, most system roles get assigned the
>>> system_r role.  This is the vast majority of role/type combination.
>>>    seinfo -rsystem_r -x | wc -l
>>> 776
>>>
>>> User roles are assigned based on the _run interfaces, and are built into
>>> higher level interfaces to get assigned automatically when you define a
>>> new user_r as a user.
>>>
>>> seinfo -ruser_r -x | wc -l
>>> 175
>>> seinfo -rguest_r -x | wc -l
>>> 95
>> Since the role has a set of allowed type it acts as an abstraction
>> between a new user and the types; simply assigning a user a certain
>> role is enough to define the allowed types a process can have under
>> the user.
>>
>> Since I don't know M4 macros, I would request you to clarify 1 more
>> question -- when a new type is defined, the macros are used to define
>> which roles will this new type be allowed in? Or is it the other way
>> around -- the definition of one of the role is modified so as to
>> include this new type?
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
> The other way around.  You allow a type to be reached within a role.
>
> role myrole_r types newtype_t;
>
> BTW This is for process types (domains).
>
> Usually we add
> role system_r types mytype_t;
>
> And then have an interface (m4 function call like:
>
> mytype_run(user_t, user_r)
>
> Then this interface would add a rule like
>
> role user_r types mytype_t;
>
>

Ok. Thanks for clarifying that.
