From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jsingh@ensim.com
Subject: Re: avc: denied with kernel module
Date: Wed, 3 Nov 2004 03:17:15 +1100
Cc: nsa <SELinux@tycho.nsa.gov>
References: <1099347144.9776.3.camel@jsingh>
In-Reply-To: <1099347144.9776.3.camel@jsingh>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411030317.15713.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Nov 2004 09:12, Jaspreet Singh <jsingh@ensim.com> wrote:
> I am using a overlay-fs module .. and tried setting security context on
> files and got this message ....

What is the entry in /proc/filesystems for that file system?

>  avc:  denied  { associate } for  pid=1530 exe=/usr/sbin/setfiles
> name=public_html dev=overlay_fs ino=42
> scontext=site1-admin:object_r:httpd_site1_content_t
> tcontext=system_u:object_r:unlabeled_t tclass=filesystem

Your problem is that the filesystem has type unlabeled_t.

Does this overlay-fs support xattrs?  If so then something like the following 
in the policy should work:

fs_use_xattr XXX system_u:object_r:fs_t;

Replace XXX with the file system name from /proc/filesystems.


PS  audit2allow generates really bad policy if you use it without 
understanding the policy.  Any time you use audit2allow because you don't 
understand what else to do the result will probably be wrong.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
