Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h54BsgI4021667
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 07:54:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h54Bs8ss013036
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 11:54:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h54Bs8hY013033
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 11:54:08 GMT
Subject: Re: file labels during init process
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200306041048.19435.carsten.grohmann@raumbildsysteme.de>
References: <200306041048.19435.carsten.grohmann@raumbildsysteme.de>
Content-Type: text/plain
Message-Id: <1054727665.2600.9.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 04 Jun 2003 07:54:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-06-04 at 04:48, Carsten Grohmann wrote:
> Today I found this log message:
> avc:  denied  { search } for  pid=1 exe=/sbin/init path=/var/log 
> dev=03:09 ino=6 scontext=system_u:system_r:init_t 
> tcontext=system_u:object_r:file_t tclass=dir
> 
> I have a problem with this entry. The complete filesystem is labeled 
> correct. The partition hda7 mounted as /var/log is also labled with 
> the correct type. Could it be that the init process access the 
> filesystem before the labels "grasp"?

No, I think that this reflects an attempt to access the /var/log mount
point directory (left in file_t, since it is covered by the mounted
directory by the time you run setfiles) before the partition has been
mounted.  If you drop into singleuser mode and unmount /var/log, you can
label it at that point if you want a particular type on it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
