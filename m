Message-ID: <1405344305.661.33.camel@x220.localdomain>
Subject: Re: Showing port Labels
From: Dominick Grift <dominick.grift@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon, 14 Jul 2014 15:25:05 +0200
In-Reply-To: <53C3D401.6030207@tycho.nsa.gov>
References: <53C37D83.9050705@davequigley.com>
 <1405329902.661.30.camel@x220.localdomain> <53C3D401.6030207@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2014-07-14 at 08:58 -0400, Stephen Smalley wrote:
< snip >

> > It is probably not the answer you were looking for but i suppose I would
> > use seinfo --portcon
> 
> sepolicy network -p <portnumber>
> 
> 

Yes, but i prefer minimal/small (and preferably no interpreters):

# file /usr/bin/seinfo
/usr/bin/seinfo: ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
dynamically linked (uses shared libs), for GNU/Linux 2.6.32,
BuildID[sha1]=04ae4e364753b502f227216e548e1ccbf0f33e14, stripped

# file /usr/bin/sepolicy
/usr/bin/sepolicy: Python script, ASCII text executable, with very long
lines
