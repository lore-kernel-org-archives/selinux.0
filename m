Message-Id: <sf880644.030@atlas.snu.edu>
Date: Sat, 11 Oct 2003 13:29:07 -0500
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <SELinux@tycho.nsa.gov>
Subject: selinux from user POV
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This is going to be contraversial, I know, but this is something that
is fairly important to me and others I know of on this list.

Being a user on an SELinux machine is currently not good.. Ideally
it should be totally transparent but there are some issues. Mainly, 
right now, a user can't even add a .ssh directory and put their
ssh key in authorized_keys2 and then log in with it without the 
admin having to relabel (or at least label those objects) . 

Also, user webpages can't be read by apache until they are
labeled correctly, which makes them fairly useless. Users
can label  httpd_user_*_t but that clearly isn't something that 
most users are going to be aware of or desire to be hassled with.

There are a few solutions, many I don't like, the others I know
the nsa guys probably won't like but this is, like I said, fairly important.

1.An admin could cron relabeling to the /home partition, this is hackish
and doesn't seem like a good solution to me..

2. Could give users access to a limited setfiles script with a limited 
read-only file_contexts file that they can use on their own directories,
they'd also have to be given permission to label ssh types.. (ick)
it would also require additional user knowledge.. users aren't prone
to learn _anything_

--- nsa guys really won't like these---

3. Trap file creation in glibc and use a limited file_contexts that
glibc can read and setfscreatecon just before opening it for 
creation. This suffers from being in the context of whatever 
called for the file creation so many domains would possibly have
to be given relabel permissions. 

4. (This one may be over complicated but seems like the most
transparent solution). Load the file_contexts file into the kernel, 
NOT for enforcement of labels for files that already exist but
only for creation of new files. hook around open file, if it's being
created assign it's label, the file_contexts loaded into the kernel
could be limited to avoid any possible security hazards, this would
eliminate the need to assign relabeling permissions to user contexts
and application contexts that may need to create files in the user
home dirs.. (mail daemons, etc). 

#4 is my favorite but I don't know how complicated it could be
to implement, and I'm almost certain that the nsa guys will smite
me for this :( . It is the most transparent for the users, requires
the least work for the admin, and would really make selinux more
enterprise friendly.. 

Please give comments, flames, opinions, etc

Joshua Brindle




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
