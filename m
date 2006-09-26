Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QAftTM011645
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 06:41:56 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8QAfKqH003653
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 10:41:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Latest diffs
Date: Tue, 26 Sep 2006 20:41:45 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <45116881.3060406@redhat.com> <451447EA.70905@redhat.com> <1159210299.3920.218.camel@sgc>
In-Reply-To: <1159210299.3920.218.camel@sgc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609262041.49115.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 26 September 2006 04:51, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> > /dev/rawctl is labeled as a fixed_disk_device_t even though it is a
> > chr_file.  Not sure if this is correct.
>
> According to drivers/char/raw.c:
>
>  * Front-end raw character devices.  These can be bound to any block
>  * devices to provide genuine Unix raw character device semantics.
>  *
>  * We reserve minor number 0 for a control interface.  ioctl()s on this
>  * device are used to bind the other minor numbers to block devices.
>
> So it sounds like we need two types, one for the control device and one
> for raw1, etc.

What is the benefit of having an additional type?

fixed_disk_device_t determines access to fixed disks.  If there is a control 
device that controls fixed disks then surely the same type is appropriate.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
