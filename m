Subject: Re: SElinux troubles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Orion Poplawski <orion@cora.nwra.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4AC119D3.5070107@redhat.com>
References: <4AB10AC9.9020006@cora.nwra.com> <4AB1125E.3020402@redhat.com>
	 <4AB119F1.4070600@cora.nwra.com> <4AB12199.5090901@redhat.com>
	 <4AB7BC55.4060304@cora.nwra.com> <4AB83734.6090805@redhat.com>
	 <4AB8DE44.3090907@cora.nwra.com> <4AB8E96D.50801@redhat.com>
	 <4AB8F20A.5040409@cora.nwra.com> <4AC1087C.2090800@redhat.com>
	 <4AC118EC.6090707@cora.nwra.com>  <4AC119D3.5070107@redhat.com>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 16:22:53 -0400
Message-Id: <1254169373.14478.191.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-09-28 at 16:17 -0400, Daniel J Walsh wrote:
> On 09/28/2009 04:13 PM, Orion Poplawski wrote:
> > On 09/28/2009 01:03 PM, Daniel J Walsh wrote:
> >> On 09/22/2009 11:49 AM, Orion Poplawski wrote:
> >>> On 09/22/2009 09:12 AM, Daniel J Walsh wrote:
> >>>> On 09/22/2009 07:25 AM, Orion Poplawski wrote:
> >>>>> On 09/21/2009 08:32 PM, Daniel J Walsh wrote:
> >>>>>> Do you have labels on the rest of the system?  Do you have seedit
> >>>>>> installed?
> >>>>>
> >>>>> Yes, e.g.:
> >>>>>
> >>>>> # ls -Za /etc/ssh
> >>>>> drwxr-xr-x  root root system_u:object_r:etc_t          .
> >>>>> drwxr-xr-x  root root system_u:object_r:etc_t          ..
> >>>>> -rw-------  root root system_u:object_r:etc_t          moduli
> >>>>> -rw-r--r--  root root user_u:object_r:etc_t            ssh_config
> >>>>> -rw-------  root root system_u:object_r:etc_t          sshd_config
> >>>>> -rw-------  root root system_u:object_r:sshd_key_t    
> >>>>> ssh_host_dsa_key
> >>>>> -rw-r--r--  root root root:object_r:etc_t
> >>>>> ssh_host_dsa_key.pub
> >>>>> -rw-------  root root system_u:object_r:sshd_key_t     ssh_host_key
> >>>>> -rw-r--r--  root root root:object_r:etc_t             
> >>>>> ssh_host_key.pub
> >>>>> -rw-------  root root system_u:object_r:sshd_key_t    
> >>>>> ssh_host_rsa_key
> >>>>> -rw-r--r--  root root root:object_r:etc_t
> >>>>> ssh_host_rsa_key.pub
> >>>>> -rw-r--r--  root root user_u:object_r:etc_t            ssh_known_hosts
> >>>>>
> >>>>> Don't appear to have seedit, never heard of it.
> >>>>>
> >>>> Right now as root you execute
> >>>>
> >>>> # chcon system_u:object_r:etc_t:s0 /etc/ssh
> >>>>
> >>>> It gives you an error?
> >>>
> >>> yup.
> >>>
> >>> # chcon system_u:object_r:etc_t:s0 /etc/ssh
> >>> chcon: failed to change context of /etc/ssh to
> >>> system_u:object_r:etc_t:s0: Operation not permitted

I think I'm missing context for this discussion.  But it might help to
know:
1) Output of id command,
2) Policy type that is being used (targeted, mls, ...?)
3) Policy version
4) Kernel version

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
