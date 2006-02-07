From: Rodrigo Vivi <vivijim@br.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: problem changing role.
Date: Tue, 7 Feb 2006 15:18:08 -0200
Cc: glommer@br.ibm.com, redhat-lspp@redhat.com, SELinux@tycho.nsa.gov,
   sgrubb@redhat.com, dwalsh@redhat.com, Janak Desai <jdesai@us.ibm.com>,
   Kris Wilson <krisw@us.ibm.com>, gcwilson@us.ibm.com
References: <200602071452.18452.glommer@br.ibm.com> <1139332211.2872.78.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1139332211.2872.78.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602071518.08728.vivijim@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 07 February 2006 15:10, Stephen Smalley wrote:
> On Tue, 2006-02-07 at 14:52 -0200, Glauber de Oliveira Costa wrote:
> > I noticed the problem when doing the newrole command. When trying to
> > change root's role to sysadm_r , I got the following message:
> >
> > [root@localhost ~]# newrole -r sysadm_r -t sysadm_t
> > Authenticating root.
> > Password:
> > Error sending audit message.
>
> What does the following show for you?
> uname -r
2.6.15-1.1826.2.10_FC5

This is a FC5 test2 !

>
> Also, I assume you are using selinux-policy-mls?

Yes, we are using mls policy !

About the what glauber said about a signal that there is something wrong:

I've eneabled mls using
yum install selinux-policy-mls;   (from yesterday !!)
Set policy to mls;
Set to permissive mode
touch /.autorelabel
reboot
After relabel I've noticed that some labels of /root was wrong so it was 
necessary to use 'fixfiles  relabel' to fix it !

>
> > type=SELINUX_ERR msg=audit(1139315244.562:56): SELinux:  unrecognized
> > netlink message type=2300 for sclass=49
>
> Yes, that netlink message isn't known to the mainline kernel yet, but a
> patch in the LSPP kernel and in recent rawhide kernels makes audit and
> SELinux aware of it.  So you need to be running a kernel that has that
> patch.

-- 
Rodrigo Vivi
vivijim@br.ibm.com
IBM - Linux Technology Center - Brazil

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
