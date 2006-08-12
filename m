Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7CHhvgO004667
	for <selinux@tycho.nsa.gov>; Sat, 12 Aug 2006 13:43:57 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7CHhkTB003834
	for <selinux@tycho.nsa.gov>; Sat, 12 Aug 2006 17:43:46 GMT
Message-ID: <44DE134A.3030104@redhat.com>
Date: Sat, 12 Aug 2006 13:43:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Meyering <jim@meyering.net>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Russell Coker <russell@coker.com.au>
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like mkdir
References: <87mzabgyrk.fsf@rho.meyering.net>	<1155308294.8018.59.camel@localhost.localdomain> <87irkzfcgr.fsf@rho.meyering.net>
In-Reply-To: <87irkzfcgr.fsf@rho.meyering.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jim Meyering wrote:
> Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:
>
>   
>> On Fri, 2006-08-11 at 15:58 +0200, Jim Meyering wrote:
>>     
>>> Hello again,
>>>
>>> With clear agreement that neither cp nor mv needs the --context=CTX (-Z)
>>> option, I am nearly convinced that the this option does not belong in any
>>> other program in upstream coreutils.  [of course, I expect it to remain
>>> in RHEL and probably in Fedora for some time]  Upstream coreutils will
>>> display contexts (stat, ls, uname), and preserve them (cp, mv, install?),
>>> and add chcon+runcon, but that's all.
>>>
>>> For a little context on why, ...
>>> I'm also considering the xattr patch that's been floating around for
>>> years.  Currently it's part of SuSE's coreutils patch set.  It ensures
>>> that mv and cp -p preserve any (selected) XATTR attributes.
>>>       
>> Only selected attributes or you can optionally preserve only a subset?
>> I.e., is the default to preserve all?
>>     
>
> mv tries to preserve all of them.
> That patch set adds this option to cp:
>
>       --attributes=regex       preserve extended attributes whose name
>                                matches the specified regular expression
>                                (defaults to preserving all extended
>                                attributes except file permissions;
>                                regex=`-' preserves no extended attributes).
>
>   
>>>   There is
>>> no option to let install(1) apply XATTR attributes.
>>>       
>> Is there a need for this? I have no idea.
>>
>>     
>>>   Nor mkdir, mkfifo,
>>> mknod.  Similarly for the ACL support that's widely available, there is
>>> no option to let those programs apply a specified ACL.  Why should
>>> SELinux security contexts be treated differently?
>>>       
>> Acls are a discretionary mechanism and it is, therefore, appropriate for
>> them to be applied by users after file creation.
>>
>> SELinux is fundamentally different as a mandatory mechanism and a core
>> property is that objects should be labeled correctly at creation time.
>>     
>
> If using chcon is sometimes not an option for a user who must be able
> to create files in a non-default context, then we have to choose between:
>
>   1) adding the --context=CTX (-Z) option to many of the programs
>       that create a named output file.
>
>   2) providing a tool to change the fscreate context for an exec'd program
>
> The latter seems much cleaner.
> Is there any hope on that front?
> The problem is that if I add an options upstream, it's
> a big deal/hassle to remove it later, if a more appropriate
> mechanism becomes available.  As long as there's a hint
> of hope for a cleaner approach, I'm extremely reluctant
> to impose on the coreutils something that looks like a kludge.
>
> ...
>   
>>> BTW, what makes install so special that it needs to call matchpathcon?
>>> Can it accomplish the same goal via "chcon ...;
>>> install --preserve-context ..."?
>>>       
>> It allows install to correctly label for different policies, including
>> policies distributed separately from the application. Otherwise the
>> makefile must hardcode all possible labels in the chcon statements or
>> provide a mechanism that is essentially matchpathcon.
>>
>> This could be done with the separate matchpatcon utility though, so I
>> wouldn't be against dropping this.
>>     
>
> Thanks for explaining.
> If install really needs -Z, I'd prefer to drop its internal
> use of matchpathcon.
>   
-Z implies that the builder of the application knows the security 
context for all possible environemnts.  Matchpatchcon asks the system 
how a file in a certain path should be labeled.  They are very different 
things.

Two different machines running the same install could/should have 
different end file context.  For example a strict policy machine might 
label firefox, mozilla_exec_t, while a targeted might label it bin_t.
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
