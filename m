Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3TEn2ZS016689
	for <selinux@tycho.nsa.gov>; Sun, 29 Apr 2007 10:49:02 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3TEn1JW015820
	for <selinux@tycho.nsa.gov>; Sun, 29 Apr 2007 14:49:01 GMT
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <79DD4F6A-4BD4-4FD7-BB00-C4B7705B4EF8@nall.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SE Linux <selinux@tycho.nsa.gov>
From: Joe Nall <joe@nall.com>
Subject: Does the MLS range in modular file context have to be raw?
Date: Sun, 29 Apr 2007 09:48:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In a modular policy context file

/var/opt/jcdx/ICM(/.*)?                 gen_context 
(system_u:object_r:jcdx_icm_var_t,s15:c0.c1023)

works, but

/var/opt/jcdx/ICM(/.*)?                 gen_context 
(system_u:object_r:jcdx_icm_var_t,SystemHigh)

does not with the following error during installation:

libsepol.mls_from_string: invalid MLS context SystemHigh
libsepol.mls_from_string: could not construct mls context structure
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert  
system_u:object_r:jcdx_icm_var_t:SystemHigh to sid
/etc/selinux/mls/contexts/files/file_contexts:  line 818 has invalid  
context system_u:object_r:jcdx_icm_var_t:SystemHigh
libsemanage.semanage_install_active: setfiles returned error code 1.
/usr/sbin/semodule:  Failed!

In both cases the creation of the .pp file works.

This concerns me because we have a number of daemons that run at  
labels other than SystemHigh. The raw context for these daemons must  
be hardcoded in the policy developers environment, which presumes we  
know the mapping on the target machine, which we don't.

We can work around this in the RPM spec file, creating the .fc files  
on the fly using the setrans.conf of the target machine and compiling  
during the installation, but this is complex and feels like we are  
working around a bug.

How can I specify a file context with a human readable label in a  
modular policy?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
