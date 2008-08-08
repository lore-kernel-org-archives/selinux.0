Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78N3nRM017707
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 19:03:49 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m78N3lMO020898
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 23:03:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Mike Edenfield <kutulu@kutulu.org>
Subject: Re: Help: SELinux causing(?) boot failures...
Date: Sat, 9 Aug 2008 09:03:40 +1000
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
References: <489C6A4F.3020704@kutulu.org> <200808081251.45453.paul.moore@hp.com> <489C801E.9040306@kutulu.org>
In-Reply-To: <489C801E.9040306@kutulu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808090903.42866.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 09 August 2008 03:19, Mike Edenfield <kutulu@kutulu.org> wrote:
> (transcribed by hand since neither syslog nor auditd are starting)

Incidentally a serial console (or Xen console) is really good for tracking 
down such issues.

While startup problems can usually be solved in other ways, you can have 
similar problems in system shutdown.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
