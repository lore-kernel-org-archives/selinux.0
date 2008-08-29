Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7TNNOim031697
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 19:23:24 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7TNNLds025169
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 23:23:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Hong <kindloaf@gmail.com>
Subject: Re: About SELinux in Ubuntu
Date: Sat, 30 Aug 2008 09:23:09 +1000
Cc: "SELinux Mailing List" <selinux@tycho.nsa.gov>
References: <f00ed96d0808281244x34aa8999y7add418d78687e7@mail.gmail.com> <1220015196.5708.276.camel@moss-spartans.epoch.ncsc.mil> <f00ed96d0808291359n2e3a81eo5391ec2e4bb45c68@mail.gmail.com>
In-Reply-To: <f00ed96d0808291359n2e3a81eo5391ec2e4bb45c68@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808300923.11405.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 30 August 2008 06:59, Hong <kindloaf@gmail.com> wrote:
> I used ubuntu live CD and found nothing in /var/log/message.  (there is no
> single entry since last boot) And if I disable SELinux by turning off the
> kernel option, it can boot.
> Is there any clue how to solve this problem?

Put "enforcing=0" on the kernel command line and then review the kernel 
message logs (or /var/log/audit/audit.log if you have auditd installed).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
