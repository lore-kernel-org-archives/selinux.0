Subject: Re: sepcut is broken
From: Karl MacMillan <kmacmillan@tresys.com>
To: Mark Shakespeare <mshakes@llnl.gov>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <p0602040cbc34b0d29bb3@[128.115.96.64]>
References: <p0602040cbc34b0d29bb3@[128.115.96.64]>
Content-Type: text/plain
Message-Id: <1074789931.27824.87.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 22 Jan 2004 11:45:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-21 at 17:55, Mark Shakespeare wrote:
> Just did a fresh install of Fedora core 1, and then ran Dan Walsh's
> selUpgrade script.
> 
> Had a few conflicts to deal with....mostly glibc 2.3.3, tk 8.4,tcl 8.4
> and db4.2.52
> 
> Resolved conflicts...ran script again and it went ok.
> 
> Had to install bwidget manually.
> 

Why did you have to install it manually? Also, are you using Dan's
packages for setools or ours?

> Now sepcut is broken...error:page"pct_Test:text" does not exist...
> 

We're looking into this, but at first glance it looks like there might
be something wrong with your installation. Can you download our source
and try that:

http://www.tresys.com/selinux/selinux_policy_tools.html

If you are using tcl 8.4 you might have to change the top level makefile
- just change the TCLVER variable at the top to 8.4.

> There were many duplicate .te files in the
> /etc/security/selinux/src/policy/domains/program and unused....which
> were resolved.
> 

Dan and Russell - I noticed this as well. Is this duplication
intentional? This breaks the convention, on which sepcut depends, that a
.te file is either in programs or unused but not both.. We are making
sepcut handle this situation more gracefully, but I would like to see
this convention retained.

> seaudit works fine...so does apol and seuserx
> 

Great.

Karl

> Any help would be appreciated.
> 
> Thanks.
> -- 
> ******************************************
> * Mark Shakespeare                   *
> * Engineering Computer Operations Team   *
> * Lawrence Livermore National Laboratory *
> * 7000 East Ave         L-130            *
> * Livermore,Ca 94550                 *
> * 925-423-9922             mshakes@llnl.gov   *
> ******************************************
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
