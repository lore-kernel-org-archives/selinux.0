Date: Fri, 14 May 2004 22:30:20 -0500
To: SELinux <SELinux@tycho.nsa.gov>
Subject: policy questions and bugs
Message-ID: <20040515033020.GA5060@balder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Chris Grier <grier@uiuc.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a whole bunch of questions after reading the FAQ and some other
random documents I found for selinux, here they are:

The dpkg and rpm both have apt-get in their domain te files. fixfiles
doesn't like having multiple contexts defined for a single file. This
might be a bug.

Why do dmesg redirections (such as root running dmesg > ~/output) cause
an audit deny? I'm not sure this is a dmesg specific error, I think it
might be a little more general for other redirections too. Here's the
message:

avc:  denied  { write } for  pid=1953 exe=/bin/dmesg path=/root/test
dev=md0 ino=740514 scontext=root:system_r:dmesg_t
tcontext=root:object_r:staff_home_t tclass=file

When running some services, I would like them to run as a non root uid
and gid (ircd and oidentd are the services which I usually do this
with), which I normally do with su. When we do this with selinux
running, we are prompted to enter a role and type (not select from a
list). Is this just a matter of defining a transition to acommodate for
this to happen?

Why do normal users have the option of changing to sysadm? I don't
particularly like this, and I could remove it, but I'm looking for the
reasoning behind the default being like this.

What does this mean: 

inode_doinit_with_dentry:  context_to_sid(system_u:object_r:apt_etc_t)
returned 22 for dev=md0 ino=517610

This is a "new" error (as in, in the last couple hours of getting things
going, I had not seen it). I'm not sure what happened to make this error
start.

Last question for today, when creating my own fc and te files to build
into the policy, is it safe to create them in the policy/src directory,
or will future package updates simply overwrite them and kill all the
stuff I'm writing? How about modifications of existing files in the
policy source directory?

-- 
Chris Grier <grier@uiuc.edu>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
