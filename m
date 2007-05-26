Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4Q0B2Uk031029
	for <selinux@tycho.nsa.gov>; Fri, 25 May 2007 20:11:03 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4Q0B1qM002834
	for <selinux@tycho.nsa.gov>; Sat, 26 May 2007 00:11:02 GMT
Subject: RE: [patch 1/3] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Mark Goldman <mgoldman@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BEFF95@exchange.columbia.tresys.com>
References: <20070521095414.832619201@tresys.com>
	 <20070521095518.515998898@tresys.com>
	 <1179868119.9092.38.camel@localhost.localdomain>
	 <1180015458.3930.173.camel@tresys-winxppro>
	 <1180017921.2940.24.camel@localhost.localdomain>
	 <1180034401.3930.203.camel@tresys-winxppro>
	 <1180108369.6331.18.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BEFF95@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 25 May 2007 20:02:29 -0400
Message-Id: <1180137749.10334.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-25 at 13:06 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> >> If you would like to move the list types out of policyrep and into
> >> trunk, I'll be happy to use it.  Otherwise it is out of the scope of
> >> this patch. 
> >> 
> > 
> > Please rebase against the policyrep branch - we can then
> > consider merging the list types and this patch to trunk if
> > desired. I will NACK this patch if it contains the additional list
> > types. 
> 
> There aren't additional list types because there aren't any in trunk.
> This has nothing to do with policyrep and doesn't break ABI
> compatibility and should be in trunk. I hate this idea of pushing
> everything into policyrep because its going to make it that much harder
> to get good testing done and the source of bugs will be harder to track
> down.
> 

Ok.

> If you are so insistent on using the list types in policyrep why not
> port them to trunk so we can use them?

That option is fine with me (and was one of my suggestions), though I
don't have time to do the port right now. Can you or Mark send a patch
pulling over the iterators and list?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
