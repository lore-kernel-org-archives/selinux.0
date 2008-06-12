Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5CIcvDG027190
	for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 14:38:57 -0400
Received: from gv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5CIcu3s004538
	for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 18:38:56 GMT
Received: by gv-out-0910.google.com with SMTP id i36so1199840gve.17
        for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 11:38:55 -0700 (PDT)
Message-ID: <cadfc0e40806121138x3bb0996asda149528809d4598@mail.gmail.com>
Date: Thu, 12 Jun 2008 13:38:55 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux Mail List" <selinux@tycho.nsa.gov>
Subject: dynamic security class and access vector lookup
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wasn't aware until yesterday that there was an API for looking up
security classes (selinux_set_mapping, the name of which doesn't
strike me as very intuitive). Can I also lookup the access vectors for
a class, if so how?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
