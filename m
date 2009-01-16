Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0GILBqd019017
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 13:21:11 -0500
Received: from mail-qy0-f17.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0GIIL3I020479
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 18:18:21 GMT
Received: by qyk10 with SMTP id 10so2071132qyk.18
        for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 10:21:06 -0800 (PST)
Message-ID: <4970D00F.60603@gmail.com>
Date: Fri, 16 Jan 2009 10:21:03 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Amon Ott <ao@rsbac.org>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Announce: RSBAC 1.4.0 released
References: <200901160948.32172.ao@rsbac.org> <49705322.8010309@gmail.com> <497091FF.40500@manicmethod.com>
In-Reply-To: <497091FF.40500@manicmethod.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Justin P. Mattock wrote:
>> Amon Ott wrote:
>>> Rule Set Based Access Control (RSBAC) 1.4.0 has been released for both
>>> Linux kernels 2.4.37 and 2.6.27.10
>>> You can download the new version from http://www.rsbac.org
>>>
>>> RSBAC is one of the leading access control systems for the Linux
>>> kernel with a good selection of access control models, see
>>> http://www.rsbac.org/why for more details.
>>>
>>> Important changes since 1.3 series:
>>>
>>>   *  VUM (Virtual User Management) support 
>>> (http://rsbac.org/redir.php?t=vum)
>>>   * One time password support for user management 
>>> (http://rsbac.org/redir.php?t=otp)
>>>   * Code for kernels 2.4 and 2.6 has been separated. 2.4 kernels might
>>> be phased out at a later date.
>>>   * PAM module does not send a message "User not authenticated" anymore
>>> if authentication failed. (To match other PAM modules behavior)
>>>   * Made PAM password prompt standard and definable to RSBAC's custom
>>> prompt if the user wants it only.
>>>   * rsbac_useradd -K to copy a user with password.
>>>   * rsbac_mount now uses kernel's vfs_mount
>>>
>>>
>>> About RSBAC 1.4:
>>> ---
>>>
>>> RSBAC 1.4 mainly introduces the new Virtual User Management feature 
>>> ( (http://rsbac.org/redir.php?t=vum),
>>> which allows to isolate complete sets of users in so-called "virtual 
>>> sets". Every user in every set can have individual passwords and 
>>> access rights.
>>>
>>> As an example, you can start your mail server in a different set, and
>>> the users getting the email will not be part of the system users.
>>>
>>> Likewise, your jails can be started in a different set, so that the
>>> users in that jail will never be the same ones as the real system 
>>> users.
>>>
>>> You can specify the user set with the usual tools by specifying the
>>> full user path, e.g.:
>>>
>>> 0/0 defines user id 0 (root) in virtual set 0 (eg system user root)
>>> 0/1000 defines user id 1000 in virtual set 0 (eg a system user)
>>> 1/secoff defines user secoff in virtual set 1 ( be.g. with uid 400)
>>> 2/1000 defines user id 1000 in virtual set 2 (for example, mail users
>>> could be in set 2)
>>>
>>> Amon.
>>>   
>> alright a new security mechanism!!
>
> RSBAC has been around quite some time actually. It is not SELinux 
> related and does not use LSM to place its security hooks and therefore 
> is not viable for the upstream kernel. It is an addon kernel patch.
>
>> (still need to learn UBAC though);
>
> UBAC is an SELinux policy, in some ways it demonstrates the 
> flexibility of the SELinux policy language. RSBAC is a framework for 
> many security modules (sort of like a heavier-weight LSM). Currently 
> it doesn't have a module with as expressive a policy language as 
> SELinux. The only MAC module is a Bell and LaPadula implementation 
> (though it does have role based access control, access control lists 
> and others).
>
>> Anyways I'll have to give this a shot.
>>
>
>
So with a quick glance,
rsbac is kind of like /etc/groups
except rsbac has it's own entry?
(then for what app you want to run
you just rsbac_useradd  -d *)

regards;

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
