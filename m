Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0DDstIi023557
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 08:54:55 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0DDspdm026460
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 13:54:58 GMT
Subject: Re: Multiple contexts
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, ivg2@cornell.edu,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050112233241.GF11846@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
	 <1105560687.11135.26.camel@cobra.ivg2.net>
	 <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112233241.GF11846@lkcl.net>
Content-Type: text/plain
Message-Id: <1105624601.15674.24.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 08:56:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 18:32, Luke Kenneth Casson Leighton wrote:

>  would you also agree that if someone wants to mess things up
>  with chcon then all bets are off for _any_ kind of analysis?
> 

Not true.  Look at Steve's earlier example again.
allow P1 F1:file read; 
allow P2 F2:file write;

In analyzing the policy, we don't care what files are labeled with F1 or
F2, what we care about is that there is no information flow between P1
and P2.  Using chcon will not change the fact that there is no
information flow between P1 and P2.

Now imagine that we do allow lists of file contexts.  We could then go
to the extreme of having a separate type for each permission and build
the policy by using lists of contexts.
allow P P_FR:file read;
allow P P_FW:file write;
allow P P_FE:file execute;
allow Q Q_FR:file read;
allow Q Q_FW:file write;
allow Q Q_FE:file execute;
and so on.
Now label the filesystem
file1 P_FR
file2 P_FR,P_FE,Q_FR,Q_FE
file3 P_FR,P_FW,P_FE,Q_FR
and so on.

How do you analyze the system now?  What can we say about the
information flow between P and Q without looking at the filesystem?  Do
you see that the policy is now on the filesystem?  Analysis of the
policy statically will not tell you anything, you have to know how the
filesystem is labeled to have any idea of the information flows.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
