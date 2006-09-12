Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8CCRV47020339
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 08:27:31 -0400
Received: from web51508.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8CCR6Zl006604
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 12:27:06 GMT
Message-ID: <20060912122726.6914.qmail@web51508.mail.yahoo.com>
Date: Tue, 12 Sep 2006 05:27:26 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: post update label checking script
To: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I just wanted to let everyone know that I'm making another test script available
to help people testing fedora rawhide updates. What this script does is look at
the yum logs to see if you've updated the system today. (Optionally, you can pass
a date to the script based on your locale, for example "Sep 03" would be valid in
mine.) If updates are found in the logs, it makes a list of rpms and sends that
to fixfiles to see if the update has caused any files to be mislabeled. This can
happen when post install scriptlets do the wrong thing. The script should not
repair anything since its just a test. You can find it here:

http://people.redhat.com/sgrubb/files/testing/selinux-check-new-rpms

Typically, you would run the script after doing "yum update" on a rawhide
machine. Please report any problems you find. There were several bug fixes needed
in policycoreutils to make the script work and hopefully they will be backported
to FC5 sometime soon.

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
