Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2O2V0MM007185
	for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2011 22:31:00 -0400
Received: from mail-px0-f169.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p2O2UxHX002162
	for <selinux@tycho.nsa.gov>; Thu, 24 Mar 2011 02:31:00 GMT
Received: by pxi9 with SMTP id 9so1526820pxi.0
        for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2011 19:30:59 -0700 (PDT)
Message-ID: <4D8AACD9.60505@gmail.com>
Date: Wed, 23 Mar 2011 19:30:49 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov,
        xorg@lists.freedesktop.org
Subject: Re: SELinux: avc_has_perm: unexpected error 22
References: <4D878244.4060502@gmail.com> <4D8A36E9.3070601@gmail.com>
In-Reply-To: <4D8A36E9.3070601@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/23/2011 11:07 AM, Justin P. Mattock wrote:
> On 03/21/2011 09:52 AM, Justin P. Mattock wrote:
>> this is showing up with the latest Mainline kernel.
>> gdm craps out..:
>>
>> [ 60.817] (II) Unloading synaptics
>> [ 60.822] SELinux: avc_has_perm: unexpected error 22
>> [ 60.822] SELinux: avc_has_perm: unexpected error 22
>> [ 60.828] SELinux: avc_has_perm: unexpected error 22
>> [ 60.831] SELinux: avc_has_perm: unexpected error 22
>> [ 60.871] SELinux: avc_has_perm: unexpected error 22
>> [ 60.871] SELinux: avc_has_perm: unexpected error 22
>> [ 60.881] (II) UnloadModule: "mouse"
>> [ 60.881] (II) Unloading mouse
>>
>>
>> full xorg.0.log is here:
>> http://fpaste.org/OOM2/
>>
>> Justin P. Mattock
>
> seems doing a bisect right now during the merge window is breaking,
> anyways looking through the commits I think this:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c53fa1ed92cd671a1dfb1e7569e9ab672612ddc6;hp=06dc94b1ed05f91e246315afeb1c652d6d0dc9ab
>
>
> might be what I am hitting, causing gdm to die out, as it starts.
>
> any ideas?
>
> Justin P. Mattock

not sure if anybody is seeing this or hitting this with the current,
but reverting the above commit does not fix the problem.
will try another bisect(hopefully)

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
