Subject: Re: Issue on getting security context of socket and message
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20041126185018.56868.qmail@web51503.mail.yahoo.com>
References: <20041126185018.56868.qmail@web51503.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1101741165.13948.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 29 Nov 2004 10:12:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-26 at 13:50, Park Lee wrote:
> I'm now trying to do something on integrating IPsec with SELinux. Now
> I need to get the security context of a socket and the socket itself.
> Would you please tell me further that when an outbound packet is going
> to be send, How can we get the struct socket itself (i.e. the socket
> that is related to the outbound packet. it refers that when we want to
> send the packet, we should first set up the socket )?

Look at selinux_ip_postroute_last() in hooks.c.
 
> And, in kernel-space, How can we transfer a SID to a security context?
> Is there any function can we use to achieve it?

There is a security_sid_to_context() function; look at the existing
hooks.c code for usage.

But I don't think that this is likely going to be a productive use of
your time, as I think Trent Jaeger of IBM is already much further
along.  Likely better to wait for release of his patch, then see how you
can contribute to further development of it.  You might be better served
by looking into userspace issues, e.g. modifying racoon to deal with
security contexts.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
