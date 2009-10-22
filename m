Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9M7I93c005108
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 03:18:09 -0400
Received: from mail-ew0-f207.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9M7HF5V016757
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 07:17:16 GMT
Received: by ewy3 with SMTP id 3so253800ewy.41
        for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 00:18:07 -0700 (PDT)
Message-ID: <4AE00737.60801@gmail.com>
Date: Thu, 22 Oct 2009 00:18:15 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: 'make policy' issues
References: <4ADF2358.4050606@laganowski.net>	<1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>	<4ADF2663.2030105@laganowski.net>	<1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>	<87hbtsvhru.fsf@anzu.internal.golden-gryphon.com>	<4ADF3D2C.2030408@laganowski.net> <87oco0c748.fsf@anzu.internal.golden-gryphon.com>
In-Reply-To: <87oco0c748.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Manoj Srivastava wrote:
> On Wed, Oct 21 2009, Eric Laganowski wrote:
>
>    
>> Manoj Srivastava wrote:
>>      
>>> On Wed, Oct 21 2009, Stephen Smalley wrote:
>>>
>>>        
>>>>> Re flex: What is the requirement for flex from selinux
>>>>> perspective? Is it known what build of flex is "known good"?
>>>>>
>>>>>            
>>>> My impression is that one of the patches carried by the distributions
>>>> for flex is needed for checkpolicy to work, but no one has ever fully
>>>> investigated the precise dependency - people just grab the Fedora srpm
>>>> and apply those patches to flex, and then rebuild checkpolicy and it
>>>> works.  I haven't seen any complaints from Debian or Gentoo so I presume
>>>> that they also carry the same patches for flex.
>>>>
>>>> flex -V here also shows 2.5.35.  But there are three patches in the
>>>> Fedora package.  Attached.
>>>>
>>>>          
>>>          Debian currently carries 13 (though 3 of them need to be
>>>   squashed together) patches against 2.5.35. I can make them available if
>>>   there is interest.
>>>
>>>          manoj
>>>
>>>        
>> Yes please. Patches would be welcome.
>>      
>
>          ok. I have put all the patches at:
>   http://www.golden-gryphon.com/software/misc/flex-patches/
>
>          If you want to browse the git repository and see which topic
>   branches these patches come from, you may browse the repo at:
>     http://git.debian.org/?p=users/srivasta/debian/flex.git
>
>          The upstream sources are in the upstream branch, and the various
>   topic--[!old]foo branches are feature branches, and master is the
>   integration branch that Debian packages are built from.
>
>          I hope this helps.
>
>          manoj
>    
Cool, thanks for those.
not sure if I'm hitting the same issue,
but I am hitting something.
from checkpolicy crapping out to not being able to
install mcs/mls, only standard(but only on the first go of it)
leading me to believe that I'm missing something during my build
with some of the required packages.(system is an LFS build,
things like this are the norm).

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
