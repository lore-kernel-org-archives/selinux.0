Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96KDIQF007987
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 16:13:18 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k96KC5QW024385
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 20:12:05 GMT
Subject: Re: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: James Morris <jmorris@namei.org>, Steve G <linux_4ever@yahoo.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
In-Reply-To: <1160164584.2905.39.camel@twoface.columbia.tresys.com>
References: <20061006184110.90042.qmail@web51508.mail.yahoo.com>
	 <Pine.LNX.4.64.0610061550250.7528@d.namei>
	 <1160164584.2905.39.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 16:13:19 -0400
Message-Id: <1160165599.8690.27.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 15:56 -0400, Joshua Brindle wrote:
> On Fri, 2006-10-06 at 15:50 -0400, James Morris wrote:
> > 
> > Is there policy to support secmark properly in RHEL5?  If not, it
> > needs 
> > to be disabled. 
> 
> refpolicy defines the secmark rules and the selinux rules so that is
> fine, however there is no infrastructure to get the netfilter_contexts
> into the running iptables so things explode quickly.

Not entirely accurate; anyone that has networking can send and receive
unlabeled_t packets currently.  It originally was a temporary
compatibility thing until we could figure out how to manage the labels.
But since that part hasn't been figured out, the decision was made to
turn on secmark with no labeling rules and put the unlabeled packet
perms in, but make them conditional (a boolean).  So if someone wanted
to constrain networking, they could load up the iptables labeling rules,
and disable the boolean.  The boolean has not been implemented yet, but
it should be straightforward.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
