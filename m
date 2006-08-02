Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72F1rP8031000
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 11:01:54 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k72F1meA008432
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 15:01:48 GMT
Subject: Re: [PATCH 4/6] netfilter integration take 2: add netfilter
	contexts sorting
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1154529122.27457.56.camel@localhost.localdomain>
References: <1154457791.31522.150.camel@sgc.columbia.tresys.com>
	 <1154529122.27457.56.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 11:02:57 -0400
Message-Id: <1154530977.31522.170.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-02 at 10:32 -0400, Karl MacMillan wrote:
> On Tue, 2006-08-01 at 14:43 -0400, Christopher J. PeBenito wrote:
> > +		/* Sort the netfilter contexts. */
> > +		if (semanage_nc_sort
> > +		    (sh, sepol_module_package_get_netfilter_contexts(base),
> > +		     sepol_module_package_get_netfilter_contexts_len(base),
> > +		     &sorted_nc_buffer, &sorted_nc_buffer_len) < 0) {
> > +			goto cleanup;
> > +		}
> 
> This is very difficult to read. Please split into multiple lines so that
> lindent doesn't do this.

I partly agree.  Separating the return code check out would be ok, but I
believe the other function calls are ok.  If the two function calls had
multiple parameters, then it would be hard to read, since you could get
confused about which comma goes with which function call.  I think
lindent makes it easier to read than if it were on one line.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
