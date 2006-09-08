Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88HpPG6027921
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 13:51:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88HoceD024439
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 17:50:38 GMT
Subject: Re: [PATCH] policycoreutils semanage for nodes
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@gentoo.org>
Cc: Rodrigo Vivi <vivijim@br.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45019051.304@gentoo.org>
References: <200609051527.41081.vivijim@br.ibm.com>
	 <4501762F.9020803@gentoo.org>
	 <1157728323.21235.24.camel@localhost.localdomain> <45019051.304@gentoo.org>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 13:51:00 -0400
Message-Id: <1157737860.21235.68.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-08 at 11:46 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Fri, 2006-09-08 at 09:54 -0400, Joshua Brindle wrote:
> >   
> >> Rodrigo Vivi wrote:
> >>     
> >>> Hi all,
> >>>
> >>> Since libsemanage support node context management and semanage command for 
> >>> policycoreutils does not, I thought that was a good idea to implement this.
> >>>
> >>> This patch provide all that semanage command needs to manage nodes context.
> >>> (including a man page updated)
> >>>
> >>> However I know that SECMARK mechanism largely obsoletes the use of
> >>> netif and node contexts going forward, but I did this patch because I was 
> >>> missing the node management at semanage command.
> >>>
> >>> Thanks,
> >>> Rodrigo Vivi.
> >>> (vivijim at #selinux)
> >>>   
> >>>   
> >>>       
> >> In addition to the comments below, I tried this patch out and while it 
> >> indeed added the nodecon it didn't seem to have a net effect on the 
> >> system. This is probably because of ordering issues which IIRC is why we 
> >> never had this support to begin with.
> >>
> >>     
> >
> > How is this different from the port sorting problem? For a simple
> > example pre-pending the local modifications should have the desired
> > effect, so this sounds like a general semanage bug to me.
> >
> >   
> Which wasn't fixed in this patch and so shouldn't be merged

Rodrigo - are you interested in trying to get to the bottom of this?
Otherwise, please file a bug [1] and attach your existing patch.

Thanks,

Karl

[1] http://sourceforge.net/tracker/?group_id=21266&atid=121266


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
