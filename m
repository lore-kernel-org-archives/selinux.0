Message-ID: <20050618153949.72823.qmail@web51502.mail.yahoo.com>
Date: Sat, 18 Jun 2005 08:39:49 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: SELinux Integrated Logging Tool
To: SELinux@tycho.nsa.gov
In-Reply-To: <90B34285-A36F-46C2-8081-3408F4241E6C@utulsa.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>This project was developed by Nicholas Davis and it is titled  
>"Improving the Logging Facility in Security Enhanced Linux." The  
>abstract for this paper and a link to a PDF version of it appear  
>below. Please post any feedback or questions you may have.

I read through it. I don't see what it has to do with SE Linux at all. It looks
like a general purpose syslog configurator. This is something that *is* needed
and people may like to use the tool for that purpose. It really does look
interesting, but for reasons other than SE Linux.

As James said, auditd is the way forward. It uses a more reliable communication
interface and is designed specifically to fill the audit niche. I have a "gui"
config tool that is based on dialog. I will probably put it on the web, but I am
reluctant to include it with the audit package at this point. If I find time, I
will probably extend it to include building auditctl rules.

There is a recent tool in the audit package, ausearch, that lets you search for
any event based on many criteria. At this point, the intention is to meet CAPP
needs, but future work is going to allow searching based on labels. There is also
a feature that many people don't know about and that is the ability to interpret
the logs so that its easier to understand. A sample use would be: ausearch -i -m
AVC.

I will be at OLS next month for the audit BoF. I would like to share with
attendees some of the possibilities for future development. This includes event
notification and an audit log explorer (not to be confused with a viewer).

-Steve Grubb


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
