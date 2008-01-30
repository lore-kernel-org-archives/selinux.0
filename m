Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0UFXXSH019936
	for <selinux@tycho.nsa.gov>; Wed, 30 Jan 2008 10:33:33 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0UFXXIi029379
	for <selinux@tycho.nsa.gov>; Wed, 30 Jan 2008 15:33:33 GMT
Message-ID: <47A098C9.2010601@redhat.com>
Date: Wed, 30 Jan 2008 10:33:29 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Todd Miller <Tmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: genhomedircon is broken in libsemanage
References: <479F4051.7030101@redhat.com> <6FE441CD9F0C0C479F2D88F959B01588016EF6CA@exchange.columbia.tresys.com> <479FA131.3050700@manicmethod.com> <47A089EC.6020607@redhat.com> <47A08F3D.6040008@manicmethod.com> <47A090C2.4070309@redhat.com> <47A095FA.7020509@manicmethod.com>
In-Reply-To: <47A095FA.7020509@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Joshua Brindle wrote:
>>  
>>> Daniel J Walsh wrote:
>>>    
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> Joshua Brindle wrote:
>>>>  
>>>>      
>>>>> Todd Miller wrote:
>>>>>           
>>>>>> Daniel J Walsh wrote:
>>>>>>  
>>>>>>               
>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>>> Hash: SHA1
>>>>>>>
>>>>>>> Adding
>>>>>>>
>>>>>>> mythtv:x:1004:1004::/var/lib/mythtv:/bin/bash
>>>>>>>
>>>>>>> To /etc/passwd causes the labeling to get all screwed up.  This
>>>>>>> would
>>>>>>> report an error when we used the python version of genhomedircon and
>>>>>>> not foul up the labeling by checking if there was a label for
>>>>>>> /var/lib
>>>>>>> already in the file_context file. (Boy do I love python.  :^))
>>>>>>>
>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=430195
>>>>>>>
>>>>>>> Dan
>>>>>>>                         
>>>>>> That shouldn't be hard to add to genhomedircon.c.  I'll take a look.
>>>>>>                   
>>>>> So, Todd is about to send a patch to fix this but I want to point out
>>>>> that I'm adverse to this sort of thing. There is a minuid and a null
>>>>> shell for a reason, using something above minuid with a valid shell
>>>>> for
>>>>> a non-interactive user is a broken configuration and the fact that we
>>>>> have to work around it is pretty unfortunate.
>>>>>
>>>>> That said the alternative of breaking the system labeling is pretty
>>>>> bad,
>>>>> its probably better to hack around the problem than leave clueless
>>>>> users
>>>>> with broken configurations stranded but I really wish we didn't
>>>>> have to
>>>>> do things like this.
>>>>>
>>>>> *sigh*
>>>>>
>>>>>             
>>>> I think you need to scream in the semanage that this is bad behavior,
>>>> and you can't fix the labels.  The /var/lib situation is bad, but I
>>>> more
>>>> commonly see admins putting real users in /usr/local or under /var.  We
>>>> need to have a message that explains this is bad and SELinux can not
>>>> handle it.
>>>>         
>>> Well, this is part of the configurability of Linux and thats why people
>>> love it, right? One solution would be to effectively get rid of
>>> directory search denials on commodity policies (eg., give all domains
>>> search on all dirs for the RH policy) then we don't have to worry about
>>> the "top level home" directory label at all.
>>>
>>>     
>> It is not that simple. useradd relies on home_root_t to create
>> directories labeled user_home_dir_t.
>>
>>   
> 
> So I think this behavior is bogus. First of all the user being added
> might not be a user_r user and thus his home directory will be
> mislabeled between the time useradd adds the directory and it gets
> relabeled. This is a race where an unprivileged user could contaminate a
> privileged users environment. Second if its true that user directories
> commonly get moved then we have to stop relying on default transitions
> to do labeling and make useradd label things properly.
> 
> 
Well two things.  First I lied a little useradd has matchpathcon built
into it and can actually to semanage if you give the -Z qualifier.
useradd -Z staff_u -dwalsh, will label dwalsh account as staff_u in
RHEL5 and Fedora 8 and less.  It will also label the directory correctly
if you do not use -Z but have __default__ set to be staff_u.  But this
does not prevent other tools from creating the directory and getting the
labeling somewhat correct (system-config-users for example.)

In Rawhide I have removed all differences in homedir labeling.  Every
user now has a homedir labeled
user_home_dir_t/user_home_t/user_mozilla_home_t.  I believe separation
on the homedir is wrong, and I no longer support it.  It is DAC
responsibility to protect users Homedirs, and the complexity of doing
this with Type Enforcement was way too complicated, for little real
security value.  Since invariably almost all users logon to a system at
the same user type.  As we move to shared home directories, with
different login types, having a consistant labeling of the homedirs
becomes critical.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkegmMkACgkQrlYvE4MpobMwBgCeLbBzPWnrkQQbvOQpsiNSVUc7
F3IAn1+n7ZAYxdM4FsW5XEFODF6oXG6Z
=CDWW
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
