Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5RBjIGW004445
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2008 07:45:18 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5RBjHlO019852
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2008 11:45:17 GMT
Message-ID: <4864D2B3.4040607@redhat.com>
Date: Fri, 27 Jun 2008 07:44:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Xavier Toth <txtoth@gmail.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: rawhide audit2allow problem
References: <cadfc0e40806251123md6cebeak9a83cd68559bf55c@mail.gmail.com> <10143820806251203g139e16d7pf00566d7c6cd9433@mail.gmail.com>
In-Reply-To: <10143820806251203g139e16d7pf00566d7c6cd9433@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Wed, Jun 25, 2008 at 2:23 PM, Xavier Toth <txtoth@gmail.com> wrote:
>> I updated my rawhide box and now I getting the following error:
>>
>> [root@localhost ~]# cat /var/log/audit/audit.log | audit2allow
>> Traceback (most recent call last):
>>  File "/usr/bin/audit2allow", line 344, in <module>
>>    app.main()
>>  File "/usr/bin/audit2allow", line 338, in main
>>    self.__output()
>>  File "/usr/bin/audit2allow", line 314, in __output
>>    g.add_role_types(self.__role_types)
>> AttributeError: PolicyGenerator instance has no attribute 'add_role_types'
>>
> 
> This looks like audit2allow has my recent patch but not sepolgen. Not
> certain how that could happen since they appear to be part of the same
> rpm. Dan - any ideas?
> 
> Karl
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Yes the package maintainer commented out the patch to sepolgen.  Idiot...

Got to stop working while on vacation.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
