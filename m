Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUHQChj018860
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 12:26:12 -0500
Received: from dmzmta102.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAUHQAEA000644
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 17:26:10 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id lAUHO6Ig003744
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 12:24:06 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: missing rules in newrole domain (RHEL5.1)
Date: Fri, 30 Nov 2007 09:21:56 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD0277351D@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02555890@blums0008.bluelnk.net> <1196431864.4298.28.camel@gorn.columbia.tresys.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: <selinux@tycho.nsa.gov>, "Reed, Tim \(US SSA\)" <tim.reed@baesystems.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> Sent: Friday, November 30, 2007 6:11 AM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: missing rules in newrole domain (RHEL5.1)
> 
> On Thu, 2007-11-29 at 17:49 -0800, Clarkson, Mike R (US SSA) wrote:
> > I recently switched from a targeted-mls policy to the RHEL5.1 mls
> > policy. I found that "newrole -r sysadm" failed in enforcing mode,
even
> > though my selinux user was "root".
> >
> > I had to add "files_search_default(newrole_t)" and
> > "files_getattr_default_dirs(newrole_t)" to the selinuxutil.te file
to
> > allow newrole to getattr and search the /tmp-inst directory (type
> > default_t).
> >
> > This was happening even with the read_default_t boolean set to true.
> >
> > Here are the avc denial messages that I was getting:
> >
> > type=AVC msg=audit(1196385320.559:722): avc:  denied  { getattr }
for
> > pid=5092 comm="newrole" path="/tmp-inst" dev=sda1 ino=5341337
> > scontext=root:staff_r:newrole_t:s0-s4:c0.c255
> > tcontext=system_u:object_r:default_t:s0 tclass=dir
> >
> > type=AVC msg=audit(1196385320.559:723): avc:  denied  { search } for
> > pid=5092 comm="newrole" name="tmp-inst" dev=sda1 ino=5341337
> > scontext=root:staff_r:newrole_t:s0-s4:c0.c255
> > tcontext=system_u:object_r:default_t:s0 tclass=dir
> >
> > I'm assuming this should have worked out of the box without having
to
> > add these rules. Is there some configuration step that I missed?
> 
> It just means that you newroled while you were in this directory.
> Newrole doesn't utilize read_default_t because we don't want
privileged
> programs like newrole accessing random default_t objects.

This happens regardless of the directory in which I am located when I
use newrole. Newrole needs these because we have set up
polyinstantiation of the /tmp directory. The instance directories which
newrole binds to the /tmp directory are located in the /tmp-inst
directory. 

If it desirable to not allow search and getattr on default_t directories
by newrole, then a different file context could be applied to the
/tmp-inst directory. So the question then would be in which module
should the file context rule be applied. Since this directory is used by
newrole for polyinstantiation, it seems to me the best place would be
the selinuxutil.fc file. Also, since this will be an issue for anyone
polyinstantiating the /tmp directory, it seems like it should come in
the policy out of the box.
> 
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
