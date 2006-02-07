Subject: Re: problem changing role.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: redhat-lspp@redhat.com, SELinux@tycho.nsa.gov, sgrubb@redhat.com,
   dwalsh@redhat.com, Janak Desai <jdesai@us.ibm.com>,
   Kris Wilson <krisw@us.ibm.com>, gcwilson@us.ibm.com, vivijim@br.ibm.com
In-Reply-To: <200602071452.18452.glommer@br.ibm.com>
References: <200602071452.18452.glommer@br.ibm.com>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 12:10:11 -0500
Message-Id: <1139332211.2872.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-07 at 14:52 -0200, Glauber de Oliveira Costa wrote:
> I noticed the problem when doing the newrole command. When trying to change 
> root's role to sysadm_r , I got the following message:
> 
> [root@localhost ~]# newrole -r sysadm_r -t sysadm_t
> Authenticating root.
> Password:
> Error sending audit message.

What does the following show for you?
uname -r

Also, I assume you are using selinux-policy-mls?

> type=SELINUX_ERR msg=audit(1139315244.562:56): SELinux:  unrecognized netlink 
> message type=2300 for sclass=49

Yes, that netlink message isn't known to the mainline kernel yet, but a
patch in the LSPP kernel and in recent rawhide kernels makes audit and
SELinux aware of it.  So you need to be running a kernel that has that
patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
