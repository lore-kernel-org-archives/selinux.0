Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m59Nli1V031146
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 19:47:44 -0400
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m59Nlh3R024929
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 23:47:43 GMT
Date: Tue, 10 Jun 2008 09:28:26 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: fix off by 1 reference of class_to_string in
 context_struct_compute_av
In-Reply-To: <1213041295.4597.12.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0806100927570.25308@us.intercode.com.au>
References: <1213040592.4597.8.camel@localhost.localdomain>
 <1213041295.4597.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Jun 2008, Eric Paris wrote:

> On Mon, 2008-06-09 at 15:43 -0400, Eric Paris wrote:
> > The class_to_string array is referenced by tclass.  My code mistakenly
> > was using tclass - 1.  If the proceeding class is a userspace class
> > rather than kernel class this may cause a denial/EINVAL even if unknown
> > handling is set to allow.  The bug shouldn't be allowing excess
> > priveladges since those are given based on the contents of another array
> > which should be correctly referenced.
> > 
> > At this point in time its pretty unlikely this is going to cause
> > problems.  The most recently added kernel classes which could be
> > affected are association, dccp_socket, and peer.  Its pretty unlikely
> > any policy with handle_unknown=allow doesn't have association and
> > dccp_socket undefined (they've been around longer than unknown handling)
> > and peer is conditionalized on a policy cap which should only be defined
> > if that class exists in policy.
> > 
> > -Eric
> 
> James I forgot my signed-off you want to just add it?

I'll add it, and queue for 2.6.26.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
