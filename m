MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Subject: Roles (FC3)
Date: Mon, 3 Jan 2005 11:20:48 +0100
Message-ID: <6A23B769A5F0B845A479F7F33CCC9B380CFACFC4@E2K1.corp.plusnet>
From: =?iso-8859-2?Q?Jaros=B3aw_Nozderko?= <jaroslaw.nozderko@polkomtel.com.pl>
To: "SELinux" <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

OS: Fedora Core 3, strict policy

Hi,

 I still have problems with roles :(

I've added new user paul:

user paul roles  { user_r };

# make load

# ll -Z  /home/
drwx------  paul     paul     root:object_r:user_home_dir_t    paul

# grep paul file_contexts/file_contexts
/home/paul              -d      paul:object_r:user_home_dir_t
/home/paul/.+                   paul:object_r:user_home_t
/home/paul/((www)|(web)|(public_html))(/.+)? paul:object_r:httpd_user_content_t
/home/paul/\.gnupg(/.+)?        paul:object_r:user_gpg_secret_t
/home/paul/.ircmotd     --      paul:object_r:user_home_irc_t
/home/paul/\.netscape(/.*)?     paul:object_r:user_mozilla_rw_t
/home/paul/\.mozilla(/.*)?      paul:object_r:user_mozilla_rw_t
/home/paul/\.phoenix(/.*)?      paul:object_r:user_mozilla_rw_t
/home/paul/\.gconfd(/.*)?               paul:object_r:user_mozilla_rw_t
/home/paul/\.gconf(/.*)?                paul:object_r:user_mozilla_rw_t
/home/paul/\.gnome2/epiphany(/.*)? paul:object_r:user_mozilla_rw_t
/home/paul/My.Downloads(/.*)?   paul:object_r:user_mozilla_rw_t
/home/paul/\.screenrc   --      paul:object_r:user_home_screen_t
/home/paul/\.spamassassin(/.*)? paul:object_r:user_home_spamassassin_t
/home/paul/\.ssh(/.*)?          paul:object_r:user_home_ssh_t
/home/paul/\.uml(/.*)?          paul:object_r:user_uml_rw_t
/home/paul/\.Xauthority.* --    paul:object_r:user_home_xauth_t

# setfiles file_contexts/file_contexts /home/paul
setfiles:  read 1552 specifications
setfiles:  labeling files under /home/paul
setfiles:  hash table stats: 11 elements, 11/65536 buckets used, longest chain length 1
setfiles:  Done.

# ll -Z  /home/
drwx------  paul     paul     paul:object_r:user_home_dir_t    paul

$ id
uid=502(paul) gid=502(paul) grupy=502(paul) context=paul:user_r:user_t

Everything is OK if paul has default role and type. However, I'd like to
create custom role, according to [1]:

domains/user.te:

full_user_role(paul)

macros/user_macros.te:

undefine(`in_user_role')
define(`in_user_role', `
role user_r types $1;
role staff_r types $1;
role paul_r types $1;
')

users:

user paul roles  { paul_r };

# make load

$ su - paul
Password:
Would you like to enter a security context? [y] y
role: paul_r
type: paul_t
su: /bin/bash: Brak dostêpu

("access denied"), logs (after policy loading):

audit(1104688142.077:0): avc:  granted  { load_policy } for  pid=3452 exe=/usr/sbin/load_policy scontext=root:sysadm_r:load_policy_t
tcontext=system_u:object_r:security_t tclass=securitysecurity:  7 users,
8 roles, 1455 types, 27 bools
security:  53 classes, 356419 rules
security:  invalidating context paul:user_r:user_t
audit(1104688170.288:0): avc:  denied  { transition } for  pid=3460 exe=/bin/su path=/usr/X11R6/bin/xauth dev=hda3 ino=344440 scontext=jarek:user_r:user_su_t tcontext=paul:paul_r:paul_t tclass=process
audit(1104688170.291:0): avc:  denied  { transition } for  pid=3461 exe=/bin/su path=/bin/bash dev=hda3 ino=550613 scontext=jarek:user_r:user_su_t tcontext=paul:paul_r:paul_t tclass=process

Trying the same as root (sysadm_r):

audit(1104688236.390:0): avc:  denied  { transition } for  pid=3469 exe=/bin/su path=/bin/bash dev=hda3 ino=550613 scontext=root:sysadm_r:sysadm_su_t tcontext=paul:paul_r:paul_t tclass=process

According to [1], I tried to properly relabel paul's home directory:

# ls -alZ ~paul
drwx------  paul     paul     paul:object_r:user_home_dir_t    .
drwxr-xr-x  root     root     system_u:object_r:home_root_t    ..
-rw-------  paul     paul     paul:object_r:user_home_t        .bash_history
-rw-r--r--  paul     paul     paul:object_r:user_home_t        .bash_logout
-rw-r--r--  paul     paul     paul:object_r:user_home_t        .bash_profile
-rw-r--r--  paul     paul     paul:object_r:user_home_t        .bashrc
-rw-r--r--  paul     paul     paul:object_r:user_home_t        .emacs
-rw-r--r--  paul     paul     paul:object_r:user_home_t        .gtkrc
drwxr-xr-x  paul     paul     paul:object_r:user_home_t        .kde
-rw-r--r--  paul     paul     paul:object_r:user_home_t        .zshrc

# restorecon `find /home/paul`

# ls -alZ ~paul
drwx------  paul     paul     paul:object_r:paul_home_dir_t    .
drwxr-xr-x  root     root     system_u:object_r:home_root_t    ..
-rw-------  paul     paul     paul:object_r:paul_home_t        .bash_history
-rw-r--r--  paul     paul     paul:object_r:paul_home_t        .bash_logout
-rw-r--r--  paul     paul     paul:object_r:paul_home_t        .bash_profile
-rw-r--r--  paul     paul     paul:object_r:paul_home_t        .bashrc
-rw-r--r--  paul     paul     paul:object_r:paul_home_t        .emacs
-rw-r--r--  paul     paul     paul:object_r:paul_home_t        .gtkrc
drwxr-xr-x  paul     paul     paul:object_r:paul_home_t        .kde
-rw-r--r--  paul     paul     paul:object_r:paul_home_t        .zshrc

Unfortunately, it doesn't help much:

$ su - paul
Password:
Would you like to enter a security context? [y] y
role: paul_r
type: paul_t
su: /bin/bash: Brak dostêpu

audit(1104688550.077:0): avc:  denied  { transition } for  pid=3479 exe=/bin/su path=/usr/X11R6/bin/xauth dev=hda3 ino=344440 scontext=jarek:user_r:user_su_t tcontext=paul:paul_r:paul_t tclass=process
audit(1104688550.080:0): avc:  denied  { transition } for  pid=3480 exe=/bin/su path=/bin/bash dev=hda3 ino=550613 scontext=jarek:user_r:user_su_t tcontext=paul:paul_r:paul_t tclass=process

I tried to add paul_r:paul_t to default_types and default_contexts files, but it didn't help.
If memory serves, it worked in FC2. What else is required to create custom role ?

I'd like to know more about custom roles and about adding additional roles for existing user. 
I've read most of the documentation available, including Bill MacCarty's book, and
this topic doesn't seem to be covered well enough.

Thanks for any help,
Jarek

References:

[1] IBM, Security Enhanced Linux Implementation Lab (Part 7: Creating New Roles)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
