Subject: Re: setsebool
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1152794516.2561.11.camel@localhost.localdomain>
References: <44AD708E.10205@us.ibm.com> <44B5623C.8060600@us.ibm.com>
	 <44B6265C.3010005@redhat.com>  <200607130734.35344.sgrubb@redhat.com>
	 <1152792392.2561.4.camel@localhost.localdomain>
	 <1152793604.10075.197.camel@moss-spartans.epoch.ncsc.mil>
	 <1152794516.2561.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 08:58:30 -0400
Message-Id: <1152795510.10075.229.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-13 at 08:41 -0400, Karl MacMillan wrote:
> > Steve Grubb already changed that printk to an audit_log call that only
> > displays changed values.  In 2.6.17.
> > 
> 
> Oops - that will teach me to look at old kernel source. Looking through
> the archives I didn't see that patch posted to this list (but maybe I
> missed it). Where was this discussed?

linux-audit and redhat-lspp lists.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
