Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8EKEXhn016621
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 16:14:33 -0400
Received: from web51501.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8EKE6Tl013008
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 20:14:06 GMT
Message-ID: <20060914201351.79586.qmail@web51501.mail.yahoo.com>
Date: Thu, 14 Sep 2006 13:13:51 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Latest patch for policycoreutils, reworked from previous.
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1158263623.25629.216.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>The -v output seems to be a superset of the -o output.  So why do you
>need them to be run simultaneously and fed to two separate streams?

What I was wanting out of all this is a way to collect just the full path of
files that have a labelling problem and nothing else. If you send it to a file,
you get avcs.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
