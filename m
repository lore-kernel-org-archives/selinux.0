Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBA6KBAk017094
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 01:20:11 -0500
Received: from smtp105.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id mBA6KAMw028122
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 06:20:10 GMT
Message-ID: <493F5F8E.1080303@schaufler-ca.com>
Date: Tue, 09 Dec 2008 22:19:58 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: erahul29@yahoo.com, selinux@tycho.nsa.gov
Subject: Re: Non root user cannot execute semanage, semodule
References: <829347.35568.qm@web50202.mail.re2.yahoo.com> <493EDD04.4050909@redhat.com>
In-Reply-To: <493EDD04.4050909@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Rahul Jain wrote:
>   
>> Hi All,
>>  
>> I am currently developing a Role Based Access Solution on Montavista linux using SELiunx. I started my implementaion with the reference policy from Tresys. In this implementation I had assigned a role of security officer to one of my non root Linux user. This user is resposible for maintaining SELinux related tasks such as creation, building of policy etc. But this user of mine, being a non root user is not able to execute some priviledged commands such as semodule and semanage. 
>> Is there any in which I can permit a non root user execute these commands.
>>  
>> Thanks and Regards
>> Rahul Jain
>>
>>
>>       
>>     
> sudo
>   

File based capabilities, too.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
