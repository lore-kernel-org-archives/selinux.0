Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8ACfo46009032
	for <selinux@tycho.nsa.gov>; Mon, 10 Sep 2007 08:41:50 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8ACflgQ013223
	for <selinux@tycho.nsa.gov>; Mon, 10 Sep 2007 12:41:48 GMT
Subject: Re: [refpolicy] dovecot: handling of hard links
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <078A8F60-104A-4508-BFF7-47F0665B8C8F@sf-net.com>
References: <50C59BF9-3A4B-4BC2-8F78-F0CFC68592D7@sf-net.com>
	 <3A263A5A-F7A7-4A40-B066-C0A4B56386C8@sf-net.com>
	 <1189105767.3664.40.camel@gorn>
	 <03970691-89EF-41A5-B14C-70CBF0681056@sf-net.com>
	 <1189166600.3664.44.camel@gorn>
	 <078A8F60-104A-4508-BFF7-47F0665B8C8F@sf-net.com>
Content-Type: text/plain
Date: Mon, 10 Sep 2007 08:40:21 -0400
Message-Id: <1189428021.13435.22.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-07 at 15:52 +0200, Stefan Schulze Frielinghaus wrote:
> On 07.09.2007, at 14:03, Christopher J. PeBenito wrote:
> 
> > On Fri, 2007-09-07 at 13:32 +0200, Stefan Schulze Frielinghaus wrote:
> >> On 06.09.2007, at 21:09, Christopher J. PeBenito wrote:
> >>
> >>> On Tue, 2007-08-28 at 14:59 +0200, Stefan Schulze Frielinghaus  
> >>> wrote:
> >>>> Oh I forgot the only thing which doesn't really run quit fine is  
> >>>> init
> >>>> now:
> >>>>
> >>>> avc:  denied  { unlink } for  pid=1175 comm="rm" name="ssl-
> >>>> parameters.dat" dev=hda7 ino=2129980
> >>>> scontext=system_u:system_r:initrc_t:s0
> >>>> tcontext=system_u:object_r:dovecot_var_lib_t:s0 tclass=file
> >>>>
> >>>> Because formerly it was labeled as dovecot_var_run_t which was of
> >>>> files_pid_file(dovecot_var_run_t)
> >>>
> >>> So this hardlink is recreated every time dovecot is started?  If
> >>> so, you
> >>> should add in an interface for deleting this file, and then a  
> >>> rule for
> >>> initrc_t.
> >>
> >> Yes and No. This file is created by the master process of dovecot and
> >> after a specific time the file is altered again and again by the
> >> master process. I would suggest to add a dontaudit rule for initrc_t
> >> because only dovecot needs real manage perms. The file itself
> >> contains parameters for Diffie Hellman key exchange so initrc_t
> >> doesn't need to touch this file. Attached is a patch which solves  
> >> this.
> >
> > This hardlink really sounds like a broken behavior to me.
> 
> I checked the source rpm of RHEL5server and even the spec files says  
> on line 174:
> 
> if ! test -f /var/run/dovecot/login/ssl-parameters.dat; then
>      dovecot --build-ssl-parameters &>/dev/null
> fi
> 
> And when dovecot gets started without the ssl-parameters file  
> available it will build it in the directory /var/lib/dovecot and hard  
> link it to /var/run/dovecot/login. Here is an extract from the  
> dovecot changelog (v1.0.rc2 2006-07-04):
> 
> When copying ssl-parameters.dat file from /var/lib to /var/run its  
> permissions went wrong if it couldn't be copied with hard linking.
> 
>   I agree that the hard link is a little bit ugly but if you want a  
> working dovecot installation out of the box the file /var/lib/dovecot/ 
> ssl-parameters.dat and the hard link /var/run/dovecot/login/ssl- 
> parameters.dat need to be manageable by dovecot (not only the file  
> even the directory where they exist in).

Sorry, the comment wasn't meant to say that I wouldn't accept it, since
it would break dovecot.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
