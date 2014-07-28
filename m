Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6SAiOsj025574
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 06:44:24 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so7193394wes.3
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 03:44:25 -0700 (PDT)
Message-ID: <1406544263.850.11.camel@x220.localdomain>
Subject: Re: do user space object managers really provide mandatory access
 control
From: Dominick Grift <dominick.grift@gmail.com>
To: Andy Warner <warner@rubix.com>
Date: Mon, 28 Jul 2014 12:44:23 +0200
In-Reply-To: <001701cfaa44$3b3857c0$b1a90740$@rubix.com>
References: <1406536400.32528.7.camel@x220.localdomain>
 <001701cfaa44$3b3857c0$b1a90740$@rubix.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: 'selinux' <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2014-07-28 at 11:13 +0200, Andy Warner wrote:
> MAC is usually defined as not being discretionary (it is mandatory). That
> is, the enforcement of the policy is not at the discretion of a user or
> owner. In my experience it is not defined as "being enforced by the kernel."
> Generally MAC also implies (and sometimes demands) implementation principles
> like encapsulation and non-bypassibility, which a kernel based
> implementation might satisfy, but it is not a requirement of MAC to be
> implemented in the kernel.
> 

Thank you. I should rephrase "if one defines" to "when one defines"

I wonder whether the SELinux object manager related code implements any
meaningful implementation principles like encapsulation,
non-bypassibility, or others.

> I work in MAC based DBMS's which from your perspective could just be
> considered an application layer, but it is implementing real MAC.  One
> reason it cannot be totally implemented in the kernel is that the MAC is
> arbitrating access to non-OS objects, such as database rows, tables, etc.
> The DBMS can cooperate with the kernel and use the kernel for MAC based
> decisions (if the MAC policy objectives are the same) but it cannot be
> totally implemented in the kernel. At least, not without lots of tricky
> theoretical work, which was my research topic years ago in grad school.
> Enforcement of the policy is a key difficult issue. 

Depending on the answer to my question above that might beg the question
then: why not implement a security server, and cache in the user space
object manager itself. Although i think i know the answer to that
question in advance: to facilitate centralized government of the policy
rather than having that scattered all over.

All-in-all it sound like a lot of compromise.

What, other than providing a central place of governance, would be the
benefits of SELinux user space object managers, over any other "MAC"
solutions implemented solely in the user space c.q. application layer?
