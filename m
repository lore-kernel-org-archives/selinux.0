Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l78Fe4wV009665
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 11:40:04 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l78Fe4Mx000453
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 15:40:04 GMT
Received: by an-out-0708.google.com with SMTP id c38so41401ana
        for <selinux@tycho.nsa.gov>; Wed, 08 Aug 2007 08:40:04 -0700 (PDT)
Message-ID: <9f066ee90708080840q627adbbavb9e83b45a9f017e8@mail.gmail.com>
Date: Wed, 8 Aug 2007 11:40:03 -0400
From: Mark <elihusmails@gmail.com>
To: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Subject: only allow 1 port for listening
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3078_30185273.1186587603815"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_3078_30185273.1186587603815
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am new to writing policies and have been reading the reference policy
files.  I wrote a simple TCP server that listens on a port for connections.
I would like to write a policy that will only allow my program to bind to a
specific port(9999).  I looked at the reference policy and see that the
ports that programs are allowed to use is in
policy/modules/kernel/corenetwork.te.  My questions is, can I specify the
port in my programs type enforcement file so that I can make a module
instead of listing this in the kernel policy?  If so, what would the syntax
be?

Thanks in advance.

-- 
..Cheers
Mark

------=_Part_3078_30185273.1186587603815
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am new to writing policies and have been reading the reference policy files.&nbsp; I wrote a simple TCP server that listens on a port for connections.&nbsp; I would like to write a policy that will only allow my program to bind to a specific port(9999).&nbsp; I looked at the reference policy and see that the ports that programs are allowed to use is in policy/modules/kernel/corenetwork.te.&nbsp; My questions is, can I specify the port in my programs type enforcement file so that I can make a module instead of listing this in the kernel policy?&nbsp; If so, what would the syntax be?
<br><br>Thanks in advance.<br clear="all"><br>-- <br>..Cheers<br>Mark

------=_Part_3078_30185273.1186587603815--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
