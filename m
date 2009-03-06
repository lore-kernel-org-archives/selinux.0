Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n26LI1c5001519
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 16:18:01 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n26LELUg024607
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 21:14:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Talking to Nalin today about the path substitution semanage problem, and he came up  with a great idea.
Date: Sat, 7 Mar 2009 08:17:43 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <49B18A30.7080507@redhat.com>
In-Reply-To: <49B18A30.7080507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200903070817.50428.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 7 Mar 2009, Daniel J Walsh <dwalsh@redhat.com> wrote:
> With this type of functionality we can either get rid of genhomedircon
> or allow it to just generate subs files that look like
>
> /export/home /home
> /usr/local/home /home
>
> This has a side benefit of decreasing the size of regexs we need to
> compile.
>
> I think there is little to no costs.  Other the strcmp on all paths
> handed in times the number of substitutions.
>
> What do you think?

Sounds OK apart from the fact that it doesn't set the identity.

What if you had an optional third field to store the identity for mapping 
individual users?

Also what are the plans regarding roles nowadays?  Is there still a plan to 
use roles other than object_r in filesystem labels?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
