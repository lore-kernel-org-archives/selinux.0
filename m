Date: Fri, 3 Oct 2003 12:19:01 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: "Fleischman, Eric" <eric.w.fleischman@boeing.com>, SELinux@tycho.nsa.gov
Subject: Re: Security Officer and System Administrator Separation of Duties
Message-ID: <20031003121858.H28703@lemuria.org>
References: <5B58696DB20B9140AD20E0685C573A6402992E48@xch-nw-09.nw.nos.boeing.com> <20031003025553.C28424@lemuria.org> <200310031655.06049.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310031655.06049.russell@coker.com.au>; from russell@coker.com.au on Fri, Oct 03, 2003 at 04:55:06PM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 03, 2003 at 04:55:06PM +1000, Russell Coker wrote:
> > What you certainly can do is create a sysadm_r that is limited in the
> > respect you wish, i.e. can not add/edit users or modify the policy.
> 
> To so that we need to have the package management system check package 
> signatures and only install files in types such as fsadm_exec_t if they are 
> from signed packages from the distribution (not local packages).  Then we 
> need to make sure that the administrator does not get write access to any 
> such files (if they can replace fsck then they can get direct file system 
> access and modify /etc/shadow etc).

For starters, I would simply disallow the sysadm_r write access to
these tools. Yes, that means only the secadm_r can update the policy
tools, but I'd consider that a feature, not a bug.



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
