Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB58g3Yq022057
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 03:42:04 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB58eGvW005700
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 08:40:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Joshua Brindle" <jbrindle@tresys.com>
Subject: Re: User home directory creation with useradd (rhbz#217441)
Date: Tue, 5 Dec 2006 19:42:21 +1100
Cc: "Linda Knippers" <linda.knippers@hp.com>,
        "James Antill" <jantill@redhat.com>, selinux@tycho.nsa.gov
References: <6FE441CD9F0C0C479F2D88F959B015885C822B@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C822B@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612051942.24085.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 03 December 2006 06:29, "Joshua Brindle" <jbrindle@tresys.com> 
wrote:
> > Ok, here's another example.  secadm_r can manage policy but
> > can't 'touch /.autorelabel', only sysadm_r can do that.
>
> This isn't surprising, secadm_r was pretty much an afterthought..

...to the entire design of the Unix OS and to OS design in general.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
