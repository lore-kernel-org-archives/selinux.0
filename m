Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAFmFIi020986
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 10:48:15 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAFkbwg002853
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 15:46:37 GMT
Subject: Re: can_network patch.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41A4BCC9.10604@redhat.com>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <4192A029.5050909@redhat.com>
	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
	 <419CB2A8.7020504@redhat.com>
	 <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
	 <41A4B54F.3070709@redhat.com>
	 <1101314370.22014.198.camel@moss-spartans.epoch.ncsc.mil>
	 <41A4BCC9.10604@redhat.com>
Content-Type: text/plain
Message-Id: <1102693385.1628.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 10:43:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-24 at 11:54, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> >Sorry, why would you want to allow mozilla to run userhelper? 
> >
> system-config-packages

I can run system-config-packages here on FC3 without this domain
transition defined, and I don't see how mozilla factors into it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
