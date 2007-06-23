Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5N0Heob005291
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 20:17:40 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5N0HcU7012527
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 00:17:38 GMT
Date: Fri, 22 Jun 2007 20:17:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        James Carter <jwcart2@epoch.ncsc.mil>,
        Chris Vance <Christopher.Vance@sparta.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>, nfsv4@linux-nfs.org,
        Trond Myklebust <trond.myklebust@fys.uio.no>, neilb@suse.de
Subject: Re: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
In-Reply-To: <519223.91074.qm@web36605.mail.mud.yahoo.com>
Message-ID: <Line.LNX.4.64.0706222014400.9045@localhost.localdomain>
References: <519223.91074.qm@web36605.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Jun 2007, Casey Schaufler wrote:

> Somewhere between 2000 and 2002 (it's all a blur to me now) SGI
> made the OB1 project available on oss.sgi.com.

I remember that :-)

> Included in this
> project was the source code for an extended attribute protocol
> to sit beside NFSv3. I have attached the code as a worked example
> of how one can go about implementing linux style* extended attributes
> in a distributed environment. This scheme does not address all of
> your requirements, it only addresses transport and storage, it does
> not address authentication or validation.

Interesting -- I gather you ran this over labeled networking?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
