Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANJBKIi014104
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 14:11:20 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANJ9ouA002724
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 19:09:50 GMT
Subject: Re: can_network patch.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jim Carter <jwcart2@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <4192A029.5050909@redhat.com>
	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
	 <419CB2A8.7020504@redhat.com>
	 <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1101236807.19785.216.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 23 Nov 2004 14:06:47 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-23 at 13:52, James Carter wrote:
> I am OK with what the changes do, but I would rather see a new macro
> then to just remove the connect permission from can_network().
> 
> On the other hand, it looks like there is 119 uses of can_network() and
> Dan is only adding 32 lines with connect permissions, so only 25% seem
> to need the connect permisison.
> 
> Would anyone be upset if the functionality of can_network() changes?
> 
> Any comments?

My preference:  Feel free to refactor can_network() into smaller macros
that can_network() then includes, but don't change the overall set of
permissions allowed by can_network().  Instead, change the calling
domains to use the smaller macros as appropriate, e.g. can_tcp_server()
for domains that just want bind/listen/accept (and the usual permissions
for basic use of the socket), can_tcp_client() for domains that just
want connect (and the usual permissions for basic use of the socket). 
If you are reading policy and you see can_network(), you should be able
to assume unrestricted use of the network.  If you see can_tcp_client(),
you get a clear sense as to what that means.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
