Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5PJ5nEe024567
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 15:05:49 -0400
Received: from mail.wrs.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5PJ5mhq029746
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 19:05:48 GMT
Message-ID: <486294D6.3080901@windriver.com>
Date: Wed, 25 Jun 2008 14:56:22 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: rawhide audit2allow problem
References: <cadfc0e40806251123md6cebeak9a83cd68559bf55c@mail.gmail.com>
In-Reply-To: <cadfc0e40806251123md6cebeak9a83cd68559bf55c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> I updated my rawhide box and now I getting the following error:
>
> [root@localhost ~]# cat /var/log/audit/audit.log | audit2allow
> Traceback (most recent call last):
>   File "/usr/bin/audit2allow", line 344, in <module>
>     app.main()
>   File "/usr/bin/audit2allow", line 338, in main
>     self.__output()
>   File "/usr/bin/audit2allow", line 314, in __output
>     g.add_role_types(self.__role_types)
> AttributeError: PolicyGenerator instance has no attribute 'add_role_types'
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   
looks like the wrapper or some other dep is not the same revision as 
your audit2allow, in other words, you might need to update its 
dependencies too. just a guess.

-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
