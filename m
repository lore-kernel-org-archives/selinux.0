Subject: Re: oracle policy
From: rob myers <rob.myers@gtri.gatech.edu>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1185914486.3413.313.camel@rxm-581b.stl.gtri.gatech.edu>
References: <1177969059.1731.46.camel@rxm-581b.stl.gtri.gatech.edu>
	 <463B5A4B.2090004@redhat.com>
	 <1183415825.3413.66.camel@rxm-581b.stl.gtri.gatech.edu>
	 <468A888C.1050404@redhat.com>
	 <1185914486.3413.313.camel@rxm-581b.stl.gtri.gatech.edu>
Content-Type: text/plain
Date: Tue, 31 Jul 2007 19:18:02 -0400
Message-Id: <1185923882.21438.3.camel@rxm-581b.stl.gtri.gatech.edu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-31 at 16:41 -0400, rob myers wrote: 
> On Tue, 2007-07-03 at 13:34 -0400, Daniel J Walsh wrote: 
> > rob myers wrote:
> > >
> > > i'm not sure what you mean by breaking the helper apps and writing
> > > policy for their specific tasks.  could you refer me to an example or
> > > explain a bit more?
> > >   
> > If you look at postfix, you will see a good example.  The idea of least 
> > privs is to give an app the least privs it needs to do a job.
> > 
> > As an example if your oracle app needed r/w access to the disk in order 
> > to format it in a particular way, and the way it did this was to exec
> > /usr/bin/oracle_disk_format  You could give oracle_t 
> > fixed_disk_device_t:blk_file manage_blk_device_t; Or you could generate 
> > a policy for oracle_disk_format_t,
> > and only give the helper app that permission.   Oracle would only be 
> > able to format the disk through the execing of the helper app.
> 
> ok, that makes sense.  the attached policy is a rewrite that attempts to
> implement this suggestion.  feedback is always appreciated.

this patch might help, too.

--- oracle.te.orig	2007-07-31 19:12:11.000000000 -0400
+++ oracle.te	2007-07-31 19:12:46.000000000 -0400
@@ -48,9 +48,10 @@ allow oracle_db_t oracle_dbfile_t:file {
 allow oracle_db_t oracle_dbfile_t:dir { create_dir_perms };
 
 # Automatically transition to the correct domain
+domain_auto_trans(oracle_sqlplus_t, oracle_db_exec_t, oracle_db_t)
+domain_auto_trans(oracle_lsnrctl_t, oracle_tnslsnr_exec_t, oracle_tnslsnr_t)
+
 ifdef(`targeted_policy', `
-    domain_auto_trans(oracle_sqlplus_t, oracle_db_exec_t, oracle_db_t)
-    domain_auto_trans(oracle_lsnrctl_t, oracle_tnslsnr_exec_t, oracle_tnslsnr_t)
     domain_auto_trans(unconfined_t, oracle_sqlplus_exec_t, oracle_sqlplus_t)
     domain_auto_trans(unconfined_t, oracle_lsnrctl_exec_t, oracle_lsnrctl_t)
 ')

kind regards.

rob.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
