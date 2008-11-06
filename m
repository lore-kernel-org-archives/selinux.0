Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA6J42jN026687
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 14:04:02 -0500
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA6J42Em024333
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 19:04:02 GMT
Received: by rv-out-0708.google.com with SMTP id f25so843156rvb.54
        for <selinux@tycho.nsa.gov>; Thu, 06 Nov 2008 11:04:01 -0800 (PST)
Message-Id: <B566A9B5-2746-4A0F-8E0C-07361FA300CE@gmail.com>
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Mime-Version: 1.0 (iPhone Mail 5F136)
Subject: Restorecond.conf
Date: Thu, 6 Nov 2008 11:03:51 -0800
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm seeing a fail during boot,
Not sure if this is restorecond or not.
When looking at restorecond.conf
/etc/samba/secrets.tdb is at
/var/lib/samba/secrets.tdb

~/public_html doesn't exist

~/.mozilla/plugins/libflashplayer.so
is at
/usr/lib/flashplugin-nonfree/libflashplayer.so

Does it hurt to just change the loaction in restorecond.conf or should
I configure these apps to use these files?

justin P. Mattock



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
