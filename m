Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3RNMH4r021745
	for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2009 19:22:17 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3RNMGNn029507
	for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2009 23:22:16 GMT
Date: Tue, 28 Apr 2009 09:22:07 +1000
From: Scott Radvan <sradvan@redhat.com>
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux managing-confined-services guide - call for review
Message-ID: <20090428092207.267f28a7@redhat.com>
In-Reply-To: <8F6D2CAD-4CA1-421A-815B-B5AC40814C38@gmail.com>
References: <20090423142545.189129ea@redhat.com>
	<8F6D2CAD-4CA1-421A-815B-B5AC40814C38@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 23 Apr 2009 17:55:01 +0200
Sebastian Pfaff <sebastian.pfaff@gmail.com> wrote:

> i only did a fast and incomplete rewiew. but i found another small  
> typo/conversion error (p. 35 between step 4 and 5):
> 
> 100%[=======================gt;] 84          --.-K/s   in 0s
> 
> this should be correct:
> 
> 100%[=======================>] 84          --.-K/s   in 0s
> 
> 
> --
> Sebastian Pfaff


Thanks for spotting that, fixed. 

-- 
Scott Radvan
Content Author, Platform (Installation and Deployment)
Red Hat Asia Pacific (Brisbane) http://www.apac.redhat.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
