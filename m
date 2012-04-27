MIME-Version: 1.0
Date: Fri, 27 Apr 2012 16:55:52 +0800
Message-ID: <CAO-AVB5UNL6UNk-pMCjxmc1sgkMDJbAe47pvpeYg6Zgy2aKENA@mail.gmail.com>
Subject: generate the policy for embedded device by seedit-cross
From: casinee app <appcasinee@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
i want to generate the policy for embedded device by seedit-cross. The
seedit-cross comes from the compiling of seedit. But when i executed
the command below written in the ducument from the web site
http://seedit.svn.sourceforge.net/svnroot/seedit/trunk/README.cross,
it gave the error message like this:
root@coon:/home/coon/new/seedit-cross# ./seedit-load -v -d
[: 83: ==: unexpected operator
[: 88: ==: unexpected operator
[: 93: ==: unexpected operator
[: 83: ==: unexpected operator
[: 88: ==: unexpected operator
[: 93: ==: unexpected operator
[: 83: ==: unexpected operator
[: 88: ==: unexpected operator
[: 93: ==: unexpected operator
seedit-load: Success
Input file open
error:/usr/share/seedit/sepolicy/confined_domains/sbin/auditctl -d
exit,always -S chdir  >/dev/null 2>&1
root@coon:/home/coon/new/seedit-cross# ls
audit2spdl   dynamic_contexts  seedit       seedit-converter  seedit-load
base_policy  macros            seedit.conf  seedit-cross.sh   simplified_policy

How can i solve this problem?  Thanks a lot.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
