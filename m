Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81FTkR4012026
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 11:29:47 -0400
Received: from web36605.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k81FT7Oi018491
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 15:29:08 GMT
Message-ID: <20060901152930.44570.qmail@web36605.mail.mud.yahoo.com>
Date: Fri, 1 Sep 2006 08:29:30 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: FW: [serue@us.ibm.com: Re: [redhat-lspp] LSPP Development Telecon  08/21/2006 Minutes]
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <36282A1733C57546BE392885C061859201512D15@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Venkat Yekkirala <vyekkirala@TrustedCS.com> wrote:


> It started by us looking at what cipso provides.  My
> idea was that
> algorithm would identify the LSM, and doi would
> identify some policy
> domain.  I.e. you could clearly separate hosts
> within a network based
> on policy properties by using distinct doi's.

The intent of the 1980s CIPSO developers
was that the Domain Of Interpretation (DOI)
be used to distinguish administrative domains.
It was assumed that if a socket received a
packet marked with a DOI that is was not able
to properly interpret that the packet would be
rejected. It was also assumed that if the DOI
was recognized it was a clear indication that
the information in the CIPSO header ought to
be interpretable on this machine.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
