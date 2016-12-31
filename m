Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBV3ip9a014141
 for <selinux@tycho.nsa.gov>; Fri, 30 Dec 2016 22:44:51 -0500
Subject: Re: Another getcon() vs getcon_raw() issue in systemd
To: Stephen Smalley <stephen.smalley@gmail.com>
References: <4028608.pKKk40ccRB@russell.coker.com.au>
 <7415401.n4TOyH4plo@russell.coker.com.au>
 <CAJfZ7=nLMJdwfYRCuPR5LssYHXp2SZ00cPk9RxKa=e_3EsHLNQ@mail.gmail.com>
 <70625685.47kgmqZV44@russell.coker.com.au>
 <CAB9W1A2bzpKEWEzpxqou=cWnvWkURxQVSjPDyVe3EBB0B8NA0w@mail.gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <db1e5526-2cb1-011e-9d0f-90a7d8f0adc5@debian.org>
Date: Sat, 31 Dec 2016 04:44:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAB9W1A2bzpKEWEzpxqou=cWnvWkURxQVSjPDyVe3EBB0B8NA0w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 30/12/16 à 18:43, Stephen Smalley a écrit :
> Fedora no longer runs mcstransd by default, so that may also be 
> relevant.  Dbusd should likely provide the raw context to clients so 
> that they are free to use either the raw or translated interfaces 
> without difficulty.
Hi,

FTR, I've open https://bugs.freedesktop.org/show_bug.cgi?id=99234
