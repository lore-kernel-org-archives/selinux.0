Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1DNAwEc029107
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 18:10:58 -0500
Received: from g4t0015.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1DNAuAu021759
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 23:10:56 GMT
From: Paul Moore <paul.moore@hp.com>
To: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: [refpolicy] [PATCH] refpolicy: Add missing network related MLSconstraints
Date: Fri, 13 Feb 2009 18:10:47 -0500
Cc: chanson@TrustedCS.com, selinux@tycho.nsa.gov
References: <20090212211531.619341973@hp.com> <200902131702.10467.paul.moore@hp.com> <4995F310.30307@sun.com>
In-Reply-To: <4995F310.30307@sun.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902131810.47491.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 13 February 2009 05:24:16 pm Glenn Faden wrote:
> Paul Moore wrote:
> > On Friday 13 February 2009 04:38:03 pm Glenn Faden wrote:
> >> Paul Moore wrote:
> >>> Why were network objects not subject to privilege overrides in
> >>> legacy/traditional MLS systems?
> >>>
> >>> I ask because I think we are best off keeping the MLS constraints as
> >>> consistent as possible.  If there is a sound reason for avoiding policy
> >>> overrides for just the network controls than perhaps we should consider
> >>> "fixing" the rest of the constraints and not just the new ones.
> >>
> >> I can provide a bit of history about some legacy systems. In Trusted
> >> Solaris 8 there was a privilege, net_mac_read, that allowed a server to
> >> accept connections from clients with labels it didn't dominate. In order
> >> to reply, the server either needed to set the socket label to match the
> >> incoming client's label, or assert the privilege net_reply_equal. There
> >> was no corresponding net_mac_write privilege, because privilege programs
> >> were expected to use the network API to set their socket labels
> >> appropriately.
> >
> > Thanks, that is good to know.
> >
> >> In Solaris Trusted Extensions, neither the net_mac_read, net_mac_write,
> >> nor net_repy_equal privileges are implemented. It was viewed as a
> >> weakness in Trusted Solaris that MAC could be overridden by privilege.
> >> Instead, the administrator (who configures the system network policy)
> >> can enumerate multilevel network ports, and appropriately privileged
> >> services can bind to them.
> >
> > I assume by multilevel network ports you are talking about port
> > polyinstantiation and not a single (in every sense of the word) port that
> > allows a range of labels?
>
> Our terminology is different. Polyinstantiated ports are virtualized so
> that a single-level instance appears to exist at each label. Multilevel
> ports are TCB objects which can be used by privileged subjects to accept
> packets within an explicitly enumerated range of set of labels,
> determined by the administrator.

I thought that might be the case, glad to have that clarified.

In the case of SELinux, actually Linux in general, we don't have the polyport 
concept so we have to make so with multilevel ports and trusted applications.  
The label aware xinetd setup is about the closest we can get to faking 
polyport on Linux right now.  Interesting enough, even with SELinux's 
multilevel ports you still need a MLS constraint exception if the traffic's 
effective label does not equal the receiving socket's effective label.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
