From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>
Subject: Re: Security Officer and System Administrator Separation of Duties
Date: Fri, 3 Oct 2003 21:32:33 +1000
Cc: "Fleischman, Eric" <eric.w.fleischman@boeing.com>, SELinux@tycho.nsa.gov
References: <5B58696DB20B9140AD20E0685C573A6402992E48@xch-nw-09.nw.nos.boeing.com> <200310031655.06049.russell@coker.com.au> <20031003121858.H28703@lemuria.org>
In-Reply-To: <20031003121858.H28703@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310032132.33691.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 3 Oct 2003 20:19, Tom wrote:
> On Fri, Oct 03, 2003 at 04:55:06PM +1000, Russell Coker wrote:
> > To so that we need to have the package management system check package
> > signatures and only install files in types such as fsadm_exec_t if they
> > are from signed packages from the distribution (not local packages). 
> > Then we need to make sure that the administrator does not get write
> > access to any such files (if they can replace fsck then they can get
> > direct file system access and modify /etc/shadow etc).
>
> For starters, I would simply disallow the sysadm_r write access to
> these tools. Yes, that means only the secadm_r can update the policy
> tools, but I'd consider that a feature, not a bug.

I think that perhaps you misunderstood my message.  My point is that anyone 
who can write to programs such as fsck and run them in their usual context 
can trivially bypass any other security restrictions.

Upgrading fsck if necessary is an occasional job for the administrator, 
running it is a regular chore.

If you use policy to enforce a split of duties between sys-admin and security 
admin then it will be somewhat difficult, and there will be times when a user 
needs a set of access rights greater than the sum of sys-admin and security 
admin is required.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
