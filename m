From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Removing DAC.
Date: Tue, 25 Mar 2008 15:41:07 +1100
Cc: cinthya aranguren <cinthya.aranguren@gmail.com>, selinux@tycho.nsa.gov
References: <50771f160803230854n18bd2a07q34eb154fc016f351@mail.gmail.com> <1206361241.3302.18.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1206361241.3302.18.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803251541.10453.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 24 March 2008 23:20, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Sun, 2008-03-23 at 12:54 -0300, cinthya aranguren wrote:
> > Hi,
> >
> > Is there any way to avoid o remove DAC controls ? I'd like to have
> > only one security scheme in my system. I mean a pure SElinux system.
> > not DAC + MAC. only MAC.
>
> Not recommended - see prior discussions on this list.
>
> Russell Coker has run SELinux systems with published root password
> before, which approximates the above, but only for demonstration
> purposes - I wouldn't recommend that for production use.

http://www.coker.com.au/selinux/play.html

I still run them now, and I also recommend that people don't do it.  From the 
above URL: Note that such machines require a lot of skill if you are to run 
them successfully. If you have to ask whether you should run one then the 
answer is "no".

In past discussions on this topic people have expressed the desire to avoid 
the overhead of Unix permission checks.  It seems obvious that a basic 
bit-mask check of two integers (Unix permission modes) is not going to incur 
any significant overhead, even when performed for every directory in the 
path.  The memory use of the code to check Unix permissions has never been 
measured (AFAIK) due to no-one getting a system to work without it and 
documenting the results.

I suspect that if someone was to get a Linux kernel to build without Unix 
permissions the majority of interest would not come from people who want SE 
Linux without Unix permissions but from people who want no access control at 
all.  When running an embedded device that only has a single program running 
the benefits for any form of access control are often minute (NB it seems 
that nowadays most embedded devices are complex enough to benefit 
significantly from SE Linux).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
