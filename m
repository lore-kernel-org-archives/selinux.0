To: SELinux@tycho.nsa.gov
From: Per Nystrom <pnystrom@netmagic.net>
Subject: Re: file access causes a kernel bug
Date: Tue, 4 Feb 2014 03:41:19 +0000 (UTC)
Message-ID: <loom.20140204T043909-924@post.gmane.org>
References: <52E8B5F8.2070005@mthode.org> <2218414.0HDc6YTzKt@sifl>
 <52EA8D4D.5080707@mthode.org> <1897429.yoaRn36u2g@sifl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul Moore <paul@...> writes:

> 
> On Thursday, January 30, 2014 11:35:09 AM Matthew Thode wrote:
> > On 01/30/2014 11:19 AM, Paul Moore wrote:
> > > On Thursday, January 30, 2014 11:07:30 AM Matthew Thode wrote:
> > >> On 01/30/2014 10:41 AM, Stephen Smalley wrote:
> > >>> Try the attached patch.
> > >> 
> > >> Confirmed that this fixes it :D thanks a ton for this.
> > > 
> > > Queued up in my stable branch, I'll send a pull request to James once -rc1
> > > is released.
> > > 
> > > Thanks guys.
> > 
> > Any chance for backport to 3.13?
> 
> It will go off to the stable list and ultimately it will be up to the stable 
> kernel maintainers.  However, considering the size and nature of the patch I 
> see no reason why it would not be applied to a 3.13.X release in the future.
> 

Confirming this patch works in kernel 3.12 on Fedora 20.  And THANK YOU!

[root@localhost ~]# uname -a
Linux localhost.localdomain 3.12.8-300.local.fc20.x86_64 #1 SMP Sun Feb 2
09:39:43 PST 2014 x86_64 x86_64 x86_64 GNU/Linux
[root@localhost ~]# cat /etc/redhat-release 
Fedora release 20 (Heisenbug)
