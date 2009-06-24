Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5ODMgZh012685
	for <selinux@tycho.nsa.gov>; Wed, 24 Jun 2009 09:22:42 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5ODNErD015811
	for <selinux@tycho.nsa.gov>; Wed, 24 Jun 2009 13:23:14 GMT
Message-ID: <4A422886.2000406@redhat.com>
Date: Wed, 24 Jun 2009 09:22:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Failure to build policycoreutils from git
References: <87zlbyrg6s.fsf@anzu.internal.golden-gryphon.com> <4A4127B0.4010801@manicmethod.com>
In-Reply-To: <4A4127B0.4010801@manicmethod.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/23/2009 03:06 PM, Joshua Brindle wrote:
> Manoj Srivastava wrote:
>> Hi,
>>
>> __> tar zvvfx
>> /usr/local/src/selinux-dev-release/policycoreutils-2.0.64.tar.gz
>> __> cd policycoreutils-2.0.64
>> __> make
>> make[1]: Entering directory `/tmp/policycoreutils-2.0.64/setfiles'
>> cc -Werror -Wall -W -D_FILE_OFFSET_BITS=64 -I/usr/include -c -o
>> setfiles.o setfiles.c
>> cc setfiles.o -lselinux -lsepol -L/usr/lib -o setfiles
>>
>> …
>>
>> cc setsebool.o -lsepol -lselinux -lsemanage -L/usr/lib -o setsebool
>> make[1]: Leaving directory `/tmp/policycoreutils-2.0.64/setsebool'
>> make[1]: Entering directory `/tmp/policycoreutils-2.0.64/po'
>> make[1]: *** No rule to make target `../gui/booleansPage.py', needed
>> by `policycoreutils.pot'. Stop.
>> make[1]: Leaving directory `/tmp/policycoreutils-2.0.64/po'
>> make: *** [all] Error 1
>>
>>
>> Indeed, there is no policycoreutils-2.0.64/gui directory at
>> all. I think the pot file needs to be redone, without any extraneos
>> directories, or a means for generating the gui dir should be given.
>>
>> Thanks,
>>
>> manoj
>
> Hrm, those entries were added to POTFILES last September and haven't
> seemed to cause a problem. When I build I always build from the top of
> the repo and this didn't happen at all but indeed when I built from the
> policycoreutils directory it did.
>
> I don't really know anything about POTFILES or generating it, the po
> patches were pretty much accepted blindly, perhaps a mistake in hindsight.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
Yes you should remove the gui lines from the Makefile.* and probably 
POTFILES.*

Some one is working on a system-config-selinux package to remove the gui 
from policycoreutils and make it a separate package.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
