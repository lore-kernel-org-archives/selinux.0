Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6L093gA021830
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 20:09:03 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6L03l9b028562
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 00:03:47 GMT
Date: Thu, 21 Jul 2005 01:04:01 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov,
   dwalsh@redhat.com
Subject: Re: SElinux nss/nscd service
Message-ID: <20050721000401.GB9713@lkcl.net>
References: <1121794572.4780.15.camel@celtics.boston.redhat.com> <200507191825.j6JIPsvx013481@gotham.columbia.tresys.com> <20050719215424.GA8851@lkcl.net> <1121815377.15541.15.camel@localhost.localdomain> <20050720095524.GK8851@lkcl.net> <1121857492.24646.21.camel@localhost.localdomain> <20050720113015.GO8851@lkcl.net> <1121885541.29587.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121885541.29587.19.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 20, 2005 at 02:52:21PM -0400, Ivan Gyurdiev wrote:
> 
> > > Pam modules are for authentication and login issues. 
> > > This mapping is used for other purposes as well, and also needs to 
> > > be modified from multiple programs and/or shared libraries, which should
> > > not replicate the necessary code.
> > 
> >  then you almost undoubtedly need something like winbindd in
> >  order to "centralise" the management of the security "classes",
> 
> Management can be centralized just fine with a shared library.
> 
> >  and to provide a simple RPC mechanism for communicating over a unix
> >  domain socket (or other IPC mechanism - but _please_ don't put dbus
> >  on the list of options to explore).
> 
> RPC? Before we write something incredibly complex here, please

 remote procedure calls don't need to be complex.  winbindd's
 RPC API comprises some statically sized structs, a uint8 to
 specify an opcode (saying which of the structs are to be sent),
 and a really big switch statement.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
