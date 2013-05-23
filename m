MIME-Version: 1.0
In-Reply-To: <519E0BF2.9000902@redhat.com>
References: <20130523005354.418a2541@fornost.bigon.be>
	<CAPzO=NzDH47Ksfc4o7F=citU7DR1BF0VF0QFrCFNB82M7FfakA@mail.gmail.com>
	<20130523095747.22818ef6@soldur.bigon.be>
	<519E073F.80803@tycho.nsa.gov>
	<519E0BF2.9000902@redhat.com>
Date: Thu, 23 May 2013 08:36:56 -0400
Message-ID: <CADjGSjg_Mk-V82ZvP+rJJnFhkyMRaiXgerK9WJP=kyG_cwbU6Q@mail.gmail.com>
Subject: Re: Last version of policycoreutils using Fedora only API
From: Joshua Brindle <brindle@quarksecurity.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Laurent Bigonville <bigon@debian.org>,
        Sven Vermeulen <sven.vermeulen@siphos.be>,
        SELinux <SELinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What were the relevant git hashes?


On Thu, May 23, 2013 at 8:30 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/23/2013 08:10 AM, Stephen Smalley wrote:
>> On 05/23/2013 03:57 AM, Laurent Bigonville wrote:
>>> Le Thu, 23 May 2013 07:30:18 +0200, Sven Vermeulen
>>> <sven.vermeulen@siphos.be> a ￩crit :
>>>
>>>> On May 23, 2013 1:09 AM, "Laurent Bigonville" <bigon@debian.org>
>>>> wrote:
>>>>> The last release of policycoreutils is using a function
>>>>> (selinux_current_policy_path()) that is only available in Fedora. I
>>>>> guess this shouldn't have made upstream.
>>>>>
>>>>> An idea how this could be sorted for other distributions?
>>>>
>>>> Please see my answer to Joshua's announcement on the new userspace.
>>>
>>> Oh thanks, I messed this.
>>>
>>>> You'll need to add in the function.
>>>
>>> Well I'm not a big fan of adding function in libraries that are not
>>> merged upstream. IIRC eparis told me on IRC that he has not happy with
>>> this new functions.
>>
>> Maybe we should back out the relevant changes and cut another release? I
>> agree that it is wrong for an upstream release to have Fedora-specific
>> dependencies.
>>
>>
>>
>> -- This message was distributed to subscribers of the selinux mailing
>> list. If you no longer wish to subscribe, send mail to
>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
>> as the message.
> Yes this was a mistake.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.13 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlGeC/IACgkQrlYvE4MpobO9eQCg4nKtXkiv/rEIaCeDw8bOH0n/
> 9GUAnji3pwYR6v9YeIzyR51Imj6RSWSM
> =xXXJ
> -----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
