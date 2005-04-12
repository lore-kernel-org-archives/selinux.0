From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: inode_doinit_with_dentry messages
Date: Wed, 13 Apr 2005 04:01:25 +1000
Cc: James Morris <jmorris@redhat.com>, SELinux@tycho.nsa.gov
References: <Xine.LNX.4.44.0504121252030.17231-100000@thoron.boston.redhat.com> <1113325464.25217.142.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1113325464.25217.142.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504130401.29883.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 13 April 2005 03:04, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> I don't think we want to create a special case just for this particular
> error message, or pollute selinuxfs with individual toggles for each
> such case.  Possibly we could convert many of the error messages in
> hooks.c and ss/*.c to using audit_log instead of printk, then set up
> filtering in auditd.

Sounds reasonable.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
