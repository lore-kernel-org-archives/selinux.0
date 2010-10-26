Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9QEQHfs008286
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2010 10:26:18 -0400
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9QEQGjW011064
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2010 14:26:16 GMT
Received: by pwj5 with SMTP id 5so1213032pwj.12
        for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2010 07:26:15 -0700 (PDT)
Message-ID: <4CC6E531.5030008@gmail.com>
Date: Tue, 26 Oct 2010 07:26:57 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: imsand@puzzle.ch
CC: Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: Context settings after ssh login
References: <C8D3542D.BAC90%csellers@tresys.com>    <4CADF149.3040301@redhat.com> <4CAE025C.6010005@gmail.com>    <44256.193.5.216.100.1287499358.squirrel@mail.puzzle.ch>    <4CBDB14E.2030207@gmail.com>    <12764.193.5.216.100.1287503226.squirrel@mail.puzzle.ch>    <4CBDC997.6030800@gmail.com>    <10617.193.5.216.100.1287564131.squirrel@mail.puzzle.ch>    <4CBEF2B4.3050408@gmail.com>    <35906.193.5.216.100.1287584724.squirrel@mail.puzzle.ch>    <4CC3400C.8060004@gmail.com>    <30707.193.5.216.100.1287990574.squirrel@mail.puzzle.ch>    <4CC53877.7040106@gmail.com> <4CC53E5F.8060708@gmail.com> <24565.193.5.216.100.1288081632.squirrel@mail.puzzle.ch>
In-Reply-To: <24565.193.5.216.100.1288081632.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  On 10/26/2010 01:27 AM, imsand@puzzle.ch wrote:
>>    On 10/25/2010 12:57 AM, Justin P. Mattock wrote:
>>> On 10/25/2010 12:09 AM, imsand@puzzle.ch wrote:
>>>> Hi Justin.
>>>>
>>>> First of all, thanks a lot for your efforts.
>>> youre welcome!!
>>>> Unfortunately I'm a little bit confused about what you've done exactly
>>>> to
>>>> make it run.
>>>> Can you please summarize it and make a little step by step guide for
>>>> me?
>>> I can try, but maybe later on another post(a bit late over here.)
>>>> Did selinux worked out of the box (on sles11.1)? Didn't had you have to
>>>> fix the bug in /lib/mkinitrd/scripts/boot-boot.sh and rebuild initrd?
>>> long story short, installed sles11.1, changed the repos to download
>>> git-core
>>> then changed repos to download the rest of the packages to build the
>>> latest Mainline kernel
>>> (make, make modules_install)
> On my installation I took the original kernel, shipped with sles11.1. I
> don't want to compile a new one unless it's strongly recommended. Why
> don't you use the original kernel and packages of sles11.1?

The only way I have access through internet is through the wireless..and 
most distros
dont have my wireless driver...(and of course nvidia module as well for 
a proper looking screen)
so I use a copy of a good revision kernel to get online, pull, then build...

>>> then after that, installed all the SELinux packages, rebooted realized
>>> even though this system is
>>> using sysvinit the policy still wont load without an initrd(must be
>>> because my other systems have
>>> _nothing_ of the sort with initrd in them(*.h)or something, so ended
>>> up using mkinitrd_setup to make the image
>>> so the policy can load..
>>>
> Okey. I also had to rebuild initrd with the adjustments I already described.

cool... yeah you need the image, or else the policy will not load
>>> Then once loaded made sure the home directory was labelled correctly,
>>> as well as other
>>> areas that I've seen issues with, then just started the sshd..with the
>>> other machine with SELinux,
>>> and the iphone(touchterm ssh(free))..
>>>
>>>> which package have you build with --with-selinux and the --with-pam?
> I did't rebuild any packages. Do I have to recomple some packages with
> these options? I just took the original versions, shipped with sles 11.1.

I think the sshd package is good, but I did notice I couldnt find 
getsebool/setsebool to change a boolean
(either it's in /usr/share/man or somewhere else)
>>> this was on my cblfs system.. I just built this(all gnome etc..)and
>>> didnt realize that I had
>>> built this wrong until I looked at config.log of the package and
>>> noticed I messd up..
>>>
>>> after that things went good..(from over here sles11.1 sshd looks built
>>> fine, maybe this is config issues..,
>>> only issue I noticed is getsebool/setsebool are missing, so just do:
>>> mv /etc/initscript{,-old}
>>> to avoid problems during boot, or define the init_upstart boolean in
>>> boolean.conf.)
> I set the init_upstart boolean.

yeah but without setsebool you cant change that...(just rename 
/etc/initscript and/or
modify booleans.conf)
>>>> which policy did you used?http://oss.tresys.com/git/refpolicy.git?
>>>>
>>> yep... I follow track
> I can't compile the latest refpolicy version from git. make conf results
> in: doc/policy.xml:604: element module: validity error : Element module
> content does not follow the DTD, expecting (summary , desc? , required? ,
> (interface | template)* , (bool | tunable)*), got ()
> d
>

thats a first I've seen.. I get errors as well something about 
/tmp/seusers etc..
I just delete and pull git until it works..(biggest pain in the a** are 
these compile errors
that dont need to happen)

> but the latest release from
> (http://oss.tresys.com/files/refpolicy/refpolicy-2.20100524.tar.bz2) is
> working..
>>>> kind regards
>>>> Matthias
>>>>
>>>>
>>>

cheers,

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
