Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8GC69Cr024670
	for <selinux@tycho.nsa.gov>; Sat, 16 Sep 2006 08:06:10 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8GC5ddN026349
	for <selinux@tycho.nsa.gov>; Sat, 16 Sep 2006 12:05:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux770@tortenboxer.de
Subject: Re: Cannot find your entry in the shadow passwd file
Date: Sat, 16 Sep 2006 22:06:08 +1000
Cc: selinux@tycho.nsa.gov
References: <20060914172151.119780@gmx.net>
In-Reply-To: <20060914172151.119780@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609162206.10419.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 15 September 2006 03:21, selinux770@tortenboxer.de wrote:
> i've got a strange problem. I created a new user on my system which is
> not able to switch between different roles. Looks like this:
>
> ~ $ id -Z
> setester:user_r:user_t
> ~ $ newrole -r staff_r
> Authenticating setester.
> Cannot find your entry in the shadow passwd file.
> ~ $
>
> This happens to all users except root:

Is the newrole program setuid?

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
