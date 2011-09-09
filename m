Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p891TLYQ011142
	for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2011 21:29:21 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p891TJMk024405
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 01:29:20 GMT
Message-ID: <4E696BB3.1040004@windriver.com>
Date: Fri, 9 Sep 2011 09:28:19 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: Re: v2 Discard unused tunables from raw policy
References: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com> <CACLa4puGPT4Fc7VgTQ3Xkz94E-epJBsWaDDhzhPOuntLfmaA7Q@mail.gmail.com>
In-Reply-To: <CACLa4puGPT4Fc7VgTQ3Xkz94E-epJBsWaDDhzhPOuntLfmaA7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Eric,

Eric Paris 写道:
> On Wed, Aug 31, 2011 at 11:29 PM, Harry Ciao <qingtao.cao@windriver.com> wrote:
>
>   
>> Differences from v1
>> --------------------
>>
>> The v2 patchset just provides two minor changes from v1:
>>
>> 1. 0008-Preserve-tunables-when-required-by-semodule-program.patch
>>   Extract the codes to make use of sh->preserve_tunables flag in discard_tunable()
>>   from the 0007 patch in v1, and present them in this separate 0008 patch;
>>
>> 2. 0007-Create-a-new-preserve_tunables-flag-in-sepol_handle_.patch
>>   Fix an obvious error to mistakenly set sh->preserve_tunables flag in
>>   semanage_direct_connect(), which should be solely set according to the options
>>   passed for the semodule program.
>>
>>   Then the preserve_tunables flag file in the module store could be properly
>>   removed if no "-P/--preserve_tunables" option used for semodule.
>>     
>
> I tried to build fedora policy with this patch set and it didn't work
> out this time.  It complains about:
>
> libsepol.bool_copy_callback: ppp: Mismatch between boolean/tunable
> definition and usage for secure_mode_insmod
> /usr/bin/semodule_link:  Error while linking packages
>
>   
The directly reason is the secure_mod_insmod boolean is used along with
pppd_can_insmod tunable in ppp.te in the tunable_policy() macro.
Apparently ppp.pp is linked first with the assumption of
secure_mod_insmod being required as a tunable. Later, when the module
that actually presents the definition of secure_mode_insmod is linked
the link process would find it is declared as a boolean. That's why you
have run into above error message.

I have taken Chris's suggestion to error out rather than just printing
warning messages about the mixture of any tunable with boolean. In order
to support this change Chris has transformed the definition of
pppd_can_insmod from gen_tunable() to gen_bool(), and use an explicit
if-else conditional to replace the call of tunable_policy(). (BTW, we
can use the boolean_policy() once the whole patchset is merged since
both pppd_can_insmod and secure_mode_insmod are booleans now)

Therefore please try to cherry-pick the commit of 68bbbbde to resolve
this problem.

Thanks,
Harry

> And then stops building.  I know you mentioned this as a known issue,
> but previously I don't remember it failing to build.  All I did was
> apply the 8 patches in this series, then apply the 4 patches to policy
> you sent a long time ago.  Applying those 4 to fedora policy still
> meant a couple of minor changes, but nothing directly to ppp.{te,if}
>
> -Eric
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
