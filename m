Subject: Re: New ideas on implementation on libsetrans.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050914172547.14693.qmail@web51506.mail.yahoo.com>
References: <20050914172547.14693.qmail@web51506.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 13:52:13 -0400
Message-Id: <1126720333.12299.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 10:25 -0700, Steve G wrote:
> Are there any other common utilities that would cause a performance hit? pam
> modules for example. If its just ls -Z, I'm not too worried. I do worry if it
> gets into something that is performance sensitive like dbus, nscd, etc.

Anything that gets a context from libselinux or passes a context to it.
That would include pam_selinux, dbusd, nscd, ...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
