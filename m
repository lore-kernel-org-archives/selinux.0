Subject: Redhat 9
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1061830219.18210.50.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Mon, 25 Aug 2003 12:50:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been setting up an SELinux system using the current 2.6 SELinux
release (2.6.0-test3) on Redhat 9. Everything seems to be working well
with 2 exceptions:

- Using ext2 as the filesystem seems to have some problems with extended
attributes and sockets. Doing a make relabel failed for any sockets
(/dev/log for example). This seems to be a general problem with ext2,
however, as the standard extended attribute tools failed to get/set
attributes on these files with 'operation not supported'.

- The glibc srpm compiles correctly but causes any program linked to
glibc to segfault after installation. I did very little to track down
this problem, but I can easily provide more debugging information on
request (this is using VMWare so it is not a problem to install the rpm
and do some more testing because I can revert it later).

Any help or suggestions welcome.

Karl

---------------------
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
