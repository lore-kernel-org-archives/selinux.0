Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5O6Q5Ui019788
	for <selinux@tycho.nsa.gov>; Sat, 24 Jun 2006 02:26:05 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5O6Q49p016952
	for <selinux@tycho.nsa.gov>; Sat, 24 Jun 2006 06:26:04 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5O6Q4fH025518
	for <selinux@tycho.nsa.gov>; Sat, 24 Jun 2006 02:26:04 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5O6Q4N8004840
	for <selinux@tycho.nsa.gov>; Sat, 24 Jun 2006 02:26:04 -0400
Subject: Re: [PATCH] libselinux: 2/2 Convert functions to use new get,set
	procattrcon
From: Eric Paris <eparis@parisplace.org>
To: James Antill <jantill@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1151111346.21635.131.camel@code.and.org>
References: <1151094771.21012.94.camel@localhost.localdomain>
	 <1151111346.21635.131.camel@code.and.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 02:27:03 -0400
Message-Id: <1151130423.21012.107.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-23 at 21:09 -0400, James Antill wrote:
> On Fri, 2006-06-23 at 16:32 -0400, Eric Paris wrote:
> > The below patch will convert
> > 
> > -{get,set}fscreatecon()
> > -{get,set}execcon()
> > -{get,set}con()
> > -getpidcon()
> > -getprevcon()
> > 
> > to use the new {get,set}procattrcon() generic functions.  The only two
> > caveats are
> > 
> > both getprevcon_raw() and getcon_raw() had callers elsewhere in
> > libselinux.  So the raw version of these functions were left and now
> > call directly into the raw version of the generic functions.
> 
>  I see you removed a bunch of *_raw() functions, you've changed the ABI
> of the library and broken at least secon (in policycoreutils) and
> gnome-vfs2. Is that intentional?
> 
>  The hidden_def() doesn't make them library local functions, just
> creates the hidden version as an alias ... so ignore that part of my
> previous email.

Obviously I wasn't intending to break other things.   I thought the
hidden portion was actually making them library local and so I just
checked to make sure there were no other users in the library, that and
my machine didn't die a horrible death when I started using it.  They
are very simple to add back and I will post a patch that returns the
_raw functions and so doesn't change the abi at all on Monday.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
