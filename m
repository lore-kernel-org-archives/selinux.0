Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AF7Klr018555
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 11:07:20 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AF6dTb006069
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 15:06:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "abcde efghi" <svmdcv@gmail.com>
Subject: Re: nfs mount takes long time on x86 rhel4 u4 with selinux enabled
Date: Wed, 11 Oct 2006 01:07:14 +1000
Cc: selinux@tycho.nsa.gov
References: <6a9b0ede0610100500v4bbe7866v661bb5939446cac2@mail.gmail.com> <6a9b0ede0610100735h1a92f4c3i890391f8a0b0238e@mail.gmail.com>
In-Reply-To: <6a9b0ede0610100735h1a92f4c3i890391f8a0b0238e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610110107.16261.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 11 October 2006 00:35, "abcde efghi" <svmdcv@gmail.com> wrote:
> during installation time it was disabled
> and during boottime i enabled it
> (.i.e by setting selinux=enforcing in /etc/selinux/config and reboot)

Before that reboot did you touch /.autorelabel?

> that time it is taking some time to mount
> what could be the pbm? is it really bcoz of portmap daemon?
> how does portmap daemon cause this pbm? any pointers?

If it's portmap then it's not an SE Linux issue and is best discussed on 
another list.

> note the time and call trace details:
>
> time mount <server:/disk/disk1/data1/ /mnt --type nfs
> -orw,bg,nointr,hard,timeo=600,wsize=32768,rsize=32768,nfsvers=3,tcp,actimeo
>=0, addr=10.0.0.60

You did not provide any information on AVC messages or the time taken for the 
mount command when SE Linux is in permissive mode (after running
"setenforce 0").  Without such information we can't help you.  You need to 
answer every question in my messages if you want useful answers from us.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
