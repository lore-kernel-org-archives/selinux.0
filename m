Message-ID: <4E3F7662.8090609@windriver.com>
Date: Mon, 8 Aug 2011 13:38:42 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux
	<selinux@tycho.nsa.gov>
Subject: Re: checkpolicy is broken (which is not)
References: <4E3AEA75.3090602@redhat.com> <4E3B3D39.4020700@windriver.com>  <4E3B441A.1090900@windriver.com> <4E3B5593.7000502@redhat.com>  <4E3B6F5B.40904@windriver.com> <1312548982.19283.14.camel@moss-pluto> <4E3BE94F.9010104@redhat.com>
In-Reply-To: <4E3BE94F.9010104@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Dan,

Daniel J Walsh 写道:
> On 08/05/2011 08:56 AM, Stephen Smalley wrote:
>   
>> On Fri, 2011-08-05 at 12:19 +0800, Harry Ciao wrote:
>>     
>>> Hi Eric,
>>>
>>> Let me explain more about the background story.
>>>
>>> The existing type rule could declare a type, and optionally 
>>> associate it with a list of type attributes. So I invented this 
>>> "role <regular role> attribute <a list of role attributes>" rule
>>> in the same manner to do the similar things for roles, since I
>>> figure this would make refpolicy rules similar and easy to remember
>>> and use.
>>>
>>> Now that the above new role-attr rule takes care of declaring 
>>> roles, this duty has to be removed from role-type rule in order to 
>>> avoid ambiguity, and the role-type rule would be used to only 
>>> associate types with roles, which only requires TWO lines of code 
>>> as in 3cbc9727, since mostly used roles such as system_r have been 
>>> declared in kernel.te(in order to avoid some build failure).
>>>
>>> In a word, we could preserve the behavior of role-type rule, but 
>>> this would introduce discrepancy between that of role-attr rule
>>> and type-attr rule, considering that getting used to the new
>>> toolchain only requires an easy cherry-pick of only 2 lines of
>>> change, would it be that desirable for us to do so?
>>>       
>> I don't think we should introduce an incompatible policy language 
>> change without very strong reasons.  It is fine to introduce new 
>> constructs like your role...attribute construct, but we shouldn't 
>> change the meaning of role...type statements and thereby render 
>> invalid policies that used to be valid.
>>
>>     
>
> Well I will say that I thought the old construct did not make sense,
> since we have to declare most objects in the lanquage except for roles.
>
> This will help to find problems in the policy also like people doing
>
> role httpd_t types httpd_t;
>
> Which I have seen in the past.
>
>   
During developing role-attribute patchset, I'd discovered two similar
mistakes after removing implicit role declaration from role-type rule:

1. mozilla_run_plugin(mozilla_t, $2)
2. seutil_run_semanage(lsassd_t, lsassd_t)

Both of them had been fixed in the latest refpolicy.

If people prefer to older refpolicy with the latest toolchain, I would
suggest them to cherry-pick fixes for above two obvious mistakes.

> I just got the new toolchain to work with Fedora policy.
>
>   
Thanks! Any further issue with the role-attribute rules, just let me know!

Cheers,
Harry


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
