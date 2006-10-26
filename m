Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9QGjlph004152
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 12:45:47 -0400
Subject: Re: socket options ... again
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <4540E083.2030304@hp.com>
References: <4540E083.2030304@hp.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 12:46:15 -0400
Message-Id: <1161881175.16681.239.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-26 at 12:21 -0400, Paul Moore wrote:
> I was looking at some policy and just realized that it's pretty liberal in
> handing out the socket setopt permission to domains; for some reason I was
> thought this was a rather rare thing.  This concerns me slightly because this is
> how NetLabel attaches security attributes to outgoing packets.
> 
> As a result I'm starting to look at how to best protect the NetLabel security
> attributes in the socket's IP options.  It is pretty straight forward to hook
> into the selinux_socket_setsockopt() function and watch for the
> IPPROTO_IP/IP_OPTIONS combination but my question to all of you is what is the
> "right" thing to do in such a case?  I can think of the following options (all
> of which are fairly easy to implement):
> 
> 1. If NetLabel is compiled into the kernel deny the application the right to set
> the socket's IP options.  This is pretty heavy handed but it would preserve the
> security attributes; although I have no idea the problems it might cause in the
> application space.
> 
> 2. If the socket has a NetLabel attached to it simply deny the access, otherwise
> allow it to proceed.  This has the problem in that it could allow a "bad"
> application to write it's own "evil" security attributes to the socket's IP
> option, although if there is no NetLabel attached to the socket (i.e. NetLabel
> was told to ignore this domain) this may be okay.
> 
> 3. If the application sets it's own security attributes, clear the socket's
> option field and replace it with the correct NetLabel option even if the
> NetLabel configuration for that domain is to leave the packets unlabeled.  The
> problem here is that we would be allowing the setsockopt() syscall to proceed
> without error then we would end up resetting the options on the socket (this
> would happen on the first write to the socket).
> 
> While option #1 is the easiest I don't really like the idea of simply denying
> applications the ability to set IP options (although I question how common this
> really is).  Option #3 is perhaps the most compatible, although it could lead to
> strange behavior with socket options changing underneath the application.  Which
> leads me to option #2, it does have the drawback I mentioned above, but then
> again there is nothing stopping applications from doing this currently.
> 
> Thoughts on these options?  Can anyone else think of a better solution?

ip_options_compile() checks CAP_NET_RAW for IPOPT_SEC, IPOPT_SID, and
any unknown options.  Is there a reason to not do likewise for setting
IPOPT_CIPSO from userspace (which you need to distinguish in some manner
from your internal setting)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
