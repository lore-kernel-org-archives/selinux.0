Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49FqExA019444
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 11:52:14 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49FqDa2005852
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 15:52:14 GMT
Date: Tue, 9 May 2006 11:52:11 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][SECMARK 05/08] Add new packet controls to SELinux
In-Reply-To: <1147174138.32651.5.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0605091146350.25693@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
 <Pine.LNX.4.64.0605071136100.8588@d.namei>  <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil>
  <Pine.LNX.4.64.0605081947400.19850@d.namei> <1147174138.32651.5.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 9 May 2006, Stephen Smalley wrote:

> > It doesn't seem warranted as a boot option and/or kernel config option as 
> > the desired behavior can be trivially selected during early boot.
> 
> I was thinking it would be helpful for distributions (example:  Fedora
> Core 4 and 5 re-base to 2.6.18, want the compatibility mode enabled by
> default, do not wish to update/add some new userspace component to
> trigger the compatibility mode).   And also for users to deal with
> mismatches between their kernels and userlands (example:  kernel
> developer using Fedora Core 5 as his development platform builds an
> upstream kernel and boots it, but FC5 userland has no knowledge of
> either the new checks or the compatibility mode, so it would be nice if
> he could enable the compatibility mode in his kernel config or select it
> trivially via boot param).  But I have no strong opinion; if no one else
> thinks it is necessary, that is fine.

The thing is that the old network controls will be going away at some 
point reasonably soon in the upstream kernel, and it seems wrong to add 
more than the minimally required infrastructure to support it.  Perhaps 
legacy distros which update their kernels but not their policy tools to 
match should patch this into the kernel themselves.  I don't think it 
belongs upstream.  The compat networking is for transition purposes only, 
and if the distro isn't going to transition, it's diverging from mainline 
and needs to carry that burden itself, not expect the mainline kernel to 
do so.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
