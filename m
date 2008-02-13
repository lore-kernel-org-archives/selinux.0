Subject: Re: s.m.a.c.k
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30802131140i275195aao25bcac1bba37e51@mail.gmail.com>
References: <dd18b0c30802131140i275195aao25bcac1bba37e51@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 13 Feb 2008 14:49:35 -0500
Message-Id: <1202932175.16038.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-13 at 19:40 +0000, Justin Mattock wrote:
> Hello; When trying out kernel 2.6.25-rc1 everything seems o.k., but
> when compiling the kernel  with the new s.m.a.c.k option I'm receiving
> this error when booting:
> Kernel panic not syncing : smack : unable to register with kernel 
> 

You can't enable both Smack and SELinux simultaneously - there can be
only one ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
