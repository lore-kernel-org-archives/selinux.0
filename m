Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BE5lou001332
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 10:05:47 -0400
Received: from rv-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5BE5kv8005437
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 14:05:46 GMT
Received: by rv-out-0708.google.com with SMTP id f25so3093191rvb.54
        for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 07:05:46 -0700 (PDT)
Message-ID: <484FDBB6.5000009@gmail.com>
Date: Wed, 11 Jun 2008 09:05:42 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: libxcb xselinux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When will the X related selinux interfaces be upstreamed into libxcb? 
I'm looking at patching dbus-launch with calls defined in xselinux.xml 
and it's going to be hard to upstream a patch that depends on somethings 
that itself hasn't been upstreamed.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
