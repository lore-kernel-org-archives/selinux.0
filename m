Message-ID: <4E2FDA3A.5040408@windriver.com>
Date: Wed, 27 Jul 2011 17:28:26 +0800
From: Rongqing Li <rongqing.li@windriver.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Stephen Smalley
	<sds@tycho.nsa.gov>
Subject: "netstat -Z" reimplementation
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SELinux folks, Stephen:

I have some thoughts about reimplementation of 'netstat -Z', but I do
not know if it is valuable, or if there are other risks. Could you
evaluate my implementation, or give me your valuable advice?

1. From kernel, print the socket labels to tcp, udp, raw, unix
files under /proc/net/.

Now the /proc/net/tcp /proc/net/udp ... include many socket's
information, like local address, remote address, inode, I think we can
put the socket's security context to these files.

To avoid to expose these information to non-privileged users, security
checking should be done when expose the socket security context to procfs.

2. reimplementation the "netstat -Z", "netstat -Z" will first parse the
security context from procfs's tcp, udp, raw files, and get the security
context, if this step fails, "netstat -Z" will try as legacy method.


If this implementation could be accepted by mainstream, netstat could
print the correct socket label even if the type_transition has been
happen on socket, or application changes socket labels by setting
/proc/self/attr/sockcreate.


Do you think it is valuable?

Thanks

-- 
Best Reagrds,
Roy | RongQing Li
-------------------------------------------------------------
WIND RIVER Beijing | China Development Center
Phone: +86-10-6483-5025, Cell: +86-135-2202-9864, Fax: +86-10-6479-0367


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
