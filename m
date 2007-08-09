Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79FFb9i009405
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 11:15:37 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79FFac5009712
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 15:15:36 GMT
Received: by an-out-0708.google.com with SMTP id c38so111861ana
        for <selinux@tycho.nsa.gov>; Thu, 09 Aug 2007 08:15:36 -0700 (PDT)
Message-ID: <9f066ee90708090815t514eddf6k7d02903d806d7c6c@mail.gmail.com>
Date: Thu, 9 Aug 2007 11:15:35 -0400
From: Mark <elihusmails@gmail.com>
To: selinux@tycho.nsa.gov,
        "fedora-selinux-list@redhat.com" <fedora-selinux-list@redhat.com>
Subject: java error after installing reference policy
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6174_6513594.1186672535760"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_6174_6513594.1186672535760
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I followed the instructions for installing the latest reference policy:
http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy

After rebooting, I get the following command when I run SLIDE:

Java HotSpot(TM) Client VM warning: Attempt to allocate stack guard pages
failed.
Error occurred during initialization of VM
Could not reserve enough space for code cache

I then tried just running "java -version", and I get the same error message.

I am running Sun's JDK version 1.6 update 2.


-- 
..Cheers
Mark

------=_Part_6174_6513594.1186672535760
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I followed the instructions for installing the latest reference policy: <a href="http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy">http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy</a><br><br>After rebooting, I get the following command when I run SLIDE:
<br><br>Java HotSpot(TM) Client VM warning: Attempt to allocate stack guard pages failed.<br>Error occurred during initialization of VM<br>Could not reserve enough space for code cache<br><br>I then tried just running &quot;java -version&quot;, and I get the same error message.
<br><br>I am running Sun&#39;s JDK version 1.6 update 2.<br><br><br>-- <br>..Cheers<br>Mark

------=_Part_6174_6513594.1186672535760--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
