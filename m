From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "ccallen" <ccallen@windowpane.com>, <SELinux@tycho.nsa.gov>
Subject: Re: update question
Date: Fri, 18 Apr 2003 14:08:55 +1000
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>
In-Reply-To: <00d801c303f1$9fef2f00$398314d1@windowpane.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304181408.55003.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Apr 2003 18:24, ccallen wrote:
> If there is an older version of selinux installed, does the old one need to
> be uninstalled before running the new version? If so is there a file with
> the steps to do this? I thought I had read something on that before, but
> cant find it now.

You don't need to uninstall it.  However upgrades sometimes have changes to 
the file contexts files (*.fc) which mean that you need to relabel part of 
your file system after an upgrade.

The most recent such change was the addition of locale_t which requires that 
all time zone information files and directories be relabelled.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
