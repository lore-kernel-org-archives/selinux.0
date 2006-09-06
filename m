Message-ID: <20060906154757.76508.qmail@web51514.mail.yahoo.com>
Date: Wed, 6 Sep 2006 08:47:57 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: service start/stop test script
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I just wanted to let everyone know that I'm making a test script available to
help policy writers. The script will go though /etc/rc.d/init.d and make a list
of services installed. It filters out some that you'd really not want to run
(like halt). Then it checks the service to see if its running. If so, it stops
and starts the service. Otherwise it starts then stops the service. After each
service cycle, it scans the audit logs to look for avcs. If any are found they
are run through audit2allow and output. The script can be found here:

http://people.redhat.com/sgrubb/files/testing/service-avc-test

Feedback and updates are welcome.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
