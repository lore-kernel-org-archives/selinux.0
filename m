From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Joshua Brindle" <JBrindle@snu.edu>, <SELinux@tycho.nsa.gov>
Subject: Re: selinux from user POV
Date: Sun, 12 Oct 2003 13:09:27 +1000
References: <sf880644.030@atlas.snu.edu>
In-Reply-To: <sf880644.030@atlas.snu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310121309.27854.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 12 Oct 2003 04:29, Joshua Brindle wrote:
> Being a user on an SELinux machine is currently not good.. Ideally
> it should be totally transparent but there are some issues. Mainly,
> right now, a user can't even add a .ssh directory and put their
> ssh key in authorized_keys2 and then log in with it without the
> admin having to relabel (or at least label those objects) .

One thing that should be noted at this time is that the problem is not just 
creation, it's also renaming.

For example if I keep a ~/www.bak directory that I can rename into place if a 
new change breaks something then I will want to permit Apache to serve 
content from it.

> Also, user webpages can't be read by apache until they are
> labeled correctly, which makes them fairly useless. Users
> can label  httpd_user_*_t but that clearly isn't something that
> most users are going to be aware of or desire to be hassled with.

This can of course be a configuration issue.  The administrator can decide 
whether to just grant apache access to the web content type or all files in 
the users' home directories.

> 1.An admin could cron relabeling to the /home partition, this is hackish
> and doesn't seem like a good solution to me..

You have to be really careful about hard links for this.  Of course if the 
relabel command would open the file first, get the current context, and then 
only make limited changes to it (EG preserving the identity and only making 
type changes within the range of types that a particular role has access to).

> 2. Could give users access to a limited setfiles script with a limited
> read-only file_contexts file that they can use on their own directories,

Why make it read-only?  If they want to copy the file_contexts file and make 
changes then it's their issue.

> they'd also have to be given permission to label ssh types.. (ick)

That shouldn't be a problem.  As they have full read-write access to the ssh 
types they can always achieve the same result by copying files around.  We 
should probably just grant that access.

> --- nsa guys really won't like these---
>
> 3. Trap file creation in glibc and use a limited file_contexts that
> glibc can read and setfscreatecon just before opening it for
> creation. This suffers from being in the context of whatever
> called for the file creation so many domains would possibly have
> to be given relabel permissions.

That also fails in the case of "mv".

mkdir ~/www.new
cd ~/www.new
tar xvzf /tmp/new-web-space.tgz
rm -rf ~/www
mv ~/www.new ~/www

Now my home page does not work...

> 4. (This one may be over complicated but seems like the most
> transparent solution). Load the file_contexts file into the kernel,
> NOT for enforcement of labels for files that already exist but
> only for creation of new files. hook around open file, if it's being

Loading regular expressions code into the kernel is not a good option.  But 
extending genfs_contexts to support basic wild-cards may be an option.

genfscon homefs /*/.gnupg       system_u:object_r:user_gpg_secret_t
genfscon homefs /*/.ssh         system_u:object_r:user_home_ssh_t

The problem is how to distinguish an ext3 file system used for /home from one 
used for /.  Maybe a mount option?  Maybe cat something to /selinux/
mount_context before mounting a file system?

I can't imagine any way of addressing this that isn't ugly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
