Subject: Re: New ideas on implementation on libsetrans.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050914172547.14693.qmail@web51506.mail.yahoo.com>
References: <20050914172547.14693.qmail@web51506.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 14:01:51 -0400
Message-Id: <1126720911.12299.142.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 10:25 -0700, Steve G wrote:
> My concern which lead to consideration of the daemon approach is the performance
> penalty imposed by dlopen & dlsym as well as parsing the configuration each time
> a program starts up. dlopen is a heavy function call. Communication across a
> af_unix socket is likely to be faster since there are fewer syscalls.

BTW, I'd want to see measurements there before jumping to that
assumption.  Don't forget the socket setup and context switch overhead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
