Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7AEmRab006176
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 10:48:27 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7AEmImM014395
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 14:48:18 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7) with ESMTP id k7AEmGw2025013
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 10:48:16 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k7AEmGlT025012
	for selinux@tycho.nsa.gov; Thu, 10 Aug 2006 10:48:16 -0400
Message-ID: <44DB4585.3070500@redhat.com>
Date: Thu, 10 Aug 2006 10:41:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Meyering <jim@meyering.net>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: does mv need a --context=CTX (-Z) option, too?
References: <87hd0kc308.fsf@rho.meyering.net>	<1155218058.1123.301.camel@moss-spartans.epoch.ncsc.mil> <874pwkll7v.fsf@rho.meyering.net>
In-Reply-To: <874pwkll7v.fsf@rho.meyering.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jim Meyering wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>   
>> On Thu, 2006-08-10 at 12:13 +0200, Jim Meyering wrote:
>>     
>>> It might make sense to add a --context=CTX (-Z) option to mv.  Currently,
>>> cp, install, mkdir, mknod, mkfifo all have that option, but not mv.
>>> Most of the time, mv would have no need, since it simply calls rename.
>>> But when that fails, it reverts to using the very same copying code
>>> (copy.c) that cp uses.  It is trivial to add this option to mv, with the
>>> understanding that it'd take effect solely for e.g., cross-device moves.
>>> I.e., if you want to simulate a cross device move, you'd have to use
>>> cp -pr and rm -rf, so if it makes sense for cp to have the --context=CTX
>>> (-Z) option, then it follows that mv must accept it as well.
>>>       
>> mv should just preserve the context of the original in all cases,
>> whether it is just doing a rename(2) or copying the file.
>>     
>
> What if it's not possible to preserve the original, yet it
> would be possible to set some other desirable context?
>
> Stepping back a little, if mv doesn't need the option, then why
> does cp need it?  After all, cp has no option to set classic
> permissions.
>
>   
I agree cp should not need this qualifier.  It should either be preserve 
or get the new default context.
mv should just try to preserve
install should use the matchpathcon similar to rpm.
>>> This brings up another minor inconsistency: should the other
>>> named-file-creation programs (dd, ln, link, touch) in coreutils also
>>> accept the --context=CTX (-Z) option?
>>>       
>> ln/link likewise wouldn't need it, as it is the inodes that are labeled,
>> not the links.  Unless you mean for ln -s, where the symlink itself has
>> a label.
>>     
>
> You're right that link isn't an issue.
> However, for consistency, ln (for -s), dd, and touch seem like
> they would need the new option, No?
>
>   
>>> With that only partly rhetorical question, you should see why I'd like
>>> an selinux/kernel hook that'd let me set the default fscreate context
>>> for the upcoming execve.  Then I could simply add one option to runcon
>>> and forget about all of these "-Z CTX" options.  IMHO, requiring all of
>>> these tools to add an option like "-Z CTX" to perform the same simple
>>> function is almost prohibitively onerous.
>>>       
>> It's consistent with the idea of MAC being a first class citizen of
>> Linux, just like file owner/mode/ACL.
>>     
>
> Slightly off-topic...
> What if ACLs come into vogue?
> Should I expect (longer term) to have an option to set
> an ACL as well, in each of these programs?
>
>   
No I think we should follow the DAC rules.
>> Now, as far as preserving fscreate across execve goes, doing that in the
>> case where there is no change in the current context of the task is
>> conceivable (so no implications for letting the caller influence the
>> program), although it would be a change in behavior that has been
>> present for quite some time (and seems rather late to make it into e.g.
>> RHEL5 or FC6).
>>     
>
> I don't expect any of these upstream coreutils changes to affect RHEL5
> or FC6 either, so that's fine.  The important thing, from my standpoint,
> is to avoid adding these -Z options if they're not absolutely necessary.
>
>   
>> I have no strong opinion on that, but it could introduce
>> unexpected behaviors; some programs today might be setting fscreate and
>> exec'ing helpers while not expecting the helpers to pick up that
>> fscreate context.
>>     
>
> But if there is some *new* interface (and underlying data structure
> support) that sets the to-be-used-upon-exec fscreate context, then
> no preexisting program would be affected, since they wouldn't be
> using the new interface.
>
> I'd like to be able to write a new program (let's call it fscon) that'd
> take an fscreate context, FSC and exec a user-specified program for
> which FSC would be the default.
>
> That would obviate most of these -Z options, and more importantly, would
> help more applications work with SELinux without requiring source changes.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
