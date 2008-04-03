Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m33HJPnp006526
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 13:19:25 -0400
Received: from yw-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m33HJLCP023542
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 17:19:21 GMT
Received: by yw-out-1718.google.com with SMTP id 5so393287ywr.84
        for <selinux@tycho.nsa.gov>; Thu, 03 Apr 2008 10:18:55 -0700 (PDT)
Message-ID: <150846cc0804030919t1b545103n6491658deee64a9d@mail.gmail.com>
Date: Thu, 3 Apr 2008 12:19:34 -0400
From: "Caleb Case" <calebcase@gmail.com>
To: "Brian M. Williams" <bwilliams@tresys.com>
Subject: Re: Error running semanage from trunk
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801CD22C7@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <6FE441CD9F0C0C479F2D88F959B0158801CD22C7@exchange.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 3, 2008 at 11:45 AM, Brian M. Williams <bwilliams@tresys.com> wrote:
> I built the toolchain out of trunk this morning (rev 2860); I have
>  python 2.4.3 installed on RHEL 5.1, running semanage with any input
>  gives this error:
>
>  [root@localhost policy]# semanage
>  Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 24, in ?
>     import seobject
>   File "/usr/lib/python2.4/site-packages/seobject.py", line 93, in ?
>     import xml.etree.ElementTree
>  ImportError: No module named etree.ElementTree
>
>  Does anyone know where this might be coming from?  Does semanage need a
>  newer version of python?
>

semanage requires python 2.5

The dependency was introduced in svn revision 2700 (at least the xml.etree one).

This was recently reported on Debian:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=471944

>
>  --
>  This message was distributed to subscribers of the selinux mailing list.
>  If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>  the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
