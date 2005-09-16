Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8GGlcNs026897
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2005 12:47:38 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8GGiFvo025604
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2005 16:44:15 GMT
Date: Fri, 16 Sep 2005 14:59:13 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New ideas on implementation on libsetrans.
Message-ID: <20050916135913.GG9092@lkcl.net>
References: <43271BDA.3060403@redhat.com> <43272C09.3050105@trustedcs.com> <43272E92.4060400@redhat.com> <20050913212236.GA540@lkcl.net> <1126699137.12299.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126699137.12299.3.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 14, 2005 at 07:58:57AM -0400, Stephen Smalley wrote:
> On Tue, 2005-09-13 at 22:22 +0100, Luke Kenneth Casson Leighton wrote:
> >  what do the data structures look like?
> > 
> >  tell me they're nice and simple...
> 
> All we are talking about is "here is a raw context string, please give
> me a human-readable one" and vice versa.

 pffh, lots of fuss then :)  ascii it is!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
