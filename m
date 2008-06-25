Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5PJdl0R030758
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 15:39:47 -0400
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5PJdk0Z024744
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 19:39:47 GMT
Received: by fk-out-0910.google.com with SMTP id 18so3334327fks.2
        for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 12:39:46 -0700 (PDT)
Message-ID: <4c4ba1530806251239o627ab5bcmadbdca2e4bb65f4c@mail.gmail.com>
Date: Wed, 25 Jun 2008 12:39:46 -0700
From: "Tom London" <selinux@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: Re: rawhide audit2allow problem
In-Reply-To: <486294D6.3080901@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40806251123md6cebeak9a83cd68559bf55c@mail.gmail.com>
	 <486294D6.3080901@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 25, 2008 at 11:56 AM, Vikram Ambrose
<Vikram.Ambrose@windriver.com> wrote:
> Xavier Toth wrote:
>>
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
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>
> looks like the wrapper or some other dep is not the same revision as your
> audit2allow, in other words, you might need to update its dependencies too.
> just a guess.
>
> --
> Vikram Ambrose | Linux Products Division | WindRiver Corporation
>
Fedora BZ here: https://bugzilla.redhat.com/show_bug.cgi?id=452770

Already closed.... to be fixed in -9.

tom
-- 
Tom London

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
