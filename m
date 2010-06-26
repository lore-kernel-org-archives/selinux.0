Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5QNO1sn006559
	for <selinux@tycho.nsa.gov>; Sat, 26 Jun 2010 19:24:01 -0400
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5QNPfqI024316
	for <selinux@tycho.nsa.gov>; Sat, 26 Jun 2010 23:25:41 GMT
Received: by pxi6 with SMTP id 6so182329pxi.12
        for <selinux@tycho.nsa.gov>; Sat, 26 Jun 2010 16:23:58 -0700 (PDT)
Message-ID: <4C268C1F.4090001@gmail.com>
Date: Sat, 26 Jun 2010 16:24:15 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Joshua Kramer <josh@globalherald.net>
CC: selinux@tycho.nsa.gov
Subject: Re: Rebuilding Modified Base Policy on RHEL6 (was  on-Computing Abstractions
 & An Issue Thereof)
References: <289557.20002.qm@web87003.mail.ird.yahoo.com> <4C2652F3.8010309@globalherald.net> <4C2687E7.5000705@globalherald.net>
In-Reply-To: <4C2687E7.5000705@globalherald.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/26/2010 04:06 PM, Joshua Kramer wrote:
>
>> Is the method for rebuilding policy explained in the following guide,
>> still effective for RHEL6?
>> http://danwalsh.livejournal.com/26428.html
>>
> Ok, so I followed the instructions on the noted page; specifically, near
> the bottom. This line works to rebuild policy on RHEL6:
>
> *make validate UNK_PERMS=allow NAME=strict TYPE=mcs DISTRO=redhat UBAC=n
> DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024 base
>
> However, if I do this*, to switch the build from strict to targeted:
>
> cd ~/sources/BUILD/serefpolicy-VERSION
> make UNK_PERMS=allow NAME=targeted TYPE=mcs DISTRO=redhat UBAC=n
> DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024 bare
> make conf
> make UNK_PERMS=allow NAME=targeted TYPE=mcs DISTRO=redhat UBAC=n
> DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024 conf
>
> ...the make breaks with this error:
>
> Creating targeted base module base.conf
> cat tmp/pre_te_files.conf tmp/all_attrs_types.conf tmp/global_bools.conf
> tmp/only_te_rules.conf tmp/all_post.conf > base.conf
> Compiling targeted base module
> /usr/bin/checkmodule -M -U allow base.conf -o tmp/base.mod
> /usr/bin/checkmodule: loading policy configuration from base.conf
> policy/modules/kernel/domain.te":195:ERROR 'type selinux_config_t is not
> within scope' at token ';' on line 9468:
> #line 195
> dontaudit domain selinux_config_t:dir { getattr search open };
> /usr/bin/checkmodule: error(s) encountered while parsing configuration
> make: *** [tmp/base.mod] Error 1
>
> It breaks even with a non-modified policy (i.e. install src.rpm and run
> this make command).
>
> Do I need to do this, even if I only want to build a modified "targeted"
> version of the policy? Is it "strict" by default?
>
> Thanks,
> -Josh
>


thats a bug in flex(tried to bisect flex a while back, but found myself 
in a nightmare doing so). one thing I do when I hit this is downgrade 
flex to 2.5.4a then build only checkmodule/policy then try the policy 
again(just remember to put flex back to the latest afterwards)

hope this helps,

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
