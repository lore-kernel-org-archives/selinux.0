Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kABHkMJT024570
	for <selinux@tycho.nsa.gov>; Sat, 11 Nov 2006 12:46:22 -0500
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kABHiiLQ013658
	for <selinux@tycho.nsa.gov>; Sat, 11 Nov 2006 17:44:44 GMT
Date: Sat, 11 Nov 2006 12:46:29 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, dccp@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH RFC] SELinux support for DCCP
In-Reply-To: <1163259994.12271.17.camel@localhost.localdomain>
Message-ID: <XMMS.LNX.4.64.0611111245380.29096@d.namei>
References: <XMMS.LNX.4.64.0611110203540.25507@d.namei>
 <1163259994.12271.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 11 Nov 2006, Eric Paris wrote:

> > +#define SECCLASS_CONTEXT                                 59
> > +#define SECCLASS_DCCP_SOCKET                             60
> 
> 
> What are the SECCLASS_CONTEXT, CONTEXT__CONTAINS, and CONTEXT__TRANSLATE
> changes?

The kernel headers have to match the userspace headers.  This context 
stuff is from userland.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
