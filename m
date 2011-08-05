Message-ID: <4E3C2720.7030303@redhat.com>
Date: Fri, 05 Aug 2011 13:23:44 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, qingtao.cao@windriver.com,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: checkpolicy is broken (which is not)
References: <4E3AEA75.3090602@redhat.com> <4E3B3D39.4020700@windriver.com>  <4E3B441A.1090900@windriver.com> <4E3B5593.7000502@redhat.com>  <4E3B6F5B.40904@windriver.com> <1312548982.19283.14.camel@moss-pluto> <1312563512.23489.17.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1312563512.23489.17.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/05/2011 12:58 PM, James Carter wrote:
> On Fri, 2011-08-05 at 08:56 -0400, Stephen Smalley wrote:

>> I don't think we should introduce an incompatible policy language change
>> without very strong reasons.  It is fine to introduce new constructs
>> like your role...attribute construct, but we shouldn't change the
>> meaning of role...type statements and thereby render invalid policies
>> that used to be valid.
>>
> 
> In the up and coming CIL compiler, declaration and use are always
> separate, so user, role, and type rules are only used to declare. There
> are typealias, typeattribute, and other such rules to define
> associations. For a role there is a separate roletype rule to associate
> a type with a role.
> 
> So if roletype and roleattribute rules were created for the current
> toolchain, the current role rule would not have to be changed. Newer
> policies could use the role rule only to declare a role, but it could
> still be used in the old way for backwards compatibility.

Sounds to me like there is enough interest in compatiblity that we
should make the current toolchain continue to allow the old role X type
Y rules to also be a declaration.  In the new CIL toolchain we will make
the syntax more strict and require better policy definitions.  Harry, is
this patch something you can take a moment and write?  Thanks!

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
