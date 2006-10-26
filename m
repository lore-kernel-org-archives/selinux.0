Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9QI05IB007205
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 14:00:05 -0400
Subject: Re: socket options ... again
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <4540EEFF.4080606@hp.com>
References: <4540E083.2030304@hp.com>
	 <1161881175.16681.239.camel@moss-spartans.epoch.ncsc.mil>
	 <4540EEFF.4080606@hp.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 14:00:34 -0400
Message-Id: <1161885634.16681.274.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-26 at 13:23 -0400, Paul Moore wrote:
> Stephen Smalley wrote:
> > On Thu, 2006-10-26 at 12:21 -0400, Paul Moore wrote:
> > 
> >>Thoughts on these options?  Can anyone else think of a better solution?
> > 
> > ip_options_compile() checks CAP_NET_RAW for IPOPT_SEC, IPOPT_SID, and
> > any unknown options.  Is there a reason to not do likewise for setting
> > IPOPT_CIPSO from userspace (which you need to distinguish in some manner
> > from your internal setting)?
> 
> Ah ha ... thank you for the lightbulb moment.
> 
> Adding CAP_NET_RAW in ip_options_compile() would solve the problem in a manner
> which makes the most sense from an application point of view.  However, it does
> present a problem in that potentially even applications without CAP_NET_RAW will
> need to have a CIPSO options set by the kernel, as you noted in the comment
> about distinguishing between NetLabel and applications.
> 
> Right now the CIPSO code only makes use of ip_options_compile() in two places
> (that I can think of): the first is when a packet enters the system via
> ip_rcv_options() in ip_rcv_finish(), the second when a socket is created by an
> application and cipso_v4_socket_setattr() is called.  I don't believe
> CAP_NET_RAW should be an issue in the first case (please correct me if I'm
> wrong) but it would cause problems in the second case.  Considering the blank
> slate of a new socket and the very simple nature of the CIPSO code in
> ip_options_compile() it may be the best option is to simply handle the
> ip_options_compile() tasks directly in cipso_v4_socket_setattr().
> 
> Does this sound reasonable?

To clarify, the existing capable checks in ip_options_compile() are only
applied on the output processing (they check for a NULL skb), never on
the input side.

It seems like your internal use of ip_options_compile() from cipso is
overkill, since it then just calls back into your cipso code for the
CIPSO option, right?  So just handling it directly within the cipso code
makes sense to me.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
