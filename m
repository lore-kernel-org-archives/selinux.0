Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j13FSA53000776
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 10:28:10 -0500 (EST)
Received: from mx-3.zoominternet.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j13FSCf1004182
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 15:28:12 GMT
Subject: Re: FC3, Apache and CGI web app
From: Scott Cain <cain@cshl.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42023A75.7050501@redhat.com>
References: <1107378461.3351.62.camel@localhost.localdomain>
	 <42016640.3050807@redhat.com>
	 <1107405040.3391.17.camel@localhost.localdomain>
	 <42023A75.7050501@redhat.com>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 10:25:27 -0500
Message-Id: <1107444327.3307.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dan,

That fixed it for the case for where disabled is set.  About reading
from /tmp, I am reasonably sure that nowhere in the cgi do we do that.
What we do that is similar however is read from a
directory, /var/www/html/gbrowse/tmp, which is created by root during
the installation and made world read and writable.  I'm guessing that is
also considered dangerous.  If I change the installer to chown to apache
and then make it writeable only by apache, would that make the problem
go away?

Thanks,
Scott


On Thu, 2005-02-03 at 09:51 -0500, Daniel J Walsh wrote:
> Scott Cain wrote:
> 
> >On Wed, 2005-02-02 at 18:46 -0500, Daniel J Walsh wrote:
> >  
> >
> >>Scott Cain wrote:
> >>    
> >>
> >>>[...snip...]
> >>>
> >>>      
> >>>
> >>First make sure you have the latest policy, via yum
> >>
> >>yum update selinux-policy-targeted
> >>
> >>    
> >>
> >Check!
> >
> >  
> >
> >>Next make sure httpd_unified is set
> >>
> >>setsebool -P httpd_unified 1
> >>    
> >>
> >
> >Check; # sudo cat /etc/selinux/targeted/booleans
> >allow_ypbind=1
> >dhcpd_disable_trans=0
> >httpd_disable_trans=1
> >httpd_enable_cgi=1
> >httpd_enable_homedirs=1
> >httpd_ssi_exec=1
> >httpd_tty_comm=1
> >httpd_unified=1
> >mysqld_disable_trans=0
> >named_disable_trans=0
> >named_write_master_zones=0
> >nscd_disable_trans=0
> >ntpd_disable_trans=0
> >portmap_disable_trans=0
> >postgresql_disable_trans=0
> >snmpd_disable_trans=0
> >squid_disable_trans=0
> >syslogd_disable_trans=0
> >winbind_disable_trans=0
> >ypbind_disable_trans=0
> >
> >  
> >
> >>Now try it.
> >>    
> >>
> >
> >Check (and I restarted httpd, to answer Colin's question)
> >  
> >
> >>Look for AVC messages in /var/log/messages which will tell you what is 
> >>being denied.
> >>http://fedora.redhat.com/docs/selinux-apache-fc3/
> >>has a lot of information on settingup apache and SElinux.
> >>    
> >>
> >
> >Here we go from /var/log/messages:
> >Feb  2 23:23:13 localhost kernel: audit(1107404593.566:0): avc:  denied
> >{ read } for  pid=3792 exe=/usr/bin/perl name=tmp dev=hda2 ino=4243590
> >scontext=root:system_r:httpd_sys_script_t
> >tcontext=system_u:object_r:tmp_t tclass=lnk_file
> >
> >  
> >
> You would have to write policy at this point.  Allowing scripts to read 
> sym links off of /tmp would
> be considered dangerous. 
> 
> But this would a bug, since you have httpd_disable_trans set to 1, you 
> should not be running as httpd_sys_script_t.
> 
> selinux-policy-targeted-1.17.30-2.76 Will prevent this transition.
> 
> I have put out a version on
> ftp://people.redhat.com/dwalsh/SELinux/FC3 
> 
> This will go into Fedora-testing tonight.  Please try it out and see if 
> it fixes the transition problem.  IE your scripts should be running under
> unconfined_t.
> 
> 
> Dan
> 
> 
> >So what can I do to make this work?
> >
> >Thanks,
> >Scott
> >
> >  
> >
> >>Dan
> >>
> >>
> >>    
> >>
> 
> 
-- 
------------------------------------------------------------------------
Scott Cain, Ph. D.                                         cain@cshl.org
GMOD Coordinator (http://www.gmod.org/)                     216-392-3087
Cold Spring Harbor Laboratory


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
