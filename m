From: Alan Rouse <alan.rouse@ericsson.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
        "Justin P. Mattock"
	<justinmattock@gmail.com>
CC: "refpolicy@oss1.tresys.com" <refpolicy@oss1.tresys.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Wed, 12 May 2010 13:52:32 -0400
Subject: RE: [refpolicy] Labeling home directories in refpolicy (SOLVED)
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDB95@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBD95F@EUSAACMS0703.eamcs.ericsson.se>
	<1273673475.3738.21.camel@moss-pluto.epoch.ncsc.mil>
	<4BEABBC8.3000009@gmail.com>
	<1273675690.3738.41.camel@moss-pluto.epoch.ncsc.mil>
 <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDAF8@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDAF8@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems the problem was due to the fact that on this particular VM I had neglected to set the selinux user for the unprivileged login (semanage -a -s user_u <login>).   

-----Original Message-----
From: refpolicy-bounces@oss.tresys.com [mailto:refpolicy-bounces@oss.tresys.com] On Behalf Of Alan Rouse
Sent: Wednesday, May 12, 2010 12:44 PM
To: Stephen Smalley; Justin P. Mattock
Cc: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov
Subject: Re: [refpolicy] Labeling home directories in refpolicy

Running genhomedircon creates file_contexts.homedirs but it is pretty sparse:

> #
> # Home Context for user unconfined_u
> #
> 
> /home/a?quota\.(user|group)	--	system_u:object_r:quota_db_t:s0
> /home/lost\+found/.*	<<none>>
> /home	-d	system_u:object_r:home_root_t:s0
> /home/\.journal	<<none>>
> /home/lost\+found	-d	system_u:object_r:lost_found_t:s0

In the source rpm the file policy/modules/system/userdomain.fc differs between fedora and refpolicy.  The refpolicy version just has

> HOME_DIR	-d	gen_context(system_u:object_r:user_home_dir_t,s0-mls_systemhigh)
> HOME_DIR/.+		gen_context(system_u:object_r:user_home_t,s0)
> 
> /tmp/gconfd-USER -d	gen_context(system_u:object_r:user_tmp_t,s0)

But the fedora version has

> HOME_DIR	-d	gen_context(system_u:object_r:user_home_dir_t,s0-mls_systemhigh)
> HOME_DIR	-l	gen_context(system_u:object_r:user_home_dir_t,s0-mls_systemhigh)
> HOME_DIR/.+		gen_context(system_u:object_r:user_home_t,s0)
> /tmp/gconfd-USER -d	gen_context(system_u:object_r:user_tmp_t,s0)
> /root(/.*)?	 	gen_context(system_u:object_r:admin_home_t,s0)
> /dev/shm/pulse-shm.*	gen_context(system_u:object_r:user_tmpfs_t,s0)
> /dev/shm/mono.*		gen_context(system_u:object_r:user_tmpfs_t,s0)
> HOME_DIR/\.cert(/.*)?	gen_context(system_u:object_r:home_cert_t,s0)
> HOME_DIR/\.pki(/.*)?    gen_context(system_u:object_r:home_cert_t,s0)
> HOME_DIR/\.gvfs(/.*)?	<<none>>
> /root/\.cert(/.*)?		gen_context(system_u:object_r:home_cert_t,s0)

I don't see the answer to my labeling problems in the fedora version.  Am I missing something?  Or is there a different .fc that gets involved in correctly labeling user home directories?

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
Sent: Wednesday, May 12, 2010 10:48 AM
To: Justin P. Mattock
Cc: Alan Rouse; refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov
Subject: Re: [refpolicy] Labeling home directories in refpolicy

On Wed, 2010-05-12 at 07:31 -0700, Justin P. Mattock wrote:
> On 05/12/2010 07:11 AM, Stephen Smalley wrote:
> > On Wed, 2010-05-12 at 10:04 -0400, Alan Rouse wrote:
> >    
> >> I'm trying to adapt a recent refpolicy snapshot (May 4) to OpenSUSE.
> >> (Previously I adapted the Fedora 12 policy, more as a learning
> >> exercise.)  Now I'm finding that the refpolicy is not labeling home 
> >> directories properly (they all end up as default_t after "fixfiles -F
> >> relabel").   I'm running unprivileged users as user_u and root as
> >> sysadm_u, so I expect corresponding labels on files in the home 
> >> directory.  Is there a special mechanism for getting the home dirs 
> >> labeled consistent with the corresponding selinux user, or do I need
> >> to define labeling for the files individually in a new module?   And
> >> how do files in the home dir such as .ssh (which should have a type 
> >> other than user_t) get their types?
> >>
> >> Or perhaps something is broken in the distribution that is causing 
> >> labels from the refpolicy not to be applied in the home dir?
> >>
> >> Any insights would be appreciated!
> >>      
> > Did you build with MONOLITHIC=n?
> >
> >    
> I've noticed some funkyness with the home dir labels as well i.g.
> id -Z
> name:staff_r:staff_t:s0
> but the labels go
> name name user_r:object_r:user_home_t:s0 if I add a new file the 
> labels get set right name name name:object_r:user_home_t:s0
> 
> maybe something is astray in genhomedircon!
> (genhomedircon line#13)

The genhomedircon functionality is part of libsemanage these days, and /usr/sbin/genhomedircon is just a compatibility script that does:
#!/bin/sh
/usr/sbin/semodule -Bn

i.e. rebuild policy in order to regenerate the file_contexts.homedirs file.

So if policy is monolithic, I'm not sure you get any file_contexts.homedirs at all.

--
Stephen Smalley
National Security Agency

_______________________________________________
refpolicy mailing list
refpolicy@oss.tresys.com
http://oss.tresys.com/mailman/listinfo/refpolicy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
