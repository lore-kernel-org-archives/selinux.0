Subject: Re: [PATCH] restorecond memory leaks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070220175747.16810.qmail@web51504.mail.yahoo.com>
References: <20070220175747.16810.qmail@web51504.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 22 Feb 2007 09:02:02 -0500
Message-Id: <1172152922.14363.351.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 09:57 -0800, Steve G wrote:
> Hi,
> 
> Attached is a patch addressing memory leaks in restorecond. It still consumes way
> too much memory, but this fixes all know leaks and valgrind now reports all
> memory freed at exit.
> 
> Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>

Thanks, merged into -trunk and -stable.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
