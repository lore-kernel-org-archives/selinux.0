Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8OFnWrT018532
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 11:49:32 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8OFnVrq027303
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 15:49:31 GMT
Subject: Re: patch: clean up vmware
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <200409232314.25355.russell@coker.com.au>
References: <20040917224956.GA2517@jmh.mhn.de>
	 <200409232314.25355.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1096040908.21017.64.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 24 Sep 2004 11:48:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

I also added:

diff -u -r1.24 base_user_macros.te
--- macros/base_user_macros.te	22 Sep 2004 20:06:02 -0000	1.24
+++ macros/base_user_macros.te	24 Sep 2004 14:46:39 -0000
@@ -167,10 +167,7 @@
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
 
-ifdef(`vmware.te', `
-# probably should have a separate domain for each user
-file_type_auto_trans(vmware_user_t, $1_home_dir_t, vmware_user_file_t)
-')
+ifdef(`vmware.te', `vmware_domain($1)')
 
 if (user_direct_mouse) {
 # Read the mouse.

On Thu, 2004-09-23 at 09:14, Russell Coker wrote:
> On Sat, 18 Sep 2004 08:49, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
> wrote:
> > After reading through the messy vmware policy I decided to clean it up a
> > little. Result is below.
> 
> The changes are so great that patches don't work well.  I've made a few 
> modifications to your policy and attached an archive of it.
> 
> I think that defining vmware_t is a bad idea.  I think that we want 
> system_vmware_t to be used for vmware sessions launched by the server and 
> have the same base macro used as for user_vmware_t.
> 
> Your work is good and is a significant enough improvement to be worth merging 
> now.  But we need to go further to get the full functionality.
> 
> Also please keep in mind that some people may want to have multiple VMware 
> sessions isolated from each other which are launched from the same user role.  
> Maybe having two parameters to the vmware_domain() macro is the correct thing 
> to do, one to specify the source role and one part of the name for the target 
> domain.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
