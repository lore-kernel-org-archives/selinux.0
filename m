Subject: Re: SElinux troubles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Orion Poplawski <orion@cora.nwra.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4AC12227.1070006@cora.nwra.com>
References: <4AB10AC9.9020006@cora.nwra.com> <4AB1125E.3020402@redhat.com>
	 <4AB119F1.4070600@cora.nwra.com> <4AB12199.5090901@redhat.com>
	 <4AB7BC55.4060304@cora.nwra.com> <4AB83734.6090805@redhat.com>
	 <4AB8DE44.3090907@cora.nwra.com> <4AB8E96D.50801@redhat.com>
	 <4AB8F20A.5040409@cora.nwra.com> <4AC1087C.2090800@redhat.com>
	 <4AC118EC.6090707@cora.nwra.com>  <4AC119D3.5070107@redhat.com>
	 <1254169373.14478.191.camel@moss-pluto.epoch.ncsc.mil>
	 <4AC12227.1070006@cora.nwra.com>
Content-Type: text/plain
Date: Tue, 29 Sep 2009 07:59:00 -0400
Message-Id: <1254225540.2252.6.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-09-28 at 14:52 -0600, Orion Poplawski wrote:
> On 09/28/2009 02:22 PM, Stephen Smalley wrote:
> > On Mon, 2009-09-28 at 16:17 -0400, Daniel J Walsh wrote:
> >> On 09/28/2009 04:13 PM, Orion Poplawski wrote:
> >>> On 09/28/2009 01:03 PM, Daniel J Walsh wrote:
> >>>> On 09/22/2009 11:49 AM, Orion Poplawski wrote:
> >>>>> On 09/22/2009 09:12 AM, Daniel J Walsh wrote:
> >>>>>> On 09/22/2009 07:25 AM, Orion Poplawski wrote:
> >>>>>>> On 09/21/2009 08:32 PM, Daniel J Walsh wrote:
> >>>>>>>> Do you have labels on the rest of the system?  Do you have seedit
> >>>>>>>> installed?
> >>>>>>>
> >>>>>>> Yes, e.g.:
> >>>>>>>
> >>>>>>> # ls -Za /etc/ssh
> >>>>>>> drwxr-xr-x  root root system_u:object_r:etc_t          .
> >>>>>>> drwxr-xr-x  root root system_u:object_r:etc_t          ..
> >>>>>>> -rw-------  root root system_u:object_r:etc_t          moduli
> >>>>>>> -rw-r--r--  root root user_u:object_r:etc_t            ssh_config
> >>>>>>> -rw-------  root root system_u:object_r:etc_t          sshd_config
> >>>>>>> -rw-------  root root system_u:object_r:sshd_key_t
> >>>>>>> ssh_host_dsa_key
> >>>>>>> -rw-r--r--  root root root:object_r:etc_t
> >>>>>>> ssh_host_dsa_key.pub
> >>>>>>> -rw-------  root root system_u:object_r:sshd_key_t     ssh_host_key
> >>>>>>> -rw-r--r--  root root root:object_r:etc_t
> >>>>>>> ssh_host_key.pub
> >>>>>>> -rw-------  root root system_u:object_r:sshd_key_t
> >>>>>>> ssh_host_rsa_key
> >>>>>>> -rw-r--r--  root root root:object_r:etc_t
> >>>>>>> ssh_host_rsa_key.pub
> >>>>>>> -rw-r--r--  root root user_u:object_r:etc_t            ssh_known_hosts
> >>>>>>>
> >>>>>>> Don't appear to have seedit, never heard of it.
> >>>>>>>
> >>>>>> Right now as root you execute
> >>>>>>
> >>>>>> # chcon system_u:object_r:etc_t:s0 /etc/ssh
> >>>>>>
> >>>>>> It gives you an error?
> >>>>>
> >>>>> yup.
> >>>>>
> >>>>> # chcon system_u:object_r:etc_t:s0 /etc/ssh
> >>>>> chcon: failed to change context of /etc/ssh to
> >>>>> system_u:object_r:etc_t:s0: Operation not permitted
> >
> > I think I'm missing context for this discussion.  But it might help to
> > know:
> > 1) Output of id command,
> > 2) Policy type that is being used (targeted, mls, ...?)
> > 3) Policy version
> > 4) Kernel version
> >
> 
> uid=0(root) gid=0(root) 
> groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel) 
> context=user_u:system_r:unconfined_t

Dan, is this supposed to be user_u:system_r in RHEL5?  Or should it be
unconfined_u:unconfined_r as in current Fedora?

Do you get any avc denial in /var/log/audit/audit.log
or /var/log/messages?  If so, what does audit2why say about it?

> selinux-policy-targeted-2.4.6-257.el5
> 
> 2.6.18-128.7.1.el5
> 
> Basically, I'm running CentOS 5.3, but with Dan Walsh's selinux 
> repository enabled.  For some reason it appears to be preventing the 
> above labeling operation, which it happening during the installation of 
> openssh:
> 
>    Installing     : openssh                                           [1/5]
> Error unpacking rpm package openssh-4.3p2-36.el5.i386
> error: unpacking of archive failed on file /etc/ssh: cpio: lsetfilecon
> 
> 
> I probably should reboot to 2.6.18-164.el5 soon, but am kind of scared 
> due to the intermediate state of openssh.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
