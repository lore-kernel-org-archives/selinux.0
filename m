Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k19H3xXf026242
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 12:03:59 -0500 (EST)
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k19H2H7q000434
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 17:02:18 GMT
Date: Thu, 9 Feb 2006 12:03:10 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] collect security labels on user processes generating
 audit messages
In-Reply-To: <1139501636.10222.11.camel@localhost>
Message-ID: <Pine.LNX.4.64.0602091155340.780@excalibur.intercode>
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
 <1139501636.10222.11.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Feb 2006, Timothy R. Chavez wrote:

> > Please look at the way I intend to export SELinux APIs in:
> > http://people.redhat.com/jmorris/selinux/skfilter/kernel/12-skfilter-selinux-exports.patch
> 
> This looks good.  Do you have a schedule for releasing this?

No, it's blocked on some core netfilter changes.  I suggest following its 
format, though, if needed.

> > I wonder if it might be better to use the security context directly.
> >
> 
> I think it'd be the simplest solution, but I was a bit weary about
> adding a string param... I thought using an integer might be the path of
> least resistance :)

As previousl mentioned, also consider adding a security blob to the 
netlink params.

> > security_task_getsid() doesn't exist.
> > 
> > You created security_task_getsecurity(), which retrieves the security
> > context.
> 
> Actually, security_task_getsid() does exist (or did exist last time I
> updated the viro/audit-2.6 git tree).
> 
> http://www.promethos.org/lxr/http/ident?i=security_task_getsid

Oh, ok.

Where is security_task_getsecurity() used, then?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
