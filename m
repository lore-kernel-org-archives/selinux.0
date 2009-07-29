Subject: Re: compiling errors!
From: Stephen Smalley <sds@tycho.nsa.gov>
To: mina elnino <potushka@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <f7d5075c0907290405x4d851cbnaf30980f8fadb308@mail.gmail.com>
References: <f7d5075c0907290405x4d851cbnaf30980f8fadb308@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 29 Jul 2009 07:57:47 -0400
Message-Id: <1248868667.11627.35.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-29 at 15:35 +0430, mina elnino wrote:
> dear list;
> i'd like to make some changes in checkpolicy package according to a
> project in my college. 
> so i clone the git repo and "make install".
> 
> $ git clone http://oss.tresys.com/git/selinux.git
> $ cd selinux
> $ make DESTDIR=~/obj install
> 
> but it makes some errors, which i have attached them (in result file).
> i have to say that my os is fc11 and i have installed "Development
> Libraries".
> i'd be appreciated if you could help me.
> best regards.

You need to install the ustr library headers, by running:
	yum install ustr-devel 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
