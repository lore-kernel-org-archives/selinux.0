Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBA80gm2023964
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 03:00:42 -0500
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBA80fMw011428
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 08:00:41 GMT
Received: by rv-out-0708.google.com with SMTP id f25so328536rvb.54
        for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 00:00:40 -0800 (PST)
References: <829347.35568.qm@web50202.mail.re2.yahoo.com> <493EDD04.4050909@redhat.com> <493F5F8E.1080303@schaufler-ca.com>
Message-Id: <49F8E507-F170-4FA1-873E-5DF2788D4B30@gmail.com>
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <493F5F8E.1080303@schaufler-ca.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 5G77)
Subject: Re: Non root user cannot execute semanage, semodule
Date: Wed, 10 Dec 2008 00:00:24 -0800
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "erahul29@yahoo.com" <erahul29@yahoo.com>,
        SELinux <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Shouldn't the employee have only access to only what they need?

justin P. Mattock



On Dec 9, 2008, at 10:19 PM, Casey Schaufler <casey@schaufler-ca.com>  
wrote:

> Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Rahul Jain wrote:
>>
>>> Hi All,
>>> I am currently developing a Role Based Access Solution on  
>>> Montavista linux using SELiunx. I started my implementaion with  
>>> the reference policy from Tresys. In this implementation I had  
>>> assigned a role of security officer to one of my non root Linux  
>>> user. This user is resposible for maintaining SELinux related  
>>> tasks such as creation, building of policy etc. But this user of  
>>> mine, being a non root user is not able to execute some  
>>> priviledged commands such as semodule and semanage. Is there any  
>>> in which I can permit a non root user execute these commands.
>>> Thanks and Regards
>>> Rahul Jain
>>>
>>>
>>>
>> sudo
>>
>
> File based capabilities, too.
>
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>  with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
