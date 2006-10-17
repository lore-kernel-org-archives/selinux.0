Message-ID: <45351FC9.2080204@us.ibm.com>
Date: Tue, 17 Oct 2006 13:24:09 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 0/4] newrole suid functionality (take 2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the intro to a set of four patches.

These patches are an attempt to make newrole be an acceptably secure 
suid root program, to provide it with the capabilities to generate audit 
records (existing) and handle polyinstatiation (new).

The 4 patches are as follows:
1) New functions introduced to newrole.c, new and existing functionality
2) Changes to existing functions in newrole.c
3) Updates to main in newrole.c to use the aforementioned changes
4) Changes to the Makefile to allow building of newrole with the
    changes and introduction of newrole-lspp.pamd

Note: This is an atomically applicable patch set. Applying a subset of 
these patches will break the build.

The comments from the previous send of these patches have been integrated.

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
