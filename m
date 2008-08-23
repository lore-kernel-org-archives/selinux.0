Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7N1olam032364
	for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2008 21:50:47 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7N1oJCd021709
	for <selinux@tycho.nsa.gov>; Sat, 23 Aug 2008 01:50:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Subject: Re: PAM security transitions
Date: Sat, 23 Aug 2008 11:50:35 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <48AF21C3.9020506@windriver.com>
In-Reply-To: <48AF21C3.9020506@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808231150.37055.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 23 August 2008 06:29, Vikram Ambrose 
<Vikram.Ambrose@windriver.com> wrote:
> I've been messing around with various modules and installations and I've
> come across a strange PAM problem. Without any SELinux support in
> pam.d/login, root's shell gets system_r:local_login_t

Yes, ages ago it was decided not to maintain patches for the various terminal 
login programs and to instead use a PAM module.

> But then using: pam_selinux.so close/open, root's shell gets
> root:staff_r:system_chkpwd_t

I think that was a policy bug, it's fixed if you use all the latest versions.

What version of the policy is running on the machines in question?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
