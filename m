Subject: Re: how to compile checkpolicy package
From: Stephen Smalley <sds@tycho.nsa.gov>
To: mina elnino <potushka@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <f7d5075c0907250535p30e95899xa11fb04e77e6ecdf@mail.gmail.com>
References: <f7d5075c0907250535p30e95899xa11fb04e77e6ecdf@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 09:06:41 -0400
Message-Id: <1248700001.3465.36.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2009-07-25 at 17:05 +0430, mina elnino wrote:
> dear list,
> i'd like to make some changes in checkpolicy package according to a
> project in my college. i've downloaded the sources packages from
> userspace development. all other packages have Makefile to install
> them, but checkpolicy doesnt. so i dont know what to do exactly.
> compiling checkpolicy makes some errors. maybe i should link it with
> something else. and what about lex/yacc files. what should i do with
> them. i just want a binary file of checkpolicy to compile
> "policy.conf". thnx for your help!
> best regards.

I don't quite understand - checkpolicy has a Makefile.
It is true that you have to first build and install libsepol before you
can build checkpolicy.

You might want to use the git repo,
git clone http://oss.tresys.com/git/selinux.git

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
