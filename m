Subject: Re: selinux from user POV
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: SELinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Brian May <bam@snoopy.apana.org.au>
In-Reply-To: <sf880644.030@atlas.snu.edu>
References: <sf880644.030@atlas.snu.edu>
Content-Type: text/plain
Message-Id: <1066141498.5054.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Oct 2003 10:24:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-10-11 at 14:29, Joshua Brindle wrote:
> This is going to be contraversial, I know, but this is something that
> is fairly important to me and others I know of on this list.
> 
> Being a user on an SELinux machine is currently not good.. Ideally
> it should be totally transparent but there are some issues. Mainly, 
> right now, a user can't even add a .ssh directory and put their
> ssh key in authorized_keys2 and then log in with it without the 
> admin having to relabel (or at least label those objects) . 

Put an empty .ssh directory in the /etc/skel directory and assign it the
correct type there, and modify useradd to preserve types when copying
the skeleton directory for new accounts.  Then when a user creates files
in that directory, they will inherit the right type by default.  Also,
make sure that all programs that automatically create .ssh
subdirectories are run in a domain that has a file_type_auto_trans rule
to put them into the right type.  I think that this needs to be done for
ssh-keygen.

> Also, user webpages can't be read by apache until they are
> labeled correctly, which makes them fairly useless. Users
> can label  httpd_user_*_t but that clearly isn't something that 
> most users are going to be aware of or desire to be hassled with.

As above, put an empty public_html directory into the skeleton directory
and type it properly there, and have useradd preserve the type when it
is copied.  Then the user's files will be typed correctly by default.

> 1.An admin could cron relabeling to the /home partition, this is hackish
> and doesn't seem like a good solution to me..

I'd agree that this is not a good solution.  You don't want to blindly
clobber the existing types; some files may have been typed automatically
based on file_type_auto_trans rules, some files may have been typed
explicitly by security-aware applications or users.  Also, as Russell
noted, hard links are an issue, but SELinux does control the ability to
create a hard link to a file based on the file's context.

> 2. Could give users access to a limited setfiles script with a limited 
> read-only file_contexts file that they can use on their own directories,
> they'd also have to be given permission to label ssh types.. (ick)
> it would also require additional user knowledge.. users aren't prone
> to learn _anything_

The control is provided by the kernel-enforced access controls on
relabeling, not by the setfiles program or the file_contexts
configuration.

> --- nsa guys really won't like these---

Correct.

> 3. Trap file creation in glibc and use a limited file_contexts that
> glibc can read and setfscreatecon just before opening it for 
> creation. This suffers from being in the context of whatever 
> called for the file creation so many domains would possibly have
> to be given relabel permissions. 

Nit:  Not relabel permission.  Creating a file with a particular context
is not the same as relabeling a file to a particular context, and
different permissions are checked.

I'd agree that this is not a good solution.

> 4. (This one may be over complicated but seems like the most
> transparent solution). Load the file_contexts file into the kernel, 
> NOT for enforcement of labels for files that already exist but
> only for creation of new files. hook around open file, if it's being
> created assign it's label, the file_contexts loaded into the kernel
> could be limited to avoid any possible security hazards, this would
> eliminate the need to assign relabeling permissions to user contexts
> and application contexts that may need to create files in the user
> home dirs.. (mail daemons, etc). 
> 
> #4 is my favorite but I don't know how complicated it could be
> to implement, and I'm almost certain that the nsa guys will smite
> me for this :( . It is the most transparent for the users, requires
> the least work for the admin, and would really make selinux more
> enterprise friendly.. 

Pathname-based security considered harmful.

The kernel already provides a mechanism for transparently labeling new
files.  See file_type_auto_trans.  In cases where this is insufficient,
security awareness in the program is required.


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
