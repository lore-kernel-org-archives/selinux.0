Subject: Re: SELinux with IPSec - something going on ?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: petre rodan <kaiowas@gentoo.org>
Cc: Park Lee <parklee_sel@yahoo.com>, SELinux@tycho.nsa.gov,
   rusinskystanislas@yahoo.fr
In-Reply-To: <417D20F6.1080607@gentoo.org>
References: <20041024093014.14853.qmail@web51506.mail.yahoo.com>
	 <417D20F6.1080607@gentoo.org>
Content-Type: text/plain
Message-Id: <1098719750.13491.187.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 25 Oct 2004 11:55:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-25 at 11:51, petre rodan wrote:
> Hi,
> 
> here is a fresh ipsec-tools [1] policy made for gentoo.
> works flawlessly with my setup [2] (the doc is work in progress).
> 
> [1] http://ipsec-tools.sourceforge.net/
> [2] http://dev.gentoo.org/~kaiowas/doc/wifi_ipsec-howto.html
> 
> is this usable for any of you?

Thanks for making it available.  However, just to clarify, the original
question had to do with integration of SELinux and IPSEC for the purpose
of labeling and protecting network packets in accordance with security
policy, as was done in research predecessors of SELinux (Flask and
DTOS).  Trent is doing work in that area, as he noted.  That is
independent of providing policy for IPSEC userland components (which is
also certainly useful).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
