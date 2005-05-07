From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: [Fwd: Latest Diff]
Date: Sat, 7 May 2005 23:50:59 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
References: <427A757F.9040009@redhat.com> <1115344683.15149.11.camel@localhost.localdomain> <1115393991.17301.18.camel@localhost.localdomain>
In-Reply-To: <1115393991.17301.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505072351.04728.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 07 May 2005 01:39, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > ...but orbit-$USER needs to be labeled properly, and it can be created
> > by anything that interfaces w/ libORBit-2, I think...which means
> > that either it has to be created by a startup script, or
> > the library should be modified to use matchpathcon()
> > when it creates the folder. I don't know which.
> > I also thought perhaps there should be a skeleton for /tmp
> > (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=156452)
> > but I'm now starting to think that's may be a bad idea, and I should
> > close the bug.
>
> ...and does tmpwatch need to be allowed to erase those folders?
> If so, startup script is not an option... because right now tmpwatch
> goes and tries to erase all of this..

Every type that is used by default for objects created under /tmp should be 
removable by tmpwatch.  Types such as user_home_t should not be removable by 
tmpwatch as this is the entire aim of the tmpwatch policy.

This means of course that a user who desires it can avoid having their files 
removed by giving them a type that tmpwatch can't remove.  This is not such a 
bad thing IMHO, tmpwatch is not designed as part of the security system, and 
SE Linux is not designed to deal with resource allocation issues.

One possibility would be to allow tmpwatch to go through user (not sysadm) 
home directories but not have search access to home_root_t.  But this makes 
the protection of user home directories from tmpwatch dependant on the label 
of home_root_t, I'm not certain that in all cases of automounting and strange 
configuration of home directories we can rely on the label of home_root_t 
being assigned to /home to protect sub-directories.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
