Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KK2bTf010711
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 15:02:37 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1KK3slw024442
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 20:03:54 GMT
Subject: Re: Latest diffs - Resent with additional changes.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB1A99.3070104@redhat.com>
References: <45B8ACBF.8090201@redhat.com>
	 <1171663101.20576.147.camel@sgc.columbia.tresys.com>
	 <45DB1A99.3070104@redhat.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 20:04:07 +0000
Message-Id: <1172001847.20576.199.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 10:58 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> >
> > On Thu, 2007-01-25 at 08:12 -0500, Daniel J Walsh wrote: 
> >> Certain tools have rpm libraries built into them and these end up
> >> calling the transition rules and getting denials.  I want to allow
> >> unconfined_t to transition to rpm_script_t
> >>     
> >
> >   
> Multiple people are putting out apps like pup, up2date and other daemons 
> that basically use the rpm database.  We need to keep labeling these 
> rpm_exec_t to get them to work, or just allow the unconfined domain to 
> transition to rpm_script_t to make rpm_exec work correctly.

They do setexeccon(::rpm_script_t)?

> > also, why was apache_manage_all_content(useradd_t) added?
> >
> >   
> useradd will create ~/public_html and any contents in it from the skel,  
> It needs to be able to create and label these files.  As we expand 
> userroles, we might need the capabilitity to identify contents in a home 
> directory by attribute and allow useradd and friends to create/relabel them.

The extras (stuff beyond things like .bashrc) in the skel is distro
dependent, so this should be in a distro_redhat.

> >> Still want break out of hi_reserved_port_t from reserved_port_t.
> >>     
> >
> > I don't have a problem with breaking them up, but the current
> > implementation needs some work.  The current interfaces that give access
> > to reserved_port_t shouldn't also give access to hi_reserved_port_t.
> >
> >   
> Ok I think we should change
> corenet_udp_bind_reserved_port and
> corenet_tcp_bind_reserved_port to use hi_reserved_port_t

I think we should have a low_reserved_port_t and high_reserved_port_t as
it seems clearer than reserved_port_t and high_reserved_port_t.  The
interfaces should reflect that.
  
> >> sendmail wants to read clamav_libs
> >>     
> >
> > Weird.  moved up.
> >
> >   
> I think we might want to somehow add an attibute to file types that 
> sendmail can read. 
> 
> sendmail < /var/run/log  commands are probably causing this type of access.

I'm not sure its dynamic enough to need an attribute.  We could consider
adding access to common stuff like config files, log files, and some
temp files.  

> >> local_login needs additional privs
> >>     
> >
> > Can you elaborate on these; they all seem odd.
> >
> >   
> I am not sure why they are generated,  I would guess this is generated 
> by some pam module that requires appletalk communications.

I'm going to need some more info on this.

> >> lvm needs privs for multipath
> >>     
> >
> > Can you elaborate as to why multipath (dm/lvm) needs net_admin?  A
> > cursory look through the docs doesn't mention the network at all.
> >
> >   
> Perhaps raid/iscsi?  Just guessing.  Don't have access to the Bugzilla 
> that reported it.

I'm going to need justification for this change.

> >> modutils fixes for strict policy
> >>     
> >
> > Why would depmod delete kernel modules?  Seems more like a mislabeled file.
> >
> >   
> Perhaps creating a tmp file in that directory?

My guess would be a file that is supposed to be modules_dep_t is instead
mislabeled as modules_object_t.

> > The term_unconfined() seems superfluous.
> >
> >   
> Certain privs are not available for terminals, from unconfined domain.  

It should be covered by the device_unconfined(), but looks like the
problem is that they're not marked as device nodes in term_tty() and
term_pty().  I've fixed this.

> > This seems excessive:
> >
> > +# allow setkey to read a config files in any directory.
> > +userdom_read_sysadm_home_content_files(setkey_t)
> > +userdom_read_all_users_home_content_files(setkey_t)
> >
> >   
> I guess we could label it differently, but this is a case similar to 
> semodule where a user might create a file that they need to process with 
> a confined domain. The problem is the confined domain is not allowed to 
> read it and this confuses the user. 

I can buy this for the sysadm's home content, but not unpriv users
content.

> > There is an addition which allows ricci_moservice_t to create an init
> > script, and it can already transition to initrc_t with init scripts
> > entrypoints.  Does it really need this?
> >
> >   
> ricci_modservice executes chkconfig under the covers and starts and 
> stops services.  So this is kind of what it is designed to do.  
> Basically you use the tool to turn on service scripts at different 
> runlevels and then start them.

Wouldn't the chkconfig part just be some symlink management?

> > Why?
> > +allow nmbd_t samba_log_t:file unlink;
> >
> >   
> I am not sure.  Lots of bugzillas in FC6.

It would be helpful if you could look through those to try to see why
this is happening.  We don't want daemons to delete their logs if it can
be helped.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
