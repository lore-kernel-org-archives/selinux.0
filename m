Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0H3noXf027687
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 22:49:50 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0H3mhlk015096
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 03:48:43 GMT
Message-ID: <43CC6953.4060901@redhat.com>
Date: Mon, 16 Jan 2006 22:49:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>, SE Linux <selinux@tycho.nsa.gov>
Subject: Why are we managing seusers file via libsemanage?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I don't recall why we did this?

I am now thinking this is not a good idea.  People were told to edit the 
/etc/selinux/POLICYTYPE/seusers file to change the default level at 
login, now we do this via libsemanage.  But doing this via libsemanage 
eliminates us from being able to distribute this information via say LDAP.

I think that seusers and setrans.conf should be left as flat files and 
allowed to be distributed via ldap.  We can allow the semanage tool and 
others to modify them and verify the data entry, but not manage them via 
the library.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
