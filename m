Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBFIXu79028229
 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2014 13:33:56 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so19048803obc.7
 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2014 10:33:54 -0800 (PST)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <548EFA51.2060505@tresys.com>
References: <5480B2DB.6010408@tresys.com>
 <CAPzO=Ny_kUT2drj3KzW_uhLLpeOqxPJtOa5R46PGa5bhCT92Eg@mail.gmail.com>
 <20141214160431.GA28896@meriadoc.Home>
 <548EFA51.2060505@tresys.com>
Date: Mon, 15 Dec 2014 19:33:54 +0100
Message-ID: <CAPzO=NyFxyTks+BX27-cwbJn7DG4+U+LffS_ktEmT42+wnk5QQ@mail.gmail.com>
Subject: Re: ANN: SELinux Userspace Release: 20140826-rc7
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Steve Lawrence <slawrence@tresys.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 15, 2014 at 4:12 PM, Steve Lawrence <slawrence@tresys.com> wrote:
> Both good suggestions. I agree that it can be difficult to track down
> issues. CIL diagnostics have plenty of room for improvement.
>
> One thing that may help, if you were not already aware, you can always
> compile the pp file to CIL yourself with something like this:
>
> $ cat /var/lib/selinux/.../hll | bunzip2 | /usr/libexec/selinux/hll/pp
>
> It's not perfect, but should allow you to view the generated CIL and
> figure out where the error is to help track things down.
>
> With all that said, I'm not sure this a blocker, and is something we'll
> target to improve in the next SELinux Userspace release.

Ah yes, using the /usr/libexec/selinux/hll/pp application to generate
the CIL is a big help, thanks.

It is indeed not blocking.

Wkr,
  Sven Vermeulen
