Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB5Mknc3026113
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 17:46:49 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB5Mk9oB024730
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 22:46:09 GMT
Received: by wx-out-0506.google.com with SMTP id s17so6924wxc
        for <selinux@tycho.nsa.gov>; Tue, 05 Dec 2006 14:47:16 -0800 (PST)
Message-ID: <4575F6E9.1020600@gmail.com>
Date: Tue, 05 Dec 2006 16:47:05 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: ewalsh@tycho.nsa.gov
CC: selinux@tycho.nsa.gov
Subject: XACE and MLS
References: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>	 <450962DB.7050107@tresys.com>	 <1158324416.8680.5.camel@twoface.columbia.tresys.com>	 <1158355183.7554.268.camel@moss-huskies.epoch.ncsc.mil>	 <cadfc0e40611290712g7fa802f2oa5b5ebc079e8ead2@mail.gmail.com>	 <1164830966.2794.144.camel@moss-huskies.epoch.ncsc.mil>	 <cadfc0e40611291434w5b1468ffo2eb87b0e982569e2@mail.gmail.com> <1164857243.2794.177.camel@moss-huskies.epoch.ncsc.mil>
In-Reply-To: <1164857243.2794.177.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We are interested in using X and an associated desktop/window manager 
(most likely GNOME/Metacity) in an MLS environment and I'm trying to 
figure out what all needs to be addressed to get there. A couple of 
areas that I've thought about so far are window labeling and cut and 
paste. For window labeling the window manager ought to be able to use 
the context of it X server connection to decorate the window with the 
level but what happens if for example a user does a newrole and changes 
their level? For cut and paste dominance checks are needed would it be 
reasonable to do these as an extension of the XACE and if so where can I 
find out more about how to do this and if not where then?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
