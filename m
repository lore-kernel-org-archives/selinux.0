Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MAt9dW021813
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 05:55:10 -0500 (EST)
Received: from mail02.infosat.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MAqoZE020866
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 10:52:53 GMT
Received: from [196.38.110.14] (HELO mail01.infosat.net)
  by mail02.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with ESMTP id 207528396 for selinux@tycho.nsa.gov; Tue, 22 Feb 2005 11:52:33 +0200
Received: from [66.18.72.157] (HELO hivsa.com)
  by mail01.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with SMTP id 644661735 for selinux@tycho.nsa.gov; Tue, 22 Feb 2005 11:52:31 +0200
From: Jayendren Anand Maduray <jayendren@hivsa.com>
Reply-To: jayendren@mweb.co.za
To: russell@coker.com.au
Subject: Re: fc3 - password change problem - syslog and portmapper
Date: Tue, 22 Feb 2005 11:51:19 +0200
Cc: jayendren@mweb.co.za, "SE-Linux" <selinux@tycho.nsa.gov>
References: <200502220809.40631.jayendren@hivsa.com> <200502221752.34349.russell@coker.com.au>
In-Reply-To: <200502221752.34349.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502221151.19612.jayendren@hivsa.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!
syslogd reports it is unable to start, error:
´Access Denied´
the same message for portmapper.

do u want a copy of the syslog?


On Tuesday 22 February 2005 08:52, Russell Coker wrote:
> On Tuesday 22 February 2005 17:09, Jayendren Anand Maduray
>
> <jayendren@hivsa.com> wrote:
> > 1. however when i try to change my password, i get the ffg error:
> > SystemError: couldn't get security context of `/etc/passwd': No data
> > available
>
> Do you get any AVC messages?  If so what are they?
>
> What is the output of "ls -lZ /etc/passwd"?
>
> > 2. also, when i boot up, syslogd, and portmap cannot start, so i disabled
> > it in SELinux. i would like to get this to work, though.
>
> How are they unable to start?  Are there any AVC messages?  Is there
> something in syslog?

-- 
Jayendren Anand Maduray
Microsoft Certified Professional
Network Plus
IT Administrator  

Perinatal HIV Research Unit
Old Potch Road
Chris Hani Baragwanath Hospital
Soweto
South Africa

Tel: +27 11 989 9776
Tel: +27 11 989 9999
Fax: +27 11 938 3973
Cel: 082 22 774 94


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
