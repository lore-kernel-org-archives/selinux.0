Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6L09rgA021857
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 20:09:53 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6L04b9b028590
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 00:04:37 GMT
Date: Thu, 21 Jul 2005 01:05:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov,
   dwalsh@redhat.com
Subject: Re: SElinux nss/nscd serviceg
Message-ID: <20050721000509.GC9713@lkcl.net>
References: <1121794572.4780.15.camel@celtics.boston.redhat.com> <200507191825.j6JIPsvx013481@gotham.columbia.tresys.com> <20050719215424.GA8851@lkcl.net> <1121815377.15541.15.camel@localhost.localdomain> <20050720095524.GK8851@lkcl.net> <1121857492.24646.21.camel@localhost.localdomain> <20050720113015.GO8851@lkcl.net> <1121885541.29587.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121885541.29587.19.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 20, 2005 at 02:52:21PM -0400, Ivan Gyurdiev wrote:
> The primary question I have is - why should we have a daemon that runs
> in the background, when we currently have very few callers that will
> be using it, and at particularly rare circumstances (when you're
> administering user accounts). So, what's the justification
> for using up system resources with a daemon program. 

 nsswitch was mentioned at some point, hence reason why i recommended
 idea.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
