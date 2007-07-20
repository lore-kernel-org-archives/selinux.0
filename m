Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KLvUex029688
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 17:57:30 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6KLvTKP029652
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 21:57:29 GMT
Received: by py-out-1112.google.com with SMTP id d32so2242585pye
        for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 14:57:29 -0700 (PDT)
Message-ID: <25a1d91b0707201457m6865a505maf93d22c5c28f0cc@mail.gmail.com>
Date: Fri, 20 Jul 2007 17:57:29 -0400
From: "David Windsor" <dwindsor@gmail.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
Cc: "James Morris" <jmorris@namei.org>,
        kvm-devel <kvm-devel@lists.sourceforge.net>,
        "David Windsor" <dwindsor@tresys.com>,
        "Joshua Brindle" <jbrindle@tresys.com>,
        selinux <selinux@tycho.nsa.gov>, qemu-devel <qemu-devel@nongnu.org>
In-Reply-To: <Line.LNX.4.64.0707201628150.9702@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <C2C68600.366D%dwindsor@tresys.com>
	 <20070720201101.GC12218@redhat.com>
	 <Line.LNX.4.64.0707201628150.9702@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/20/07, James Morris <jmorris@namei.org> wrote:
> On Fri, 20 Jul 2007, Daniel P. Berrange wrote:
>
> > It could be - if your put the policy at the control API layer instead of
> > in QEMU itself.
>
I think that libvirt may be a bit too high in the virtualization stack
for this control.
What benefits are there for placing such a hook in libvirt vs qemu?
libvirt could still use the vm:entrypoint permission for other types
of VMs it manages.

> Then you can bypass MAC security by invoking qemu directly.
>
>
> - James
> --
> James Morris
> <jmorris@namei.org>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> kvm-devel mailing list
> kvm-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
