Subject: Re: [ PATCH ] hal - create netlink socket
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1112026381.2914.95.camel@moss-spartans.epoch.ncsc.mil>
References: <1111905173.3520.8.camel@cobra.ivg2.net>
	 <1112016475.2914.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1112026129.3040.1.camel@cobra.ivg2.net>
	 <1112026381.2914.95.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 12:02:14 -0500
Message-Id: <1112029334.3350.2.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Ah, we don't get the desired information because it is being passed by
> address for the socketcall multiplexer.  Maybe run hald under strace (in
> permissive mode, of course).

Does this help?

socket(PF_NETLINK, SOCK_DGRAM, 15)      = 7
getpid()                                = 4076
bind(7, {sa_family=AF_NETLINK, pid=4076, groups=ffffffff}, 12) = -1
EPERM (Operation not permitted)
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7fd1000
write(1, "*** [DIE] osspec.c:osspec_init()"..., 72) = 72
munmap(0xb7fd1000, 4096)                = 0
exit_group(1)                           = 
-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
