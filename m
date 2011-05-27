Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4RMjRnI018364
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2011 18:45:27 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4RMjP2B013162
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2011 22:45:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>,
        selinux@tycho.nsa.gov
Subject: Re: Regarding SELinux User mapping
Date: Sat, 28 May 2011 08:45:15 +1000
References: <BANLkTikr=mJPfq5FJUkL9=s5e4Xn6+WMsw@mail.gmail.com> <1306501267.4346.25.camel@localhost.localdomain> <BANLkTik7AS=9J4gXUpORehuEAJxYcizQXA@mail.gmail.com>
In-Reply-To: <BANLkTik7AS=9J4gXUpORehuEAJxYcizQXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201105280845.15665.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 27 May 2011, "c.r.madhusudhanan@gmail.com" 
<c.r.madhusudhanan@gmail.com> wrote:
> Thanks for the quick response. Meego doesnt use pam_selinux by default.
> 
> I will try to enable the pam_selinux support, and let you know the result.
> Thanks for the help.

In the early days we had SE Linux patches for all login programs, pam_selinux 
is a more recent development.  You should be able to find the old login 
patches somewhere, although given the evolution of APIs it might be better to 
take the pam_selinux code and develop your own login patch.

PAM isn't required for SE Linux support (or anything really), it's just a lot 
easier in most cases.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
