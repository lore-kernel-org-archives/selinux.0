Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86JAmUb016779
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 15:10:48 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l86JAlOd023792
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 19:10:47 GMT
Subject: Re: [refpolicy] dovecot: handling of hard links
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <3A263A5A-F7A7-4A40-B066-C0A4B56386C8@sf-net.com>
References: <50C59BF9-3A4B-4BC2-8F78-F0CFC68592D7@sf-net.com>
	 <3A263A5A-F7A7-4A40-B066-C0A4B56386C8@sf-net.com>
Content-Type: text/plain
Date: Thu, 06 Sep 2007 15:09:27 -0400
Message-Id: <1189105767.3664.40.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-28 at 14:59 +0200, Stefan Schulze Frielinghaus wrote:
> Oh I forgot the only thing which doesn't really run quit fine is init  
> now:
> 
> avc:  denied  { unlink } for  pid=1175 comm="rm" name="ssl- 
> parameters.dat" dev=hda7 ino=2129980  
> scontext=system_u:system_r:initrc_t:s0  
> tcontext=system_u:object_r:dovecot_var_lib_t:s0 tclass=file
> 
> Because formerly it was labeled as dovecot_var_run_t which was of  
> files_pid_file(dovecot_var_run_t)

So this hardlink is recreated every time dovecot is started?  If so, you
should add in an interface for deleting this file, and then a rule for
initrc_t.

> On 28.08.2007, at 14:26, Stefan Schulze Frielinghaus wrote:
> 
> > dovecot uses a hard link:
> >
> > /var/lib/dovecot/ssl-parameters.dat
> > /var/run/dovecot/login/ssl-parameters.dat
> >
> > and the policy file looks like that:
> >
> > /var/run/dovecot(-login)?(/.*)?	gen_context 
> > (system_u:object_r:dovecot_var_run_t,s0)
> > /var/lib/dovecot(/.*)?			gen_context 
> > (system_u:object_r:dovecot_var_lib_t,s0)
> >
> > While relabel:
> >
> > $ fixfiles relabel
> >
> > ...
> > matchpathcon_filespec_add:  conflicting specifications for /var/run/ 
> > dovecot/login/ssl-parameters.dat and /var/lib/dovecot/ssl- 
> > parameters.dat, using system_u:object_r:dovecot_var_run_t:s0.
> > ....
> >
> > Since the comment in the policy dovecot.te the file should be  
> > labeled dovecot_var_lib_t but fixfiles relabels it as  
> > dovecot_var_run_t. Attached is a patch which solves this.
> >
> > PS: tested on CentOS5
> >
> > <dovecot.fc.patch>
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
