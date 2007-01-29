Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TCQSU3007203
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 07:26:29 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TCRHxX018955
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 12:27:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 5/8] busybox -- libselinux utilities applets
Date: Mon, 29 Jan 2007 23:28:33 +1100
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, busybox@busybox.net,
        selinux@tycho.nsa.gov, rob@landley.net, dwalsh@redhat.com,
        busybox@kaigai.gr.jp
References: <45B8C039.10907@kaigai.gr.jp> <45B8C25C.6090705@kaigai.gr.jp> <1169842227.25290.8.camel@sgc.columbia.tresys.com>
In-Reply-To: <1169842227.25290.8.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200701292328.37290.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 27 January 2007 07:10, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> On Thu, 2007-01-25 at 23:44 +0900, KaiGai Kohei wrote:
> > [5/8] busybox-libselinux-05-avcstat.patch
> >   avcstat reports SELinux AVC(Access Vector Cache) statistics.
> >   AVC is a in-kernel data structure to accelerate SELinux's
> >   decision making.
>
> Are you sure this should be added?  It doesn't seem like it would be
> used much.  I don't think most people are even aware that you can get
> stats on the AVC, much less know what to do with them.

I agree.  avcstat is used only rarely and only in development.  I don't think 
that it's something we need in production on an iPaQ, for system recovery, or 
in an initramfs - therefore I think it's something that isn't needed in 
busybox.

As for togglesebool, should such a thing even exist?  Before we had setenforce 
we had avc_toggle which was very similar to togglesebool - and it was 
generally regarded that avc_toggle should not exist.

Good work on the busybox development KaiGai, it's something that needed to be 
done for a while.  But I think you were a little over-enthusiastic in regard 
to those two commands.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
