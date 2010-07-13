Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6D6fvvU021894
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2010 02:41:59 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6D6f2Ha018359
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2010 06:41:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwintorok@gmail.com>,
        "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: clamav RWX
Date: Tue, 13 Jul 2010 16:41:53 +1000
References: <201007121922.48247.russell@coker.com.au> <1278966414.5221.296.camel@moss-pluto.epoch.ncsc.mil> <20100713092956.32be6466@debian>
In-Reply-To: <20100713092956.32be6466@debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201007131641.54298.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Jul 2010, Török Edwin <edwintorok@gmail.com> wrote:
> If I can change the mapping from RW <-> RX, then the mapping is
> writable only for a brief period (DB reload), so an exploit can't take
> advantage of the RWX mapping (since there is no RWX mapping).
> Thats better than allowing 'execmem' for the entire process, isn't it?

That sounds like a good benefit.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
