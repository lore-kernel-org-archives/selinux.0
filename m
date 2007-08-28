Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SCxAxX030118
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 08:59:10 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SCx8bH017347
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 12:59:09 GMT
In-Reply-To: <50C59BF9-3A4B-4BC2-8F78-F0CFC68592D7@sf-net.com>
References: <50C59BF9-3A4B-4BC2-8F78-F0CFC68592D7@sf-net.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3A263A5A-F7A7-4A40-B066-C0A4B56386C8@sf-net.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: [refpolicy] dovecot: handling of hard links
Date: Tue, 28 Aug 2007 14:59:02 +0200
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oh I forgot the only thing which doesn't really run quit fine is init  
now:

avc:  denied  { unlink } for  pid=1175 comm="rm" name="ssl- 
parameters.dat" dev=hda7 ino=2129980  
scontext=system_u:system_r:initrc_t:s0  
tcontext=system_u:object_r:dovecot_var_lib_t:s0 tclass=file

Because formerly it was labeled as dovecot_var_run_t which was of  
files_pid_file(dovecot_var_run_t)

On 28.08.2007, at 14:26, Stefan Schulze Frielinghaus wrote:

> dovecot uses a hard link:
>
> /var/lib/dovecot/ssl-parameters.dat
> /var/run/dovecot/login/ssl-parameters.dat
>
> and the policy file looks like that:
>
> /var/run/dovecot(-login)?(/.*)?	gen_context 
> (system_u:object_r:dovecot_var_run_t,s0)
> /var/lib/dovecot(/.*)?			gen_context 
> (system_u:object_r:dovecot_var_lib_t,s0)
>
> While relabel:
>
> $ fixfiles relabel
>
> ...
> matchpathcon_filespec_add:  conflicting specifications for /var/run/ 
> dovecot/login/ssl-parameters.dat and /var/lib/dovecot/ssl- 
> parameters.dat, using system_u:object_r:dovecot_var_run_t:s0.
> ....
>
> Since the comment in the policy dovecot.te the file should be  
> labeled dovecot_var_lib_t but fixfiles relabels it as  
> dovecot_var_run_t. Attached is a patch which solves this.
>
> PS: tested on CentOS5
>
> <dovecot.fc.patch>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
