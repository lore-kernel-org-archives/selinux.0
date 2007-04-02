Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32Jlkgf023655
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 15:47:46 -0400
Received: from mail1.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l32Jljss001085
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 19:47:45 GMT
Date: Mon, 2 Apr 2007 15:47:42 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
cc: Joshua Brindle <method@manicmethod.com>,
        Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: secmark integration
In-Reply-To: <1175534882.5433.17.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0704021546210.9184@d.namei>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
 <1175284031.3602.24.camel@localhost.localdomain>
 <1175286309.20396.13.camel@localhost.localdomain>  <Line.LNX.4.64.0703302201520.29742@d.namei>
  <46111709.9060402@redhat.com>  <1175525718.20396.46.camel@localhost.localdomain>
  <Line.LNX.4.64.0704021215020.8213@d.namei>  <46113A09.4040607@manicmethod.com>
 <1175534882.5433.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Apr 2007, Karl MacMillan wrote:

> I think that controlling port binding plus separating the traffic with
> secmark will be sufficient in most cases. There is no advantage to
> replicating the port binding rules with secmark (except perhaps with
> protocols that connect to random ports like nis or ftp).

There definitely is, as connection tracking will ensure that only packets 
which are valid for the connection are labeled appropriately, so you don't 
need open rules for ephemeral ports etc., as well as the tighter security 
in general.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
