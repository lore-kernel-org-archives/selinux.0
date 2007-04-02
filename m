Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32JsbtQ024006
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 15:54:37 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l32Jsaft001189
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 19:54:36 GMT
Subject: Re: secmark integration
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: James Morris <jmorris@namei.org>
Cc: Joshua Brindle <method@manicmethod.com>,
        Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <Line.LNX.4.64.0704021546210.9184@d.namei>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
	 <1175286309.20396.13.camel@localhost.localdomain>
	 <Line.LNX.4.64.0703302201520.29742@d.namei> <46111709.9060402@redhat.com>
	 <1175525718.20396.46.camel@localhost.localdomain>
	 <Line.LNX.4.64.0704021215020.8213@d.namei>
	 <46113A09.4040607@manicmethod.com>
	 <1175534882.5433.17.camel@localhost.localdomain>
	 <Line.LNX.4.64.0704021546210.9184@d.namei>
Content-Type: text/plain
Date: Mon, 02 Apr 2007 15:52:17 -0400
Message-Id: <1175543537.5492.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-02 at 15:47 -0400, James Morris wrote:
> On Mon, 2 Apr 2007, Karl MacMillan wrote:
> 
> > I think that controlling port binding plus separating the traffic with
> > secmark will be sufficient in most cases. There is no advantage to
> > replicating the port binding rules with secmark (except perhaps with
> > protocols that connect to random ports like nis or ftp).
> 
> There definitely is, as connection tracking will ensure that only packets 
> which are valid for the connection are labeled appropriately, so you don't 
> need open rules for ephemeral ports etc., as well as the tighter security 
> in general.
> 

I'm not arguing that secmark doesn't have some advantages, particularly
around connection tracking. What I'm saying is that controlling port
binding in the way we currently do is sufficient as a starting point.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
