Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5PJ3KSf024168
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 15:03:20 -0400
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5PJ3J0Z014809
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 19:03:19 GMT
Received: by yw-out-1718.google.com with SMTP id 6so1092513ywa.84
        for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 12:03:17 -0700 (PDT)
Message-ID: <10143820806251203g139e16d7pf00566d7c6cd9433@mail.gmail.com>
Date: Wed, 25 Jun 2008 15:03:16 -0400
From: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
To: "Xavier Toth" <txtoth@gmail.com>
Subject: Re: rawhide audit2allow problem
Cc: "SELinux List" <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40806251123md6cebeak9a83cd68559bf55c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40806251123md6cebeak9a83cd68559bf55c@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 25, 2008 at 2:23 PM, Xavier Toth <txtoth@gmail.com> wrote:
> I updated my rawhide box and now I getting the following error:
>
> [root@localhost ~]# cat /var/log/audit/audit.log | audit2allow
> Traceback (most recent call last):
>  File "/usr/bin/audit2allow", line 344, in <module>
>    app.main()
>  File "/usr/bin/audit2allow", line 338, in main
>    self.__output()
>  File "/usr/bin/audit2allow", line 314, in __output
>    g.add_role_types(self.__role_types)
> AttributeError: PolicyGenerator instance has no attribute 'add_role_types'
>

This looks like audit2allow has my recent patch but not sepolgen. Not
certain how that could happen since they appear to be part of the same
rpm. Dan - any ideas?

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
