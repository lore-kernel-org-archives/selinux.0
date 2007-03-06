Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l269Vl8U019913
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 04:31:47 -0500
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l269XC5I003291
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 09:33:13 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <D043357D-5AD2-4C8E-8282-63E4045EF0F4@sf-net.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: AVC denials debug
Date: Tue, 6 Mar 2007 10:33:00 +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

often when I try to create a new policy I have to execute the program  
a thousand times and examine the avc denials. There is one nasty  
problem if you execute the command three times behind the other you  
will only get avc denials for running the program the second time. I  
believe this is the wanted behaviour of the avc chache, isn't it?

A quote from "SELinux by example":
"The AVC chaches decisions made by the security server for subsequent  
access checks ...."
.....
"The AVC is invalidated when a policy is loaded,...."

This is exactly the behaviour I recognized everytime when I loaded  
the policy again and run the command I received "new" AVC denial.

So my question is how can I clean the AVC cache manually not only by  
loading a new policy?



Another question is there something out to suppress the dontaudit  
statements? I tried to run a CGI script in the httpd_$1_script_t  
domain type. The script is rejected with a "Internal Server Error"  
when SELinux is enforcing. There are no avc denials created!
So I believe there are some dontaudit statements I didn't cache. At  
the Tresys webside there is already a bug filled (#34) which  
addresses this issue (enableaudit). At the moment is there a dirty  
hack or something similar which could help me to find out the rules  
my policy still needs?


Regards,
Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
