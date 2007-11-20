Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAKEvLt6010418
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2007 09:57:21 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAKEvHLb014025
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2007 14:57:18 GMT
Message-ID: <4742F59C.1050405@redhat.com>
Date: Tue, 20 Nov 2007 09:56:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Laurent Jacquot <jk@lutty.net>
CC: fedora-selinux-list <fedora-selinux-list@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: files contexts override via policy module
References: <1195565466.10117.0.camel@jack.lutty.net>	<4742E3AD.9050600@redhat.com> <1195568139.10117.4.camel@jack.lutty.net>
In-Reply-To: <1195568139.10117.4.camel@jack.lutty.net>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Laurent Jacquot wrote:
> Le mardi 20 novembre 2007 à 08:39 -0500, Daniel J Walsh a écrit :
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Laurent Jacquot wrote:
>>> Hello,
>>> I am sure this is a FAQ or a feature, but I want to know how to work
>>> around:
>>>
>>> I have cxoffice installed in my F8 home dir and I want some lib labeled
>>> as textrel_shlib_t, but I cannot override the default user_home_t home
>>> label via a policy module. 
>>>
>>> NOTE1 it works if the directory is not under /home
>>> NOTE2 there is nothing in the logs if it fails
>>> NOTE3 It has been so since the introduction of modular policy in selinux
>>>
>>> What is what I have tried so far in F8.
>>> [root@jack sel]#cat local.fc
>>> #cxoffice
>>> #/home/alex/.cxoffice/dotwine/drive_c(/.*)?/.*\.exe --
>>> system_u:object_r:textrel_shlib_t:s0
>>>
>>> /home/alex/cxoffice/lib/wine/kernel32.dll.so --
>>> system_u:object_r:textrel_shlib_t:s0
>>>
>>> [root@jack sel]#semodule_package -o local.pp -m local.mod -f local.fc
>>> [root@jack sel]#semodule -i local.pp
>>> [root@jack sel]#ls -Z /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>> -rwxr-xr-x  alex alex
>>> system_u:object_r:user_home_t:s0 /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>> [root@jack sel]#restorecon /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>> [root@jack sel]#ls -Z /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>> -rwxr-xr-x  alex alex
>>> system_u:object_r:user_home_t:s0 /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>>
>>>
>>> (If i use the system-config-selinux UI, I can see the new entry in the
>>> tab context among all the regexp)
>>>
>>> Using semanage, it works:
>>> [root@jack sel]#semodule -r local
>>> [root@jack sel]#semanage fcontext -a -t
>>> textrel_shlib_t /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>> [root@jack sel]#ls -Z /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>> -rwxr-xr-x  alex alex
>>> system_u:object_r:user_home_t:s0 /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>> [root@jack sel]#restorecon /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>> [root@jack sel]#ls -Z /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>> -rwxr-xr-x  alex alex
>>> system_u:object_r:textrel_shlib_t:s0 /home/alex/cxoffice/lib/wine/kernel32.dll.so
>>>
>>> and the custom rule appears in system-config-selinux UI at the end of
>>> the policy.
>>>
>>> So how do I have my module install my contexts the same way as semanage?
>>> Should I bugzilla it?
>>>
>>> BTW, how do system-config-selinux browse the file context policy? Is it
>>> possible to see also the rules and type definition?
>>>
>>> TIA
>>>         jk
>>>
>>> --
>>> fedora-selinux-list mailing list
>>> fedora-selinux-list@redhat.com
>>> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
>> This looks like a bug in libsemanage or in the file context labeling
>> algorithm.
>>
>> I believe matchpatcon is reading in file_contexts,
>> file_contexts.homedirs, file_contexts.local and taking the last entry.
>>
>>
>> So using semodule to add a pp file updates the file_contexts file, in
>> which case the homedirs is overriding.  semanage fcontext updates the
>> file_contexts.local.
>>
>>
>> If you tried
>>
>> HOME_DIR/\.cxoffice/dotwine/drive_c(/.*)?/.*\.exe --
>> system_u:object_r:textrel_shlib_t:s0
>>
>> It should update the file_context.homedirs file.
>>
>>
> I confirm this works. Thanks!
> Should I bugzilla it or is it the way it should be?
> 
> jk
> 
> 
> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
You can bugzilla it, but it probably should be brought up for discussion
on the <selinux@tycho.nsa.gov> list.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHQvWcrlYvE4MpobMRAsbWAJ9pO9S8n1Vg/wqo241AfVmovasw4gCeMVlS
8zDcYbim3RQLRTEHILlfEtw=
=LxQ0
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
