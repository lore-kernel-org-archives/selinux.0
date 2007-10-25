Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9PGBoop002283
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2007 12:11:50 -0400
Received: from web51507.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l9PGBkot003128
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2007 16:11:46 GMT
Date: Thu, 25 Oct 2007 09:11:44 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: removing a module
To: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <874986.66361.qm@web51507.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I was testing the new policy writing GUI in rawhide, and removed a policy module. Prelink ran while I was working on a better policy module and gave me a bunch of AVCs since the binaries are now considered unlabeled_t. I was thinking that semodule should be able to get to the file regexes that describes the files that the policy module was responsible for. So why doesn't it save those regexes and use them to do a restorecon after the module is removed? It might not get all the files that are mislabeled due to the policy module being removed, but it would be much better than doing nothing.

-Steve



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
