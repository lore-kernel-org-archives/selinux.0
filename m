Subject: Re: Issue on labeling a packet? (was Re: Issue on getting security
	context of socket and message)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20041228174155.26868.qmail@web51510.mail.yahoo.com>
References: <20041228174155.26868.qmail@web51510.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1104256850.21391.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Dec 2004 13:00:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-12-28 at 12:41, Park Lee wrote:
> In 2.6, where are these special kernel socket (i.e.
> icmp_socket and tcp_socket) labeled with the kernel
> SID? 
> Is there any more special kernel sockets in 2.6 except
> the two that are mentioned?

See 
http://marc.theaimsgroup.com/?l=bk-commits-head&m=108407589700679&w=2
and
http://marc.theaimsgroup.com/?l=bk-commits-head&m=108407590404054&w=2
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
