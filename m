Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6SC1aNd030723
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 08:01:36 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so4252675wib.16
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 05:01:38 -0700 (PDT)
Message-ID: <1406548891.1346.12.camel@x220.localdomain>
Subject: Re: do user space object managers really provide mandatory access
 control
From: Dominick Grift <dominick.grift@gmail.com>
To: Andy Warner <warner@rubix.com>
Date: Mon, 28 Jul 2014 14:01:31 +0200
In-Reply-To: <001f01cfaa54$22054820$660fd860$@rubix.com>
References: <1406536400.32528.7.camel@x220.localdomain>
 <001701cfaa44$3b3857c0$b1a90740$@rubix.com>
 <1406544263.850.11.camel@x220.localdomain>
 <001f01cfaa54$22054820$660fd860$@rubix.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: 'selinux' <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2014-07-28 at 13:07 +0200, Andy Warner wrote:

> 
> I would refute a definition of MAC that restricted it to the OS kernel. But if you did, then obviously you would definition exclude the possibility that MAC could exist outside the kernel, which makes your original questions seem moot. If you presume any MAC implementation is compromised, in user space or kernel, then obviously you have a problem. I do not think it is valid to assume that because something is in "user space" that it is easily compromised, though I understand that OS-centric viewpoint.

In my defense: I am not implying that user space is more easily
compromised than the kernel. I was just hoping for a single point of
failure when it comes to enforcement.

I made a mistake by associating "MAC" with "centralized".

although SELinux is a "MAC" system that facilitates centralized
governance (but unfortunately not always centralized enforcement), this
does not mean that this is also a property of "MAC".
