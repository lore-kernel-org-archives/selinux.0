Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9GA2nsi031365
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 06:02:53 -0400
Received: from bay0-omc1-s26.bay0.hotmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9GA1R8K002092
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 10:01:28 GMT
Message-ID: <BAY114-F24561B9608F2DE62BDD1ACAF090@phx.gbl>
In-Reply-To: <1160939995.22920.3.camel@twoface.columbia.tresys.com>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: jbrindle@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: Re: SE-X
Date: Mon, 16 Oct 2006 12:02:45 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov




>From: Joshua Brindle <jbrindle@tresys.com>
>To: Salvo Giuffrida <giuffsalvo@hotmail.it>
>CC: selinux@tycho.nsa.gov
>Subject: Re: SE-X
>Date: Sun, 15 Oct 2006 15:19:55 -0400
>
>On Sun, 2006-10-15 at 19:26 +0200, Salvo Giuffrida wrote:
> > I saw that in the file "access_vectors", in the policy source directory,
> > there are definitions related to X-Window objects (window, drawable, 
>font,
> > etc...). But, isn't the object manager supposed to handle only "low 
>level"
> > objects, like pipes, sockets, files, etc...?
> > Thank you
>
>Object managers handle whatever kind of objects the app has. For
>example, a database would have row, table, column, etc. X has windows,
>cursors.
>
>The kernel object managers manage low level things like files but
>userspace object managers give us the ability to refine that access to a
>more granular level. For example, SELinux in the kernel can only specify
>access on database files but if the database was an object manager you
>could use policy to specify in a more fine grained way what types can
>access pieces of that file.
>
Where can I find (if they exists) the code of this other userspace object 
managers?
Another thing, please: the interfaces of the .if files (in the sources of 
the policy), are expanded during compilation like the M4 macros of the old 
"example policy"? If so, how is it possible to referer and use them even 
after the compilation of the modules?
Thanks

_________________________________________________________________
Capitan Jack Sparrow ha bisogno del tuo aiuto..prendi il timone della Perla 
Nera! http://www.msnpiratesofthecaribbeangame.com/it/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
