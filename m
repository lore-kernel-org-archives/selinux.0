From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "lky" <lky77@sjtu.edu.cn>, "SELINUX" <SELinux@tycho.nsa.gov>
Subject: Re: question about remote login
Date: Sat, 20 Dec 2003 12:01:43 +1100
References: <001e01c3c65f$5849f320$5d38a8c0@lky>
In-Reply-To: <001e01c3c65f$5849f320$5d38a8c0@lky>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312201201.44002.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 20 Dec 2003 05:38, "lky" <lky77@sjtu.edu.cn> wrote:
>     I have installed selinux-2.4.21 on RedHat9.0. Now I want to login my
> machine remotely.But I found I can't login with telnet if SElinux is
> enabled.SElinux don't support telnet?

Telnet is supported, but it appears broken at the moment.  Fixing it is on my 
to-do list.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
