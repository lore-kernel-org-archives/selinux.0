Message-ID: <1405350649.661.43.camel@x220.localdomain>
Subject: Re: Showing port Labels
From: Dominick Grift <dominick.grift@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Date: Mon, 14 Jul 2014 17:10:49 +0200
In-Reply-To: <53C3EE48.6050704@tresys.com>
References: <53C37D83.9050705@davequigley.com>
 <1405329902.661.30.camel@x220.localdomain> <53C3D401.6030207@tycho.nsa.gov>
 <1405344305.661.33.camel@x220.localdomain> <53C3EE48.6050704@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2014-07-14 at 10:50 -0400, Christopher J. PeBenito wrote:
< snip >
> > 
> > Yes, but i prefer minimal/small (and preferably no interpreters):
> > 
> > # file /usr/bin/seinfo
> > /usr/bin/seinfo: ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
> > dynamically linked (uses shared libs), for GNU/Linux 2.6.32,
> > BuildID[sha1]=04ae4e364753b502f227216e548e1ccbf0f33e14, stripped
> > 
> > # file /usr/bin/sepolicy
> > /usr/bin/sepolicy: Python script, ASCII text executable, with very long
> > lines
> 
> sepolicy is using libapol from setools, so its not really different than
> seinfo, other than using a Python frontend.  Since SETools 4 is Python,
> you'll eventually be running low on choices if you're trying to stick to
> only C tools :)
> 

Ah, my bait works :D

Yes i know, and i am not really happy with those developments, but then
again it is just a preference.

In case i really need minimal i can hopefully stick to setools3. It has
all the functionality i require.
