MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ftp long time connection
Date: Tue, 19 Feb 2002 13:55:17 -0600
Message-ID: <1BF4DDD78DDA5D4EB0769BEA7F158E5A011BB229@amcw2ms812.amc.ds.af.mil>
From: "Flood Randy Capt AFCA/TCAA" <randy.flood@scott.af.mil>
To: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Do you have reverse DNS entries for your server and client and is DNS configured correctly?

If DNS is not set up properly you can get results like that.


-----Original Message-----
From: Justin Smith [mailto:jsmith@mcs.drexel.edu]
Sent: Tuesday, February 19, 2002 11:52 AM
To: SELinux@tycho.nsa.gov
Subject: Re: ftp long time connection


On Tue, 2002-02-19 at 12:06, Lonnie Cumberland wrote:
> The problem is that when I try to connect to my SELinux server from
> another Linux client that it takes about 2 - 3 minutes. I have even
> tried to give the IP instead of the host name and it still take this
> long time as well.
> 
>

Strange! I'd be inclined to think it has nothing to do with SELinux. I'm
running a web server with Servlets and JSP (the URL is 
http://vorpal.mcs.drexel.edu
) and haven't noticed any increase in access time. My web server is very
active, too (my students take exams via fill-out forms).

-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
