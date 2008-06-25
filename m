Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5PINg20016839
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 14:23:42 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5PINf0Z003489
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 18:23:41 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1394536fgg.40
        for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 11:23:40 -0700 (PDT)
Message-ID: <cadfc0e40806251123md6cebeak9a83cd68559bf55c@mail.gmail.com>
Date: Wed, 25 Jun 2008 13:23:40 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: rawhide audit2allow problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I updated my rawhide box and now I getting the following error:

[root@localhost ~]# cat /var/log/audit/audit.log | audit2allow
Traceback (most recent call last):
  File "/usr/bin/audit2allow", line 344, in <module>
    app.main()
  File "/usr/bin/audit2allow", line 338, in main
    self.__output()
  File "/usr/bin/audit2allow", line 314, in __output
    g.add_role_types(self.__role_types)
AttributeError: PolicyGenerator instance has no attribute 'add_role_types'

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
