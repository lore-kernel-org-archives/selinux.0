Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5DHNJjq000717
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 13:23:19 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5DHNICb021411
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 17:23:19 GMT
Received: by ug-out-1314.google.com with SMTP id y2so2870028uge
        for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 10:23:18 -0700 (PDT)
From: "Mario Fanelli" <mario.fanelli@gmail.com>
To: "SeLinux Mailing List" <selinux@tycho.nsa.gov>
Subject: I: PaX and SELinux
Date: Tue, 13 Jun 2006 19:23:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <448ef485.50f63546.6c5f.ffff8421@mx.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
>
> -----Messaggio originale-----
> Da: Joshua Brindle [mailto:method@gentoo.org] 
> Inviato: Tuesday, June 13, 2006 5:28 PM
> A: Mario Fanelli
> Cc: SeLinux Mailing List
> Oggetto: Re: PaX and SELinux
>
> Mario Fanelli wrote:
> > I found a PaX security class in refpolicy but I have a little doubt..If
I
> > compile a kernel with SELinux, at the same time the kernel has installed
PaX
> > system (pax.grsecurity.net)? 
> > So I can set pax flag using this security class?
> >   
> This object class was used to control pax options before other memory 
> protections were available to SELinux. The patch hasn't been used or 
> available for quite some time so the object class is more or less 
> deprecated.
>
> However, if you have pax enabled on the system the SELinux memory 
> permissions (execstack, execmem, etc) should be enforced by pax. Address 
> space randomization and other pax options aren't available in policy 
> anymore though.
>
> Joshua

Where can I find anything about SELinux memory protection? Can I install PaX
as patch without problem?

Mario


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
