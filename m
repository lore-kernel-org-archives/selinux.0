Subject: file_type_auto_trans is not sufficient
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: SELinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: text/plain
Date: Fri, 27 May 2005 23:09:20 -0400
Message-Id: <1117249760.19257.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As part of my current project, I am running into a large number of cases
where file_type_auto_trans is not an acceptable solution for changing
the context for a newly created file/directory. This always
happens in a conflicting-transition scenario (very common):

For example:

1) 
libgnome needs to create .gnome2 and .gnome2_private with
a context that differs from the parent directory. Applications
that link to libgnome may already have a transition defined 
for (ROLE_home_dir_t: dir)

2)
libfontconfig needs to create .font.cache-# with
a context that differs from the parent directory. Same
problem for (ROLE_hime_dir_t: file)

3) 
Mail apps need to be able to save mail to $HOME
under some context (likely ROLE_untrusted_content_t:file/dir).
Same goes for web content saved by mozilla. This conflicts
with the usual transition.

4) 
libORBit2 needs to create /tmp/orbit-$USER... with a specific
context while the app may have its own tmp_domain. Same for libICE.

===============

To address those problems, I think I need to add selinux support
to a number of applications, and perform the transition in the code. 
I'm not sure what's the best way to do that. Does adding 
the following functions to libselinux (or elsewhere) make sense?

int mkdir_restorecon(const char *pathname, mode_t mode);
int creat_restorecon(const char *pathname, mode_t mode);
int mknod_restorecon(const char *pathname, mode_t mode, dev_t dev);

Those would perform getfscreate/matchpathcon/setfscreate cycle,
and would ignore errors in permissive mode.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
