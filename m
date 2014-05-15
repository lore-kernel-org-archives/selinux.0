Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4FJ8ULO024079
 for <selinux@tycho.nsa.gov>; Thu, 15 May 2014 15:08:30 -0400
Message-ID: <537510AB.7050601@redhat.com>
Date: Thu, 15 May 2014 15:08:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Presidency of user/role/type permissions.
References: <5371EA55.703@gmail.com> <53720F8C.8000205@tresys.com>
 <5372239D.3010007@redhat.com> <53730743.1050900@gmail.com>
 <537308E1.4050705@gmail.com> <53736433.1030107@redhat.com>
 <5374FC0B.1080804@gmail.com>
In-Reply-To: <5374FC0B.1080804@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 05/15/2014 01:40 PM, dE wrote:
> On 05/14/14 18:10, Daniel J Walsh wrote:
>> As far as roles/type combinations, most system roles get assigned the
>> system_r role.  This is the vast majority of role/type combination.
>>   seinfo -rsystem_r -x | wc -l
>> 776
>>
>> User roles are assigned based on the _run interfaces, and are built into
>> higher level interfaces to get assigned automatically when you define a
>> new user_r as a user.
>>
>> seinfo -ruser_r -x | wc -l
>> 175
>> seinfo -rguest_r -x | wc -l
>> 95
>
> Since the role has a set of allowed type it acts as an abstraction
> between a new user and the types; simply assigning a user a certain
> role is enough to define the allowed types a process can have under
> the user.
>
> Since I don't know M4 macros, I would request you to clarify 1 more
> question -- when a new type is defined, the macros are used to define
> which roles will this new type be allowed in? Or is it the other way
> around -- the definition of one of the role is modified so as to
> include this new type?
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
The other way around.  You allow a type to be reached within a role.

role myrole_r types newtype_t;

BTW This is for process types (domains).

Usually we add
role system_r types mytype_t;

And then have an interface (m4 function call like:

mytype_run(user_t, user_r)

Then this interface would add a rule like

role user_r types mytype_t;
