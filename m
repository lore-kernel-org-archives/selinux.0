From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Jian Liu" <gjk.liu@gmail.com>
Subject: Re: how to test ssh_sysadm_login(tunable)
Date: Fri, 1 Dec 2006 21:17:50 +1100
Cc: SELinux@tycho.nsa.gov
References: <8c2dc7030612010133j5709d6b1k72f44e40ed58dbcd@mail.gmail.com>
In-Reply-To: <8c2dc7030612010133j5709d6b1k72f44e40ed58dbcd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200612012117.52567.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 01 December 2006 20:33, "Jian Liu" <gjk.liu@gmail.com> wrote:
> In refpolicy, there is a global tunable named "ssh_sysadm_login". It means
> "Allow ssh logns as sysamd_r:sysadm_t".
> How to use this tunable?
>
> I have tested it on my lab, and find It is always allowed to "newrole -r
> sysadm_r -t sysadm_t" after sshed
> to my test server, not mattering ssh_sysadm_login is on or off on the
> server.

That is the way it's designed.

The boolean in question determines whether you are permitted to ssh directly 
as sysadm_t, not whether you can run newrole after that.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
