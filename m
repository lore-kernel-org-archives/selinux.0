Message-ID: <454A8F35.2020006@us.ibm.com>
Date: Thu, 02 Nov 2006 18:37:09 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 0/8] make newrole suid (take 3)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the intro to a set of eight patches.

I finally took the time to break things down so that (I hope) more 
people read and give feedback (I can't believe only Stephen Smalley had 
comments, my code isn't that great!)

These patches are an attempt to make newrole be an acceptably secure 
suid root program, to provide it with the capabilities to generate audit 
records (existing) and handle polyinstatiation (new).

The format of the patches is different from previous sends.

The 8 patches are as follows:
1) Modifications to Makefile to support future patch needs
    Add newrole-lspp.pamd
2) New extract_pw_data function and use in main()
3) Add signal handler function
4) Update drop_capabilities() and use in main()
5) Update the authentication functions and use in main()
    Add cleanup since pam_start is now left till program end
6) Move relabeling tty actions into functions
7) Move command-line argument parsing into a function
    Clear the environment during execution
    Add support for preserving the environment (-p)
8) Shift to using new defines in the Makefile and in newrole.c
    Add support for namespaces
    Remove unused code, cleanup and documentation

It is now possible to apply a single patch and the code will compile; 
however, this is not recommended

The comments and discussions from the previous send (take 2) of these 
patches have been integrated.

Thanks,
Mike



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
