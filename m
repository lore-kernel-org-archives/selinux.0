Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.64.0602091155340.780@excalibur.intercode>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139501636.10222.11.camel@localhost>
	 <Pine.LNX.4.64.0602091155340.780@excalibur.intercode>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 11:39:47 -0600
Message-Id: <1139506788.10222.29.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-09 at 12:03 -0500, James Morris wrote:
<snip>
> > > security_task_getsid() doesn't exist.
> > > 
> > > You created security_task_getsecurity(), which retrieves the security
> > > context.
> > 
> > Actually, security_task_getsid() does exist (or did exist last time I
> > updated the viro/audit-2.6 git tree).
> > 
> > http://www.promethos.org/lxr/http/ident?i=security_task_getsid
> 
> Oh, ok.
> 
> Where is security_task_getsecurity() used, then?
> 
> 
> - James

Hm... :) I made it at first because I was just going to extract the
context directly and store it with the skb_params, but then decided to
go the 'sid' route.  I left it in to expand the LSM API a little, but if
it's not being used currently, it probably shouldn't be included, eh?

Thanks.

-tim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
