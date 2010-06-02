Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o52Fcmnd028728
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2010 11:38:48 -0400
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o52FeCAT014165
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2010 15:40:12 GMT
Received: by pwj8 with SMTP id 8so2308733pwj.12
        for <selinux@tycho.nsa.gov>; Wed, 02 Jun 2010 08:38:45 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 2 Jun 2010 08:32:54 -0700
Message-ID: <AANLkTinACSXGyYqwI-cBkQki1PoaKUHK1sDxkKwRHGCE@mail.gmail.com>
Subject: inaddr_any_node_t?
From: Larry Ross <selinux.larry@gmail.com>
To: Selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Where can I find the definition and purpose of "inaddr_any_node_t"?

It looks like it matches any port for networking rules but I can't
find where it is defined or any documentation on it.  The only place I
see it (other than my policy, where it came as the output from
audit2allow) is in tmp/all_interfaces.conf

Where is it defined?

How can I find out what its purpose is and how it works?

I am using a customized RHEL5.4 strict policy.

   Thank you,
   Larry

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
