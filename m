Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA06174
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 11:59:24 -0400 (EDT)
From: gdsmarshall@hushmail.com
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA25681
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 15:57:56 GMT
Received: from smtp3.hushmail.com (smtp3.hushmail.com [64.40.111.33])
        by jazzband.ncsc.mil  with ESMTP id PAA25677 for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 15:57:56 GMT
Message-Id: <200207041559.g64FxJh29628@mailserver4.hushmail.com>
To: Brad Chapman <jabiru_croc@yahoo.com>
Cc: selinux@tycho.nsa.gov, gdsmarshall@hushmail.com
Subject: Re: Re: This does not look correct....
Date: Thu,  4 Jul 2002 08:59:19 -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello Brad,

Am I correct in presuming it is okay to give ssh access to getty's if they are for outbound use?  I am trying to make it as tight as possible without being too constricted.

Many thanks,

Spencer

On Thu, 4 Jul 2002 08:51:41 -0700 (PDT), Brad Chapman <jabiru_croc@yahoo.com> wrote:
>Sir,
>
>--- gdsmarshall@hushmail.com wrote:
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>> Hello,
>>
>> I know I have not been trying to configure SELinux for very long, but this
>> does not look correct to me.  Should ssh have a getty_t definision?  I know
>> it needs one to prevent this error message, but is it correct for ssh to have
>> a getty_t definision?
>>
>> Jul  4 08:05:33 gatekeeper kernel: avc:  denied  { use } for  pid=339
>> exe=/usr/bin/ssh path=/dev/tty3 dev=03:01 ino=71770
>> scontext=root:sysadm_r:sysadm_ssh_t tcontext=system_u:system_r:getty_t
>> tclass=fd
>>
>> I am running debian (woody), with kernel from NSA, and packages from
>> Russell's site.
>
>        To me, it looks like ssh is trying to access /dev/tty3 and failing
>because it isn't allowed the "use" action for the getty_t domain from its own
>domain. Try the following rule:
>
>        allow sysadm_ssh_t getty_t:fd use;
>
>        (Note to others: what does "use" mean?)
>
>>
>> Many thanks in advance,
>>
>> Spencer
>
>Brad
>
>
>=====
>Brad Chapman
>
>Permanent e-mails: kakadu_croc@yahoo.com
>		   jabiru_croc@yahoo.com
>		   tanami_croc@devel.lbsd.net
>
>__________________________________________________
>Do You Yahoo!?
>Sign up for SBC Yahoo! Dial - First Month Free
>http://sbc.yahoo.com
>

-----BEGIN PGP SIGNATURE-----
Version: Hush 2.1
Note: This signature can be verified at https://www.hushtools.com

wmAEARECACAFAj0kfqcZHGdkc21hcnNoYWxsQGh1c2htYWlsLmNvbQAKCRC4zrK67KP4
z1lmAJ4i+umQuWs5CPf+NyMBHGBccn/9iQCdH1ZnESRYE/st2Rg6Jeu87jCl6DE=
=f8Ao
-----END PGP SIGNATURE-----


Communicate in total privacy.
Get your free encrypted email at https://www.hushmail.com/?l=2

Looking for a good deal on a domain name? http://www.hush.com/partners/offers.cgi?id=domainpeople


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
