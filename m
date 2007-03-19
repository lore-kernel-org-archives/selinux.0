Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JHf40u003998
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 13:41:04 -0400
Received: from web51511.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JHf12o008306
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 17:41:02 GMT
Date: Mon, 19 Mar 2007 10:41:00 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] libselinux lazy init
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1174325175.22565.143.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <134076.39235.qm@web51511.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Looking back at Roland's advice, I notice that his sample code
>introduced an explicit bool flag rather than overloading the
>pthread_once_t variable.

It doesn't look like overloading to me. The man page says:

pthread_once_t once_control = PTHREAD_ONCE_INIT;

The Single Unix Specification says its a constant:

The constant PTHREAD_ONCE_INIT is defined by the header <pthread.h>.

The header file says:

#define PTHREAD_ONCE_INIT 0

So, it is a constant integer. I would imagine there is breakage for commercial
binary apps if that ever changed.

-Steve


 
____________________________________________________________________________________
We won't tell. Get more on shows you hate to love 
(and love to hate): Yahoo! TV's Guilty Pleasures list.
http://tv.yahoo.com/collections/265 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
