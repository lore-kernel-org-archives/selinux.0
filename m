Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3QJx99M025867
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 15:59:09 -0400
Received: from xcgca812.northgrum.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3QJx7vp008909
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 19:59:08 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: login error with strict modular ref pol in RHEL4
Date: Wed, 26 Apr 2006 15:58:55 -0400
Message-ID: <85A664F2F3F2D1409EE003C7D3D52EE4038A01F0@xcgoh901.northgrum.com>
From: "Dinardo, Michael \(Xetron\)" <Michael.Dinardo@ngc.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Okay, some progress...

I can log in as root from the console in permissive mode.  I am still
prompted to enter a security context.  If I enter system_r for role and
kernel_t for type, I am able to log in.  However, I still cannot log in
through gdm in permissive mode and cannot log in at all in enforcing
mode (through the console or gdm).  

What I did to get things working so far:

1. Installed the following (along with all other tools at
ftp://people.redhat.com/dwalsh/SELinux/RHEL4_MODULAR/i386/):
	selinux-policy-2.2.28-1.rhel4.src.rpm
	selinux-policy-2.2.28-1.rhel4.noarch.rpm
	selinux-policy-targeted-2.2.28-1.rhel4.noarch.rpm
2. Installed the source from /usr/src/redhat:
	rpmbuild -bp /usr/src/redhat/SPECS/selinux-policy.spec
	cd /usr/src/redhat/BUILD/serefpolicy-2.2.23
	make install-src
3. Moved the installed source files from /etc/selinux/refpolicy/src to
/etc/selinux/targeted/src
4. Renamed /etc/selinux/targeted to /etc/selinux/strict
5. Fixed compile-time errors and compiled strict policy as described in
my earlier email
6. Relabeled and rebooted.  

Am I setting up my environment correctly (steps 1-4 above)?  Is there a
strict reference policy available for RHEL4 that I should install
instead of targeted (selinux-policy-targeted-2.2.28-1.rhel4.noarch.rpm)
in step 1?

Thanks,
Mike.	



-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Dinardo, Michael (Xetron)
Sent: Wednesday, April 26, 2006 11:19 AM
To: Daniel J Walsh
Cc: selinux@tycho.nsa.gov
Subject: RE: login error with strict modular ref pol in RHEL4

I tried relabeling the file system (as described) but am still receiving
the same error.
 

-----Original Message-----
From: Daniel J Walsh [mailto:dwalsh@redhat.com]
Sent: Wednesday, April 26, 2006 8:01 AM
To: Dinardo, Michael (Xetron)
Cc: selinux@tycho.nsa.gov
Subject: Re: login error with strict modular ref pol in RHEL4

Dinardo, Michael (Xetron) wrote:
>
> Hi list,
>
> I am having trouble logging in after building and loading strict 
> modular reference policy in RHEL4.  Just wondering if anyone else has
> encountered this and might have a suggestion on how to fix.   
>
> I cannot log in (even if I boot in permissive mode) once the system 
> boots.  This is for both run level 3 and 5.  Run level 1 is fine.  My 
> selinux toolchain and policy source are from 
> _ftp://people.redhat.com/dwalsh/SELinux-RHEL4_MODULAR_.  The messages 
> I am receiving when attempting graphical and console logins are as
> follows:
>
> GRAPHICAL LOGIN MESSAGE:
> Error! Unable to set executable context
>
> CONSOLE LOGIN DIALOGS:
> login: root
> password: *******
> Would you like to enter a security context? [y] Y
> role: sysadm_r
> type: sysadm_t
> Not a valid security context.
>
> After telling me I have entered an invalid security context the system

> brings me back to the initial login screen.  I've tried many 
> variations of role/type at the above login prompt to no avail.  Does 
> this mean I just need to set up proper security contexts for my users?

> Or, could it be that I am missing some type of user security context 
> file?  Has anyone else encountered this type of error?
>
> Thanks,
> Mike.
>
This looks more likely that you have a labeling problem.  If you boot
with the kernel parameter "autorelabel", or if you log in in permissive
mode and execute:

touch /.autorelabel
reboot


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
