Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0QMUCaN025079
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 17:30:12 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0QMVBbm004649
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 22:31:11 GMT
Message-ID: <45BA8130.6060408@redhat.com>
Date: Fri, 26 Jan 2007 17:31:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Kylene Jo Hall <kjhall@us.ibm.com>
CC: Tomas Mraz <tmraz@redhat.com>, redhat-lspp@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [redhat-lspp] Problem SSH-ing into LSPP system with multiple
 categories
References: <1169842300.6956.129.camel@localhost.localdomain>	 <1169843274.3194.10.camel@perun.kabelta.loc>	 <1169844884.6956.132.camel@localhost.localdomain> <1169845275.6956.134.camel@localhost.localdomain>
In-Reply-To: <1169845275.6956.134.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kylene Jo Hall wrote:
> More test data:
>
>
> [root@rheal3a ~]# ssh testuser/user_r/s2:c0@localhost
> Password:
> Last login: Fri Jan 26 14:55:13 2007 from rheal3a.endicott.ibm.com
> -bash-3.1$ id
> uid=501(testuser) gid=501(testuser) groups=501(testuser)
> context=testuser_u:user_r:user_t:A
> -bash-3.1$ exit
> logout
> Connection to localhost closed.
> [root@rheal3a ~]# ssh testuser/user_r/s2:c1@localhost
> Password:
> Last login: Fri Jan 26 14:55:29 2007 from rheal3a.endicott.ibm.com
> -bash-3.1$ id
> uid=501(testuser) gid=501(testuser) groups=501(testuser)
> context=testuser_u:user_r:user_t:B
> -bash-3.1$ exit
> logout
> Connection to localhost closed.
> [root@rheal3a ~]# ssh testuser/user_r/s2:c3@localhost
> Password:
> Last login: Fri Jan 26 14:55:40 2007 from rheal3a.endicott.ibm.com
> -bash-3.1$ id
> uid=501(testuser) gid=501(testuser) groups=501(testuser)
> context=testuser_u:user_r:user_t:s2:c3
> -bash-3.1$ quit
> -bash: quit: command not found
> -bash-3.1$ exit
> logout
> Connection to localhost closed.
> [root@rheal3a ~]# ssh testuser/user_r/s2:c2@localhost
> Password:
> Last login: Fri Jan 26 14:56:05 2007 from rheal3a.endicott.ibm.com
> -bash-3.1$ ls
> -bash-3.1$ id
> uid=501(testuser) gid=501(testuser) groups=501(testuser)
> context=testuser_u:user_r:user_t:s2:c2
> -bash-3.1$ quit
> -bash: quit: command not found
> -bash-3.1$ exit
> logout
> Connection to localhost closed.
> [root@rheal3a ~]# ssh testuser/user_r/s2:c2,c3@localhost
> Password:
> Last login: Fri Jan 26 14:56:22 2007 from rheal3a.endicott.ibm.com
> -bash-3.1$ id
> uid=501(testuser) gid=501(testuser) groups=501(testuser)
> context=testuser_u:user_r:user_t:s2:c2,c3
> -bash-3.1$ exit
> logout
> Connection to localhost closed.
> [root@rheal3a ~]#
>
>
>
> On Fri, 2007-01-26 at 12:54 -0800, Kylene Jo Hall wrote:
>   
>> More test data:
>>
>> ssh testuer/user_r/s#:c0,c1@localhost works for every value of # between
>> 0 and 15 except 2.
>>
>> Thanks,
>> Kylie
>>
>> On Fri, 2007-01-26 at 21:27 +0100, Tomas Mraz wrote:
>>     
>>> On Fri, 2007-01-26 at 12:11 -0800, Kylene Jo Hall wrote:
>>>       
>>>> I have been unable to ssh into an LSPP system with multiple categories.
>>>>
>>>> For example the following work:
>>>> ssh testuser/user_r/s2@localhost
>>>> ssh testuser/user_r/s2:c0@localhost
>>>> ssh testuser/user_r/s2:c1@localhost
>>>>
>>>> But these do not:
>>>> ssh testuser/user_r/s2:c0.c1@localhost
>>>> ssh testuser/user_r/s2:c0,c1@localhost
>>>>
>>>> Policy version: selinux-policy-mls-2.4.6-28.el5
>>>> Kernel version: kernel-2.6.18-1.3015.2.1.el5.lspp.63
>>>>
>>>> We have tested this on multiple architectures to no avail.  Any
>>>> suggestions?
>>>>         
>>> Could you modify LogLevel in /etc/ssh/sshd_config to DEBUG3 and look
>>> into the /var/log/secure what messages are there when the login fails?
>>>
>>>       
>
>   



I am not able to recreate this here.

semanage user -l
semanage login -l
ps -eZ | grep ssh


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
