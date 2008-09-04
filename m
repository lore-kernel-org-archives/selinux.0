Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m84FXSNm003425
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 11:33:28 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m84FXSk3010952
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 15:33:28 GMT
Message-ID: <48BFFFC6.6090100@manicmethod.com>
Date: Thu, 04 Sep 2008 11:33:26 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Vikram Noel Ambrose <noel.ambrose@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][autotools] libselinux/load_policy.o compile error
References: <48BF58E7.4030806@gmail.com>
In-Reply-To: <48BF58E7.4030806@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vikram Noel Ambrose wrote:
> Here's the fix to that libselinux ld error you were getting.
> 

Ok, applied and built fine. One interesting thing is that even without building the swig wrappers (--disable-swig) it still installs lib/python2.5/site-packages/selinux, which obviously wouldn't work without the accompanying .so file.

Also, it looks like any library that installs to /lib will also put their python stuff in /lib/python2.5. I don't know if python even knows to look there, and even if it does there is really no reason to put them there. libselinux.so and libsepol.so will need to go to /lib but the python stuff should go to /usr/lib and I don't see a different argument for the python stuff (only --libdir).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
