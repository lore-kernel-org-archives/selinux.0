Message-ID: <BAY114-F34E0DD0E16D47D3F3E464AAF180@phx.gbl>
In-Reply-To: <BAY114-F38B57DECF2A6270738CF26AF180@phx.gbl>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
Subject: Re: Where is the AVC?
Date: Fri, 29 Sep 2006 19:56:58 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



>From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
>To: sds@tycho.nsa.gov
>CC: selinux@tycho.nsa.gov
>Subject: Re: Where is the AVC?
>Date: Fri, 29 Sep 2006 19:34:06 +0200
>
>If you look at figure 3-2 (if you want, I can send to you), the AVC is 
>designed in kernel-space, whereas the object manager is in userspace. So, 
>if the AVC is managed by the object manager, shouldn't it be in userspace?
OK, my fault...the AVC is in kernel space, because even the object manager 
is in kernel space (at least on Linux). But from the figure it still looks 
like the AVC is part of the S.S., not of the Object Manager...However, if 
the paper says that the AVC is part of the Object Manager (which is the case 
of user-space ones - Look figure 3.3), I say so ;-).
I guess it's just a confusion regarding to the images of the book...

_________________________________________________________________
Ricerche online più semplici e veloci con MSN Toolbar! 
http://toolbar.msn.it/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
