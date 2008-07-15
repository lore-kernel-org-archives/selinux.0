Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6FGTOIQ003714
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 12:29:24 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6FGTNd3028843
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 16:29:24 GMT
Received: by fg-out-1718.google.com with SMTP id 16so2319931fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 09:29:23 -0700 (PDT)
Message-ID: <cadfc0e40807150929nf059a31q9b9435b08b8ac7f6@mail.gmail.com>
Date: Tue, 15 Jul 2008 11:29:22 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: python gui gconf policy problem
Cc: "Daniel J Walsh" <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm writing policy for a python gui and having a problem getting preferences:

gobject.GError: Failed to contact configuration server; some possible
causes are that you need to enable TCP/IP networking for ORBit, or you
have a stale NFS locks due to a system crash. See
http://www.gnome.org/project/gconf/ for information. (Details - 1:
Could not send message to gconf daemon: An SELinux policy prevents
this sender from sending this message to this recipient (rejected
message had interface "org.gnome.GConf member "GetIOR" error name
"(unset)" destination "org.gnome.GConf"))

The error message states that policy is preventing this operation but
there isn't a corresponding AVC in the audit log. I'm using the
gnome_stream_connect_gconf_template but that doesn't help and I'm not
sure it is the right thing to do anyway.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
