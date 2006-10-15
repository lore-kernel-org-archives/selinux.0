Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9FJKUvj013810
	for <selinux@tycho.nsa.gov>; Sun, 15 Oct 2006 15:20:30 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9FJJooC016454
	for <selinux@tycho.nsa.gov>; Sun, 15 Oct 2006 19:19:50 GMT
Subject: Re: SE-X
From: Joshua Brindle <jbrindle@tresys.com>
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F3801609CA21A2880CB0C27AF080@phx.gbl>
References: <BAY114-F3801609CA21A2880CB0C27AF080@phx.gbl>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 15:19:55 -0400
Message-Id: <1160939995.22920.3.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-10-15 at 19:26 +0200, Salvo Giuffrida wrote:
> I saw that in the file "access_vectors", in the policy source directory, 
> there are definitions related to X-Window objects (window, drawable, font, 
> etc...). But, isn't the object manager supposed to handle only "low level" 
> objects, like pipes, sockets, files, etc...?
> Thank you

Object managers handle whatever kind of objects the app has. For
example, a database would have row, table, column, etc. X has windows,
cursors. 

The kernel object managers manage low level things like files but
userspace object managers give us the ability to refine that access to a
more granular level. For example, SELinux in the kernel can only specify
access on database files but if the database was an object manager you
could use policy to specify in a more fine grained way what types can
access pieces of that file.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
