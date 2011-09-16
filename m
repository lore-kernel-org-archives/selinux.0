Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GGgsMa030511
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 12:42:54 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8GGgqSZ021764
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 16:42:53 GMT
Message-ID: <4E737C89.5030308@tresys.com>
Date: Fri, 16 Sep 2011 12:42:49 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: CIL compiler
References: <1316186640.82932.YahooMailClassic@web87010.mail.ird.yahoo.com>
In-Reply-To: <1316186640.82932.YahooMailClassic@web87010.mail.ird.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Looks like just a typo. The second typetransition rule in the optional
move_file references out_file_t, which should be move_file.out_file_t.

out_file_t is out of scope, so the optional always fails, even if
move_file.cil is included.

- Steve

On 09/16/2011 11:24 AM, Richard Haines wrote:
> Steve,
> 
> Please find attached the 'optional' problem code. There is a README in the tarball + all the modules.
> 
> Thanks for your help.
> Richard
> 
> --- On Thu, 15/9/11, Steve Lawrence <slawrence@tresys.com> wrote:
> 
>> From: Steve Lawrence <slawrence@tresys.com>
>> Subject: Re: CIL compiler
>> To: "Richard Haines" <richard_c_haines@btinternet.com>
>> Cc: selinux@tycho.nsa.gov
>> Date: Thursday, 15 September, 2011, 18:48
>> On 09/15/2011 12:21 PM, Richard
>> Haines wrote:
>>> Thanks for the Initial SID fix. It works fine.
>>>
>>> I've been experimenting with CIL using a basic base
>> policy (similar to mdp) and blocks to build binary policy
>> files. I've checked these with apol and loaded them with
>> only two issues found so far:
>>
>> Great! We love to get feedback.
>>
>>> 1) The 'booleanif' does not expand the AV or TYPE
>> rules into the binary. apol does not list anything under
>> 'Conditional Expressions' and the policy will not load.
>>
>> Yes, we discovered that issue this week, and believe we
>> have a fix, but
>> are unsure if it's the 'right' fix. Hopefully, we'll have
>> this resolved
>> soon.
>>
>>> 2) The 'optional' sections are not expanded into the
>> binary when the dependencies are resolved. The policy is
>> still loadable.
>>
>> This seems to work correctly for me. Can you provide the
>> CIL code you're
>> using that's not working?
>>
>>> I also notice that as the CIL dev team work through
>> the changes, the policy requirements change slightly. For
>> example the allow rule format changed because of the
>> permission set changes and the roles for object_r need to be
>> fully defined. These are not an issue - just noting them in
>> case others are testing CIL as well.
>>
>> Yes, the language is still somewhat in flux so some things
>> will break.
>> When we do a release we'll give a full list of what
>> changed. But if
>> you're playing with the latest and greatest from git,
>> things might break
>> without warning. We'll try to keep the wiki up to date with
>> the current
>> git repo though, so that should be a source of what's new
>> (the
>> permission set changes haven't made it to the wiki yet,
>> though). If you
>> notice anything missing, please let us know and we'll make
>> sure we get
>> it fixed.
>>
>> Thanks,
>> - Steve
>>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
