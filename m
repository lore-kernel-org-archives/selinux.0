Message-ID: <519E0F02.8070200@redhat.com>
Date: Thu, 23 May 2013 08:43:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <brindle@quarksecurity.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Laurent Bigonville <bigon@debian.org>,
        Sven Vermeulen <sven.vermeulen@siphos.be>,
        SELinux <SELinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Subject: Re: Last version of policycoreutils using Fedora only API
References: <20130523005354.418a2541@fornost.bigon.be> <CAPzO=NzDH47Ksfc4o7F=citU7DR1BF0VF0QFrCFNB82M7FfakA@mail.gmail.com> <20130523095747.22818ef6@soldur.bigon.be> <519E073F.80803@tycho.nsa.gov> <519E0BF2.9000902@redhat.com> <CADjGSjg_Mk-V82ZvP+rJJnFhkyMRaiXgerK9WJP=kyG_cwbU6Q@mail.gmail.com>
In-Reply-To: <CADjGSjg_Mk-V82ZvP+rJJnFhkyMRaiXgerK9WJP=kyG_cwbU6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/23/2013 08:36 AM, Joshua Brindle wrote:
> What were the relevant git hashes?
> 
> 
> On Thu, May 23, 2013 at 8:30 AM, Daniel J Walsh <dwalsh@redhat.com> wrote: 
> On 05/23/2013 08:10 AM, Stephen Smalley wrote:
>>>> On 05/23/2013 03:57 AM, Laurent Bigonville wrote:
>>>>> Le Thu, 23 May 2013 07:30:18 +0200, Sven Vermeulen 
>>>>> <sven.vermeulen@siphos.be> a ￩crit :
>>>>> 
>>>>>> On May 23, 2013 1:09 AM, "Laurent Bigonville" <bigon@debian.org> 
>>>>>> wrote:
>>>>>>> The last release of policycoreutils is using a function 
>>>>>>> (selinux_current_policy_path()) that is only available in
>>>>>>> Fedora. I guess this shouldn't have made upstream.
>>>>>>> 
>>>>>>> An idea how this could be sorted for other distributions?
>>>>>> 
>>>>>> Please see my answer to Joshua's announcement on the new
>>>>>> userspace.
>>>>> 
>>>>> Oh thanks, I messed this.
>>>>> 
>>>>>> You'll need to add in the function.
>>>>> 
>>>>> Well I'm not a big fan of adding function in libraries that are
>>>>> not merged upstream. IIRC eparis told me on IRC that he has not
>>>>> happy with this new functions.
>>>> 
>>>> Maybe we should back out the relevant changes and cut another
>>>> release? I agree that it is wrong for an upstream release to have
>>>> Fedora-specific dependencies.
>>>> 
>>>> 
>>>> 
>>>> -- This message was distributed to subscribers of the selinux
>>>> mailing list. If you no longer wish to subscribe, send mail to 
>>>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
>>>> quotes as the message.
> Yes this was a mistake.

Lets wait for Eric to chime in and get this resolved.  We have a ton of new
patches that I would also like to get upstream.  :^)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGeDwIACgkQrlYvE4MpobPd6ACgmU/OGZnyAh+Cvt38qB0SkBf5
W58AoJKGMgJZ0nHe5Xu49FeVsvT8EaPA
=VC28
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
