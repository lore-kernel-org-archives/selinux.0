Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96JuNPV006961
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 15:56:23 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96Jtlru003521
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 19:55:47 GMT
Subject: Re: Denials from newest kernel
From: Joshua Brindle <jbrindle@tresys.com>
To: James Morris <jmorris@namei.org>
Cc: Steve G <linux_4ever@yahoo.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
In-Reply-To: <Pine.LNX.4.64.0610061550250.7528@d.namei>
References: <20061006184110.90042.qmail@web51508.mail.yahoo.com>
	 <Pine.LNX.4.64.0610061550250.7528@d.namei>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 15:56:24 -0400
Message-Id: <1160164584.2905.39.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 15:50 -0400, James Morris wrote:
> 
> Is there policy to support secmark properly in RHEL5?  If not, it
> needs 
> to be disabled. 

refpolicy defines the secmark rules and the selinux rules so that is
fine, however there is no infrastructure to get the netfilter_contexts
into the running iptables so things explode quickly.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
