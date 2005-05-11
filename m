Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4BIe5gA020280
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 14:40:05 -0400 (EDT)
Received: from web31607.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j4BIbMiX020237
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 18:37:22 GMT
Message-ID: <20050511183732.70786.qmail@web31607.mail.mud.yahoo.com>
Date: Wed, 11 May 2005 11:37:32 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
To: Chad Sellers <cdselle@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Chad Sellers <cdselle@tycho.nsa.gov> wrote:

> The two instances of /tmp/foo have different
> contexts (that's the
> reason /tmp was polyinstantiated in the first
> place).  Any audit
> messages (avc messages do this now) should include
> the context of the
> file (as well as device and inode), not just the
> filename.  So, the two
> instances can be differentiated.  Additionally,
> auditing based on
> filename is unreliable to begin with.

So long as the mapping from context to pathname
(via the mountpoint) can be reconstructed at a
later date this ought to work fine.


> I agree that this is a bad practice, but these
> programs could move to my
> scheme.  MLS applications that use "label flipping"
> have to be security
> aware in order to perform that flipping (meaning
> they have to call
> security functions to flip their label).  So, they
> could include a call
> to my library function to modify their namespace
> appropriately when
> flipping labels.

Hum. Yes, they could do that. I don't see
such a requirement being very popular.

> Of course, this requires the
> entrypoint program
> starting the application to have setup a new
> namespace for the
> application in the first place.  If the application
> flips so frequently
> that this affects performance, then I'd say the
> application is flipping
> labels a little too frequently.

Consider a MLS version of sendmail as your worst
case scenario.



Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
