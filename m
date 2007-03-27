Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2RCabSv023131
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 08:36:37 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2RCaZFi025559
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 12:36:35 GMT
Subject: Re: system-config-service of iptables needs this patch to work in
	targeted policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46082B69.8070705@redhat.com>
References: <45F021D7.4060401@redhat.com> <1174938199.28830.72.camel@sgc>
	 <46082B69.8070705@redhat.com>
Content-Type: text/plain
Date: Tue, 27 Mar 2007 08:37:13 -0400
Message-Id: <1174999033.29300.19.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-26 at 16:22 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Thu, 2007-03-08 at 09:46 -0500, Daniel J Walsh wrote:
> >   
> >> Basically iptables needs to be able to output to the terminal and
> >> talk 
> >> to unconfined_pipes from the tool.
> >>

> >> +
> >> +optional_policy(`
> >> +       fail2ban_append_log(iptables_t)
> >> +')
> >>
> >>     
> >
> > But not this one since it doesn't seem relevant.
> >
> >   
> fail2ban is redirecting output from iptables to it's log files.  Would 
> you prefer dontaudit?

I just didn't know what it was about since you didn't mention it in the
description.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
