Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9GBUWce001226
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 07:30:32 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9GBTqrg029347
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 11:29:52 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SE-X
Date: Mon, 16 Oct 2006 07:30:31 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588444549@exchange.columbia.tresys.com>
In-Reply-To: <BAY114-F24561B9608F2DE62BDD1ACAF090@phx.gbl>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Salvo Giuffrida [mailto:giuffsalvo@hotmail.it] 
> >From: Joshua Brindle <jbrindle@tresys.com>
> >To: Salvo Giuffrida <giuffsalvo@hotmail.it>
> >CC: selinux@tycho.nsa.gov
> >Subject: Re: SE-X
> >Date: Sun, 15 Oct 2006 15:19:55 -0400
> >
> >On Sun, 2006-10-15 at 19:26 +0200, Salvo Giuffrida wrote:
> > > I saw that in the file "access_vectors", in the policy source 
> > > directory, there are definitions related to X-Window objects 
> > > (window, drawable,
> >font,
> > > etc...). But, isn't the object manager supposed to handle 
> only "low
> >level"
> > > objects, like pipes, sockets, files, etc...?
> > > Thank you
> >
> >Object managers handle whatever kind of objects the app has. For 
> >example, a database would have row, table, column, etc. X 
> has windows, 
> >cursors.
> >
> >The kernel object managers manage low level things like files but 
> >userspace object managers give us the ability to refine that 
> access to 
> >a more granular level. For example, SELinux in the kernel can only 
> >specify access on database files but if the database was an object 
> >manager you could use policy to specify in a more fine 
> grained way what 
> >types can access pieces of that file.
> >
> Where can I find (if they exists) the code of this other 
> userspace object managers?

Use the source. Find dbus source, X is available in the xorg/server git
tree on freedesktop.org in a branch called XACE-SELINUX. No database
object manager exists as of right now but some are being worked on.

> Another thing, please: the interfaces of the .if files (in 
> the sources of the policy), are expanded during compilation 
> like the M4 macros of the old "example policy"? If so, how is 
> it possible to referer and use them even after the 
> compilation of the modules?
> Thanks

It isn't. they are installed to /usr/share/selinux/devel so that you can
build out-of-tree refpolicy modules but the compiled modules do not use
interfaces currenly.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
