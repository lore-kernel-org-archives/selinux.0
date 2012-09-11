Message-ID: <504F57CB.30502@manicmethod.com>
Date: Tue, 11 Sep 2012 11:24:59 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: mmac-4.1.1?
References: <504F43EF.4030900@manicmethod.com> <1347375110.18749.2.camel@moss-pluto.epoch.ncsc.mil> <504F5778.4010600@manicmethod.com>
In-Reply-To: <504F5778.4010600@manicmethod.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On Tue, 2012-09-11 at 10:00 -0400, Joshua Brindle wrote:
>>> I'm wondering if there are plans for an mmac-4.1.1 branch? I see
>>> mmac-4.0.4 and mmac (which I assume tracks master). I'd like
>>> install-time and revocation mmac in 4.1.1. Perhaps I'm missing a branch
>>> that provides that?
>>
>> We merged the install-time MAC support into our main seandroid branches
>> (i.e. seandroid, seandroid-4.0.4, and seandroid-4.1.1) back in July.
>> Since that time, mmac and mmac-4.0.4 haven't been maintained - they are
>> dead (and I don't think they even exist on bitbucket).
>>
>> We did recently create revoke-perms-jb and tagprop-jb branches with
>> rebased versions of the revoke-perms and tagprop changes. You should in
>> theory be able to cherry-pick changes from those branches onto
>> seandroid-4.1.1. But we haven't been doing much with them of late.
>>
>
> Okay. Looking at the log of revoke-perms-jb it seems like the only
> commit of interest is this one, is that correct?
>
> commit 5ab263eb610d30528134bb28fee5fd83a0bb98aa
> Author: rpcraig <rpcraig@tycho.ncsc.mil>
> Date: Fri Aug 24 06:59:51 2012 -0400
>
> Add revoke permission ability.
>
> Functionality is driven by policy file. This is a
> departure from the CyanogenMod-esque way of doing
> revocation. No user involvment.

Silly me, that was framework/base, do you know offhand which other 
projects I should look at?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
