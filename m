Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9ACCTwu012142
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 08:12:29 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9ACBmTb013269
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 12:11:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "abcde efghi" <svmdcv@gmail.com>
Subject: Re: nfs mount takes long time on x86 rhel4 u4 with selinux enabled
Date: Tue, 10 Oct 2006 22:12:22 +1000
Cc: selinux@tycho.nsa.gov
References: <6a9b0ede0610100500v4bbe7866v661bb5939446cac2@mail.gmail.com>
In-Reply-To: <6a9b0ede0610100500v4bbe7866v661bb5939446cac2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610102212.24468.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 10 October 2006 22:00, "abcde efghi" <svmdcv@gmail.com> wrote:
> nfs mount takes long time on x86 rhel4 u4 with selinux enabled.
> This happens only with selinux enabled. Without selinx it takes few
> milli-seconds.
> When I installed machine with selinux enabled and selinux enabled
> during run,mount works properly.

The most common cause of delays in NFS mounts is the portmap daemon not 
running on the local machine.

I'm not sure what you mean by "selinux enabled during run".  Did you test by 
booting with SE Linux in enforcing mode, running "time mount ..." 
then "umount ... ; setenforce 0 ; time mount ..."?  (where ... means the 
necessary parameters).

Did you check the audit log?  If you installed U4 then I think auditd will be 
on by default so you have to check /var/log/audit/audit.log otherwise 
run "dmesg" and look for "avc" messages.  If SE Linux is misconfigured then 
you should see some AVC messages.

Last time I was using RHEL4U4 I had no problems with NFS mounting.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
