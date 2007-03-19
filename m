Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JHVCs3003359
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 13:31:12 -0400
Received: from web51509.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JHV9Rc016915
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 17:31:10 GMT
Date: Mon, 19 Mar 2007 10:31:09 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] libselinux lazy init
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1174324397.22565.133.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <448688.66055.qm@web51509.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Also, can you comment on why you chose not to pursue Ulrich's suggested
>approach?  Just lack of time or was there a technical reason?

There is allocation of multiple strings in the init function. From that point of
view, I thought the safest thing is to just use pthread_once. I also wasn't sure
about putting atomic compare and exchange code into libselinux.

-Steve


 
____________________________________________________________________________________
Don't pick lemons.
See all the new 2007 cars at Yahoo! Autos.
http://autos.yahoo.com/new_cars.html 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
