Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6VIKMne031699
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 14:20:22 -0400
Received: from web51506.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l6VIKLM8015624
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 18:20:21 GMT
Date: Tue, 31 Jul 2007 11:19:30 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: setroubleshooter/sealert on central loghost?
To: Jan-Frode Myklebust <janfrode@tanso.net>, selinux@tycho.nsa.gov
In-Reply-To: <911f42990707310750r349d11c4x9132c68d83cf8cfc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <946030.39450.qm@web51506.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>We run a centralized syslog server, and separate all syslogged avc
>into a separate log file. Is it possible to have setroubleshooter/sealert
>use this log file ?

setroubleshoot can be told to use a particular file for an analysis. It normally
does analysis using the realtime audit stream. So I suspect you'd have to
manually run the analysis.

That said, we are working on centrally logging the audit events and reworking
setroubleshoot to work off that new datastream including the host names so that
you can do analysis correctly per machine.

-Steve


       
____________________________________________________________________________________
Choose the right car based on your needs.  Check out Yahoo! Autos new Car Finder tool.
http://autos.yahoo.com/carfinder/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
