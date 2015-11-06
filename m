Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6HpQEc025992
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 12:51:27 -0500
Received: by obdgf3 with SMTP id gf3so97948209obd.3
 for <selinux@tycho.nsa.gov>; Fri, 06 Nov 2015 09:51:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151106162635.GA10239@x250>
References: <1852496.Nbh2u1K4Uk@sifl>
	<20151106162635.GA10239@x250>
Date: Fri, 6 Nov 2015 09:51:08 -0800
Message-ID: <CABXk95Ae+pBH0LaQ+93N5mD7GDfPaAJNEQR4qo3VxX+SnFC07g@mail.gmail.com>
Subject: Re: New SELinux userspace release supporting extended ioctl
 permissions?
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Paul Moore <pmoore@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> Applying ioctl whitelisting on GNU/Linux systems looks to me pretty hard
> to do though. Many drivers, and their ioctls to support.

Agreed.

On Android we use ioctl whitelisting only in a targeted manner. I
think the same approach could (should) be applied to GNU/Linux.

The example that went out in the M release focused on restricting the
leakage of privacy sensitive information from socket ioctls. Apps are
blocked from using socket ioctls to access the wifi MAC address, wifi
SSID and layer 2 encryption protocol. I could see a similar policy
applied to the GNU/Linux browser. Ioctl policies on GPU access also
seem practical albeit device specific.

Constructing a comprehensive list of ioctls and the
source/target/class sets that require access does not strike me as
practical. In many cases these ioctls are already properly restricted
via the ioctl permission.
