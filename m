Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r31Henoe029278
	for <selinux@tycho.nsa.gov>; Mon, 1 Apr 2013 13:40:49 -0400
Received: by mail-la0-f43.google.com with SMTP id ek20so2320812lab.2
        for <selinux@tycho.nsa.gov>; Mon, 01 Apr 2013 10:40:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130401185508.3d15476e@fornost.bigon.be>
References: <20130321123256.198ba5b6@soldur.bigon.be>
	<5159AEA8.2090004@tresys.com>
	<20130401185508.3d15476e@fornost.bigon.be>
Date: Mon, 1 Apr 2013 13:40:46 -0400
Message-ID: <CACLa4psh+Litc-ko0g7NhQ3BDYRX7_BX1TZqzg4uxYVhZ3VQzw@mail.gmail.com>
Subject: Re: File context not applied due to regex ordering
From: Eric Paris <eparis@parisplace.org>
To: Laurent Bigonville <bigon@debian.org>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I feel like we talked about it...  Regex ordering is a bit tricky.  I
think I hacked up a patch which added an additional tie breaker step
with the total number of 'non-regex' type characters being used.  It's
been long lost though...

Do you still have that hack around?  Maybe we can see what others think?

On Mon, Apr 1, 2013 at 12:55 PM, Laurent Bigonville <bigon@debian.org> wrote:
> Le Mon, 1 Apr 2013 11:58:32 -0400,
> "Christopher J. PeBenito" <cpebenito@tresys.com> a écrit :
>
>> On 03/21/13 07:32, Laurent Bigonville wrote:
>> > Hello,
>> >
>> > I remember that I already talk about this on IRC a while back, but I
>> > don't remember if there was any outcome.
>> >
>> > The refpolicy is containing the following filecontext:
>> >
>> > /usr/(s)?bin/gdm(3)?    --
>> > gen_context(system_u:object_r:xdm_exec_t,s0)
>> >
>> > But for some reasons /usr/sbin/gdm3 is labeled on disk as bin_t
>> > instead of xdm_exec_t. matchpathcon is giving me this:
>> >
>> > /usr/bin/gdm        system_u:object_r:xdm_exec_t:SystemLow
>> > /usr/bin/gdm3       system_u:object_r:xdm_exec_t:SystemLow
>> > /usr/sbin/gdm       system_u:object_r:bin_t:SystemLow
>> > /usr/sbin/gdm3      system_u:object_r:bin_t:SystemLow
>> >
>> > Changing the regex to /usr/s?bin/gdm(3)? fix the issue.
>> >
>> > Shouldn't this be fixed in the userspace libraries?
>>
>> I'm not clear; are you saying this is a file context sorting issue or
>> a matchpathcon error?  Matchpathcon should be able to handle a regex
>> with ()? so I'd guess its a sorting issue.  Since sorting file
>> contexts is tricky, it would probably be simpler to fix the policy.
>>
>
> I don't think this is a matchpathcon error only as the fc applied on
> disk by restorecon are matching the one returned by matchpathcon.
>
> I remember during the discussion on IRC that somebody said that it might
> be related to the order the regex were ordered but nothing more.
>
> I'll propose a patch to fix this particular case, but can we be sure
> this is not happening in other places too?
>
> Cheers
>
> Laurent Bigonville
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
