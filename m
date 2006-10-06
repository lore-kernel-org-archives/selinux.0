Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96EAX0Z025998
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 10:10:33 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96E9v03018248
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 14:09:57 GMT
Message-ID: <452663D3.4060103@hp.com>
Date: Fri, 06 Oct 2006 10:10:27 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, redhat-lspp@redhat.com,
        selinux@tycho.nsa.gov, Klaus Weidner <klaus@atsec.com>
Subject: Re: [redhat-lspp] Re: Networking policy patch
References: <45232276.2080105@trustedcs.com> <1160072287.26418.18.camel@sgc>
In-Reply-To: <1160072287.26418.18.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2006-10-03 at 21:54 -0500, Venkat Yekkirala wrote:
> 
>>FYI- I have posted the following patches separate from this one.
>>
>>1. A patch to address the "leask" issue. Once verified, it needs
>>to be rolled in with James' patch and sent on after verification.
>>
>>2. A fix for flow_in and flow_out where we were using the unlabeled
>>   init sid. We would now use a new network_t with a range of (s0-s15...)
>>   to allow for mls traffic to flow out/in, in the absence of explicit secmark
>>   rules.
>>
>>
>>The following is a sample patch for networking using the new controls
>>in conjunction with secmark.
>>
>>NOTE FOR JOSHUA: This patch also defines the constraints to force context
>>equality for association:sendto.
> 
> I'm starting a labeled networking branch of refpolicy to work with this.

Is this available yet?  If so, how do I got about getting a copy to take a look?

> I'm waiting until the dust settles before adding TE rules, but I have
> some questions:

Now that things are starting to calm down a bit I'm trying to get a chance to
look at the current policy and how it affects NetLabel.  In the secid case I
believe NetLabel can just ride on the back of the policy work you and Venkat are
discussing, however, if the reference policy is also going to support the
network compatability mode I suspect there will need to be some changes to allow
NetLabel'd traffic to work.

In the network compatability mode there is really only one new access check for
NetLabel:

 avc_has_perm(sock_sid, netlbl_sid, sock_class, recv_perm, ...)

  sock_sid: the socket's SID
  netlbl_sid: SECINITSID_UNLABELED w/the MLS label of the connection
  sock_class: SECCLASS_{UDP,TCP,<other*>}_SOCKET
  recv_perm: {UDP,TCP,RAWIP}_SOCKET__RECVFROM

  *other: all sockets not either a UDP or TCP socket use the RAWIP recvfrom
          permission

Based on my very limited knowledge of SELinux policy I think we would need the
following allow rules:

 # assumes the socket's context matches the parent processes' domain
 allow <domain> self:{udp_socket tcp_socket rawip_socket} { recvfrom }

I don't believe the above rule currently exists in the reference policy.

There is also an issue of writing policy for netlabelctl, the NetLabel
configuration tool.  Klaus and I have passed around some simple policy modules
on the lspp list which have provided policy for netlabelctl.  I'm going to try
and revisit the last version posted and see if it needs to be updated, once it
is working I would like to try and have it included in the reference policy.
Would you prefer I post the policy as a standalone policy module or as a patch
against the reference policy currently in SVN?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
