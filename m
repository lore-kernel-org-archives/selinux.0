Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAT7nkHq013921
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2008 02:49:46 -0500
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAT7nj66008539
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2008 07:49:46 GMT
Received: by rv-out-0708.google.com with SMTP id f25so1980175rvb.54
        for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2008 23:49:45 -0800 (PST)
Subject: AttributeError: RoleTypeSet instance has no attribute 'roles
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 28 Nov 2008 22:56:55 -0800
Message-Id: <1227941815.19875.4.camel@unix>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is confusing for me:
I've done a fresh reinstall and am noticing with audit2allow

Traceback (most recent call last):
  File "/usr/bin/audit2allow", line 348, in <module>
    app.main()
  File "/usr/bin/audit2allow", line 342, in main
    self.__output()
  File "/usr/bin/audit2allow", line 331, in __output
    if len(self.__selinux_errs) > 0:
  File "/usr/lib/python2.5/site-packages/sepolgen/access.py", line 316,
in __len__
    return len(self.roles)
AttributeError: RoleTypeSet instance has no attribute 'roles'

after I do another reinstall I was unable to reproduce.
then with another reinstall I'm able to reproduce.
any ideas?  

regards;

-- 
Justin P. Mattock <justinmattock@gmail.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
