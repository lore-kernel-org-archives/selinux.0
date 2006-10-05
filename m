Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95Enhtp022235
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 10:49:43 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95En4XA029495
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 14:49:06 GMT
Subject: RE: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
From: Joshua Brindle <jbrindle@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, paul.moore@hp.com,
        Linda Knippers <linda.knippers@hp.com>, redhat-lspp@redhat.com,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <36282A1733C57546BE392885C0618592015CF925@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015CF925@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 10:49:21 -0400
Message-Id: <1160059761.16462.7.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 14:41 -0400, Venkat Yekkirala wrote:
<snip>
> > >
> > > Received: Hello, root:system_r:semanage_t:s0-s0:c0.c255 from 
> > > root:system_r:semanage_t:s0-s0:c0.c255
> 
> Is the context after Hello, the context returned by getpeercon?
> 
> Also, where are you getting the "from" context from?
> 

Ok, the client connects to the server, the server responds with "Hello,
%s" where %s is what is returned from getpeercon(). The client takes
that response and adds "from %s" where %s is what is returned from
getpeercon() so the end result is:

"Hello, %s from %s", client_con, server_con

> > >
> > > no matter what context the server is running in.
> 
> Likely because you are running in permissive mode. ANY process can now
> "sendto" the same SA.
> 

Once Eric rolls a new kernel with the changes from yesterday I'll try it
again in enforcing to see how it works. (net-2.6 is being moody with
me :\ )




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
