Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4P2OsEJ026027
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2012 22:24:58 -0400
Received: by pbbrq2 with SMTP id rq2so1107961pbb.6
        for <selinux@tycho.nsa.gov>; Thu, 24 May 2012 19:24:55 -0700 (PDT)
MIME-Version: 1.0
From: Jason Axelson <jaxelson@referentia.com>
Date: Thu, 24 May 2012 16:24:25 -1000
Message-ID: <CAC9ii1oKMKNq5PA1oGLQYSx==s6R4wQ+HEVPu4wb5k9BNAsJaw@mail.gmail.com>
Subject: Show SELinux packet type of packets
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Is there a way to show the SELinux packet types of all packets?
Ideally tcpdump would have an SELinux specific option that would print
out the SELinux context of each packet but that seems to be missing.
Are there any workarounds?

Note: this is with SECMARK labeling (such as
http://james-morris.livejournal.com/11010.html)

Thanks,
Jason

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
