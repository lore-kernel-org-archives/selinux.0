Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7NDZbas023117
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 09:35:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id e80so2640020oig.2
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 06:35:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9899189e-9352-fdff-2362-47fe1ca7e52b@tycho.nsa.gov>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
 <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
 <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
 <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
 <1471799849.2544.2.camel@trentalancia.net>
 <1471870947.2354.1.camel@trentalancia.net>
 <1471899875.19333.3.camel@trentalancia.net>
 <CAHC9VhQKE3+9KEkPHv4TadChOMsoHovm0pSYwwkAMYY33fDbPw@mail.gmail.com>
 <9899189e-9352-fdff-2362-47fe1ca7e52b@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 23 Aug 2016 09:35:21 -0400
Message-ID: <CAHC9VhQ08yOuosiApLSLCxoP73YSY=igrwJ7kO3qvR1uMwBJoQ@mail.gmail.com>
Subject: Re: [PATCH v4] Classify AF_ALG sockets
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Guido Trentalancia <guido@trentalancia.net>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 23, 2016 at 9:05 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 08/22/2016 06:36 PM, Paul Moore wrote:
>> On Mon, Aug 22, 2016 at 5:04 PM, Guido Trentalancia
>> <guido@trentalancia.net> wrote:
>>> Modify the SELinux kernel code so that it is able to classify sockets with
>>> the new AF_ALG namespace (used for the user-space interface to the kernel
>>> Crypto API).
>>>
>>> A companion patch has been created for the Reference Policy and it will be
>>> posted to its mailing list, once this patch is merged.
>>>
>>> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
>>> ---
>>>  security/selinux/hooks.c            |    5 +++++
>>>  security/selinux/include/classmap.h |    2 ++
>>>  security/selinux/include/security.h |    2 ++
>>>  security/selinux/ss/services.c      |    3 +++
>>>  4 files changed, 12 insertions(+)
>>
>> You are still missing the policy capability code for
>> security/selinux/selinuxfs.c.  I think it would also be a good idea to
>> write a test for this and add it to the selinux-testsuite; not only
>> will this help us confirm this code works as expected, but it will
>> demonstrate what the new policy would look like and help establish a
>> regression test for future use.
>>
>>  * https://github.com/SELinuxProject/selinux-testsuite
>
> I also think that if we are going to go to the trouble of adding a new
> policy capability for this (versus just relying on
> handle_unknown=allow), then we ought to identify and define all socket
> classes that we think we might want.  Otherwise we'll end up with 50
> different policy capabilities, one for each new socket class.

To be clear, we can't rely only on the new/unknown object class
handling for this particular case since this change would convert some
of the existing generic socket access checks to the algsocket access
checks which could result in undesired access for policies which set
handle_unknown=allow.  The new/unknown object class handling works
well for new access controls, but sometimes has problems with modified
access controls.

As far as additional socket classes are concerned, it does some
reasonable to add more than just AF_ALG in an effort to try and
consolidate things.  Guido, is this something you would be willing to
work on?

-- 
paul moore
www.paul-moore.com
