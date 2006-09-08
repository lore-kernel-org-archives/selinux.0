Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88FDS5G022179
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 11:13:28 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88FCfn3024888
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 15:12:42 GMT
Subject: Re: [PATCH] policycoreutils semanage for nodes
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@gentoo.org>
Cc: Rodrigo Vivi <vivijim@br.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4501762F.9020803@gentoo.org>
References: <200609051527.41081.vivijim@br.ibm.com>
	 <4501762F.9020803@gentoo.org>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 11:12:03 -0400
Message-Id: <1157728323.21235.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-08 at 09:54 -0400, Joshua Brindle wrote:
> Rodrigo Vivi wrote:
> > Hi all,
> >
> > Since libsemanage support node context management and semanage command for 
> > policycoreutils does not, I thought that was a good idea to implement this.
> >
> > This patch provide all that semanage command needs to manage nodes context.
> > (including a man page updated)
> >
> > However I know that SECMARK mechanism largely obsoletes the use of
> > netif and node contexts going forward, but I did this patch because I was 
> > missing the node management at semanage command.
> >
> > Thanks,
> > Rodrigo Vivi.
> > (vivijim at #selinux)
> >   
> >   
> In addition to the comments below, I tried this patch out and while it 
> indeed added the nodecon it didn't seem to have a net effect on the 
> system. This is probably because of ordering issues which IIRC is why we 
> never had this support to begin with.
> 

How is this different from the port sorting problem? For a simple
example pre-pending the local modifications should have the desired
effect, so this sounds like a general semanage bug to me.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
