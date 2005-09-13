Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8DLPlNs028628
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 17:25:47 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8DLModV022980
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 21:22:50 GMT
Date: Tue, 13 Sep 2005 22:22:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New ideas on implementation on libsetrans.
Message-ID: <20050913212236.GA540@lkcl.net>
References: <43271BDA.3060403@redhat.com> <43272C09.3050105@trustedcs.com> <43272E92.4060400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43272E92.4060400@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 13, 2005 at 03:54:58PM -0400, Daniel J Walsh wrote:
> >Have you put any thought into the language that libselinux and the 
> >daemons
> >would speak over the socket?
> >
> I like ASCII... Of course if someone wants to take the ball and run with 
> it, it would be great.
 
 before making a decision: what level of complexity are we looking at?

 if you're looking at a horrendous set of interlinked structs, combining
 variable-length arrays of unions containing further variable-length
 arrays of structs, such as this:

 http://cvs.sourceforge.net/viewcvs.py/oser/exchange5.5/exploration/test/emsabp/emsabp.idl?rev=1.1&view=markup

 then you would be completely and utterly insane to do this by hand.

 if, however, on the other hand, you are looking at a simple "gimme one
 bit of data" "here you go" then yeh, ascii would be fine (and, to be
 honest, infinitely preferable).


 winbindd needs to handle binary data structures, and _fortunately_ it
 has access to a whole boat-load of MSRPC infrastructure / pickling
 code.

 so even though it's handling data structures such as NET_USER_INFO_3
 variable-length optional-extras nightmares, the code already exists
 (which was created by hand, and NET_USER_INFO_3 on its own took several
 hours to do) so we use it.

 
 one technique deployed by winbindd is to have a "fixed size" data blob
 and an optional "variable length" data blob.

 the "fixed size" one is the union of a whole stack of structs,
 with an integer "info level" which is the "command", and that
 info level specifies which of the structs in the union is actually
 contained in the fixed-size data blob.

 it's a technique known as "encapsulated unions".


 so.

 what do the data structures look like?

 tell me they're nice and simple...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
