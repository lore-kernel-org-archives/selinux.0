Message-ID: <20041228174155.26868.qmail@web51510.mail.yahoo.com>
Date: Tue, 28 Dec 2004 09:41:55 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Issue on labeling a packet? (was Re: Issue on getting security context of socket and message)
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1104176897.15615.177.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 27 Dec 2004 at 14:48, Stephen Smalley wrote:
> > On Mon, 2004-12-27 at 14:48, Park Lee wrote:
> > Do ping replies (ICMP echo replies) belong to
> > forwarded packet? It seems that they are not
> > associated with a socket.
>
> They are associated with a special kernel socket, 
> created during initialization by the icmp_init() 
> function.  In 2.6, SELinux just labels all such 
> sockets with the kernel SID.

In 2.6, where are these special kernel socket (i.e.
icmp_socket and tcp_socket) labeled with the kernel
SID? 
Is there any more special kernel sockets in 2.6 except
the two that are mentioned?
  
Thank you.

=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
