Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OJWNgA009925
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 15:32:23 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OJVk2B004870
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 19:31:47 GMT
Subject: Re: mdadm policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: antoine <antoine@nagafix.co.uk>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
   walters@redhat.com
In-Reply-To: <1119641274.9645.58.camel@localhost>
References: <1119569243.9390.77.camel@localhost>
	 <1119577846.20101.26.camel@localhost.localdomain>
	 <1119605711.9645.28.camel@localhost>
	 <1119627684.30464.8.camel@celtics.boston.redhat.com>
	 <1119630905.9645.37.camel@localhost>
	 <1119635200.31852.16.camel@celtics.boston.redhat.com>
	 <1119636160.9645.46.camel@localhost>
	 <1119639933.31852.82.camel@celtics.boston.redhat.com>
	 <1119641274.9645.58.camel@localhost>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:29:51 -0400
Message-Id: <1119641392.31852.93.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Hostile program  *or* shell script with insecure privileges/files, etc.

No, improperly secured (but non-hostile) program is 
not an issue, because remember... you're still running 
in the mdadm_t domain. Your program can't write any files, 
because mdadm_t is not allowed to. It has to explicitly
try to subvert this by writing to raw disk (at which point
it's obviously a hostile program).

In fact, if you try to run anything complicated at all it
will likely fail, and not work at all, including sendmail.

The only threat to me appears to be a root kit, but 
at that point you've already subverted selinux to a large
degree, and I'm not sure it's worth protecting anymore.






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
