Message-ID: <20041230184046.93768.qmail@web51501.mail.yahoo.com>
Date: Thu, 30 Dec 2004 10:40:46 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Issue on labeling a packet? (was Re: Issue on getting security context of socket and message)
To: sds@epoch.ncsc.mil
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 28 Dec 2004 at 13:00, Stephen Smalley wrote:
> On Tue, 2004-12-28 at 12:41, Park Lee wrote:
> > In 2.6, where are these special kernel socket 
> > (i.e.icmp_socket and tcp_socket) labeled with the 
> > kernel SID? 
> > Is there any more special kernel sockets in 2.6 
> > except the two that are mentioned?
>
> See 
>
http://marc.theaimsgroup.com/?l=bk-commits-head&m=108407589700679&w=2
> and
>
http://marc.theaimsgroup.com/?l=bk-commits-head&m=108407590404054&w=2

Thank you very much.
I've seen them, and know how/where these special
kernel socket are labeled now.

Let's suppose that when a packet is sending out
(through XFRM architecture), how can we decide whether
the packet is associated with a kernel socket or a
user socket?  

Thank you.


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
