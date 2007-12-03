Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB3FWnIB031975
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 10:32:49 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id lB3FWgbQ000513
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 15:32:43 GMT
Subject: RE: missing rules in newrole domain (RHEL5.1)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov, "Reed, Tim (US SSA)" <tim.reed@baesystems.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD0277351D@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02555890@blums0008.bluelnk.net>
	 <1196431864.4298.28.camel@gorn.columbia.tresys.com>
	 <FB39F4E77226B448BC1388D3BE4E00CD0277351D@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 10:32:29 -0500
Message-Id: <1196695950.25613.4.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-30 at 09:21 -0800, Clarkson, Mike R (US SSA) wrote:
> > -----Original Message-----
> > From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> > Sent: Friday, November 30, 2007 6:11 AM
> > To: Clarkson, Mike R (US SSA)
> > Cc: selinux@tycho.nsa.gov
> > Subject: Re: missing rules in newrole domain (RHEL5.1)
> > 
> > On Thu, 2007-11-29 at 17:49 -0800, Clarkson, Mike R (US SSA) wrote:
> > > I recently switched from a targeted-mls policy to the RHEL5.1 mls
> > > policy. I found that "newrole -r sysadm" failed in enforcing mode,
> even
> > > though my selinux user was "root".
> > >
> > > I had to add "files_search_default(newrole_t)" and
> > > "files_getattr_default_dirs(newrole_t)" to the selinuxutil.te file
> to
> > > allow newrole to getattr and search the /tmp-inst directory (type
> > > default_t).
> > >
> > > This was happening even with the read_default_t boolean set to true.
> > >
> > > Here are the avc denial messages that I was getting:
> > >
> > > type=AVC msg=audit(1196385320.559:722): avc:  denied  { getattr }
> for
> > > pid=5092 comm="newrole" path="/tmp-inst" dev=sda1 ino=5341337
> > > scontext=root:staff_r:newrole_t:s0-s4:c0.c255
> > > tcontext=system_u:object_r:default_t:s0 tclass=dir
> > >
> > > type=AVC msg=audit(1196385320.559:723): avc:  denied  { search } for
> > > pid=5092 comm="newrole" name="tmp-inst" dev=sda1 ino=5341337
> > > scontext=root:staff_r:newrole_t:s0-s4:c0.c255
> > > tcontext=system_u:object_r:default_t:s0 tclass=dir
> > >
> > > I'm assuming this should have worked out of the box without having
> to
> > > add these rules. Is there some configuration step that I missed?
> > 
> > It just means that you newroled while you were in this directory.
> > Newrole doesn't utilize read_default_t because we don't want
> privileged
> > programs like newrole accessing random default_t objects.
> 
> This happens regardless of the directory in which I am located when I
> use newrole. Newrole needs these because we have set up
> polyinstantiation of the /tmp directory. The instance directories which
> newrole binds to the /tmp directory are located in the /tmp-inst
> directory. 

If thats the case, then it should be labeled tmp_t too.  If this is a
default location for /tmp instances, then we can get this into the
policy (I thought instances were hidden dirs under /tmp).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
