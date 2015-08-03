Subject: Re: Does it matter where .cil modules are build.
To: Dan <dtdevore64@yahoo.com>, James Carter <jwcart2@tycho.nsa.gov>,
 selinux@tycho.nsa.gov
References: <55BB0009.4030809@yahoo.com> <55BB827C.5020204@tycho.nsa.gov>
 <55BBD9EE.7030508@yahoo.com>
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <55BF0863.4010304@redhat.com>
Date: Mon, 3 Aug 2015 08:21:23 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
In-Reply-To: <55BBD9EE.7030508@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/31/2015 10:26 PM, Dan wrote:
> Yeah I'm just looking to build selinux policies to confine applications,
> etc, with the cil language and nothing else, so when you say the policy
> store is that the /var/lib/selinux/targeted/active/modules/400 directory?
> 
> On 07/31/2015 10:13 AM, James Carter wrote:
>> On 07/31/2015 12:56 AM, Dan wrote:
>>> Hello everyone,
>>>
>>>       I have been reading up on the cil documentation and am starting
>>> to get the
>>> hang of it and have successfully built my first module. I have a a
>>> module called
>>> test.cil. Now my only question on is where exactly would I put this
>>> module to
>>> build it or does it not matter where you stick them at? I know when
>>> you take the
>>> .pp packages and convert them to .cil  they get stored in
>>> /var/lib/selinux/targeted/active/modules/400, but I'm just using the
>>> secilc
>>> compiler and nothing else to build policy.

/var/lib/selinux is a default location for your module store. It can be
changed in semanage.conf.

Basically if you want to add a local policy module, just use

# semodule -i mypol.cil

This module will be loaded with the default priority for custom policies.

# semodule --list-module=full |grep mypol
400 mypol                    cil

>>>
>>
>> If you are using the CIL compiler to build the whole policy, then it
>> doesn't matter where the files are located. Just specify all of the
>> files that are part of the policy on the command line for secilc.
>>
>> Do note that the CIL compiler does not build modules, it builds the
>> complete policy, so if you are only building a module than it should
>> go into the policy store. You should also use the policy store if you
>> want to use the management functions of semanage.
>>
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
