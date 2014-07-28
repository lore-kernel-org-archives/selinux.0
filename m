Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6SBSqB8028337
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 07:28:52 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so7150346wgh.35
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 04:28:52 -0700 (PDT)
Message-ID: <1406546929.1346.5.camel@x220.localdomain>
Subject: Re: do user space object managers really provide mandatory access
 control
From: Dominick Grift <dominick.grift@gmail.com>
To: Andy Warner <warner@rubix.com>
Date: Mon, 28 Jul 2014 13:28:49 +0200
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

> >Thank you. I should rephrase "if one defines" to "when one defines"
> 
> I would refute a definition of MAC that restricted it to the OS kernel. But if you did, then obviously you would definition exclude the possibility that MAC could exist outside the kernel, which makes your original questions seem moot. If you presume any MAC implementation is compromised, in user space or kernel, then obviously you have a problem. I do not think it is valid to assume that because something is in "user space" that it is easily compromised, though I understand that OS-centric viewpoint.

Thank you (and Joshua)

I think i got it now. I was not so much referring to the kernel itself
for the sake of the kernel but it just happens to be the core.

I suppose the take-away for  me is:

SELinux is by definition centralized governance, but not centralized
enforcement. (the latter in part due to practical limitations)

Better this than nothing
