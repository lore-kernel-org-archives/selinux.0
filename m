Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JEPjrT012339
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 10:25:46 -0400 (EDT)
Received: from smtp.wp.pl (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JEOl2w023332
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 14:24:48 GMT
Received: from ns.prosoft.com.pl (HELO [192.168.78.26]) (robkot6@[213.25.91.194])
          (envelope-sender <robkot6@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 19 Sep 2004 16:25:44 +0200
Subject: Basic problems with roles and domains
From: Robert Kot <robkot6@wp.pl>
To: SELinux mailing list <selinux@tycho.nsa.gov>
In-Reply-To: <200409192014.58452.russell@coker.com.au>
References: <20040913225410.GB14736@wintermute.xmldesign.de>
	 <200409192014.58452.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1095603929.3709.79.camel@skorpion>
Mime-Version: 1.0
Date: Sun, 19 Sep 2004 16:25:29 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

OS: stock Fedora Core 2

$ uname -a
Linux skorpion 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 i686 i386
GNU/Linux

Hi,

 I'm trying to learn SELinux using FC2.
This is probably stupid problem, but it's difficult for
a beginner.
First, I've added my user robert to 'users' file:

user robert roles { user_r };

In file_contexts/file_contexts:

/home/robert            -d      robert:object_r:user_home_dir_t
/home/robert/.+                 robert:object_r:user_home_t

Policy rebuilt, filesystem relabeled, OK.
Then I've created file myfile.txt. By default, it's labeled:

$ ll -Z
-rw-rw-r--+ robert   robert   robert:object_r:user_home_t myfile.txt

In new file domains/program/robert.te, I added:

type myfile_txt_t, file_type;
type myfile_t, domain;
role robert_r types myfile_t;

allow user_t myfile_txt_t : file { getattr read };

... and

/home/robert/myfile.txt	--	robert:object_r:myfile_txt_t

.. in file_contexts/program/robert.fc
I added role robert_r for use robert in users:

user robert roles { user_r robert_r};

Rebuilding, relabeling, etc.

Now, file has proper context:

$ ll -Z
-rw-rw-r--+ robert   robert   robert:object_r:myfile_txt_t    myfile.txt

And, as user robert, with context 

$ id -Z
robert:user_r:user_t

I can read myfile.txt, but everything else is denied, according to
'allow' rule in domains/program/robert.te. Changing permissions
in this rule works as expected, for domain user_t.

Now, I'd like to be able to access file only using new role
robert_r (with domain myfile_t). So, I changed access rule to:

allow myfile_t myfile_txt_t : file { getattr read };

I added robert_r:myfile_t to /etc/security/default_type:

# grep robert  ../../../default_type
robert_r:myfile_t

Now, I don't have access as robert:user_r:user_t:

$ ll -Z ?---------+ ?        ?        (null)                         
myfile.txt

That's OK, but I cannot switch to role robert_r:

$ newrole -r robert_r
Authenticating robert.
Password:
failed to exec shell

Audit message:
Sep 19 15:52:28 skorpion kernel: audit(1095601948.937:0): avc:  denied 
{ transition } for  pid=31796 exe=/usr/bin/newrole path=/bin/bash
dev=hda3 ino=485768 scontext=robert:user_r:newrole_t
tcontext=robert:robert_r:myfile_t tclass=process

The above happens if done in login shell, after 'su' it is:

$ newrole -r robert_r
Authenticating robert.
Password:
Warning!  Could not open /dev/pts/4.

I tried to follow guidelines from "Getting Started with SE Linux HOWTO",
section 6 "Adding a new user domain" (changes in domains/user.te and
macros/user_macros.te), but it didn't help.

Giving up, I tried to add myfile_t domain to user_r 
role:

role user_r types myfile_t;
allow myfile_t myfile_txt_t : file { getattr read };

As robert:user_r:user_t I have no access:

$ ll -Z
?---------+ ?        ?        (null)                          myfile.txt

Trying to switch domains:

$ newrole -t myfile_t
Authenticating robert.
Password:
failed to exec shell

Sep 19 16:15:34 skorpion kernel: audit(1095603334.119:0): avc:  denied 
{ transition } for  pid=10171 exe=/usr/bin/newrole path=/bin/bash
dev=hda3 ino=485768 scontext=robert:user_r:newrole_t
tcontext=robert:user_r:myfile_t tclass=process

... for login shell, and, as before "Warning!  Could not open
/dev/pts/4." after su.

apol tool reports that user_r role contains myfile_t.

What else is necessary to set up new role ? Some additional
domain transition rules ?

Thanks,
Robert




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
