Subject: Re: make install fails if any users are in local.users
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1111007163.4150.5.camel@paris.rdu.redhat.com>
References: <1110672353.29153.2.camel@cobra.ivg2.net>
	 <4235BE2F.8020009@redhat.com> <1110821742.16850.14.camel@cobra.ivg2.net>
	 <42360347.1030105@redhat.com>  <1110838214.19525.1.camel@cobra.ivg2.net>
	 <1110864047.30167.8.camel@cobra.ivg2.net>
	 <1110979208.4802.45.camel@moss-spartans.epoch.ncsc.mil>
	 <1110983044.3914.24.camel@nexus.verbum.private>
	 <1110986633.4802.88.camel@moss-spartans.epoch.ncsc.mil>
	 <1111007163.4150.5.camel@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 12:36:38 -0500
Message-Id: <1111080998.8664.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-16 at 16:06 -0500, Eric Paris wrote:
> Attached is my latest genhomedircon which will actually check it against
> setfiles -c before writing to file_contexts.homedir.  I am also
> attaching the diff against Red Hat latest.  It will leave a broken
> file_contexts.homedir.tmp  if it didn't work.  So you can hopefully get
> more info about what went wrong.  Comments?

Thanks, merged with the minor diff below to fully specify the path to
setfiles.

Index: policycoreutils/scripts/genhomedircon
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/scripts/genhomedircon,v
retrieving revision 1.21
diff -u -r1.21 genhomedircon
--- policycoreutils/scripts/genhomedircon	17 Mar 2005 16:50:36 -0000	1.21
+++ policycoreutils/scripts/genhomedircon	17 Mar 2005 17:07:20 -0000
@@ -451,7 +451,7 @@
 			fd = open(self.getFileContextDir()+"/file_contexts.homedirs.tmp", "w")
 			fd.write(self.genoutput())
 			fd.close()
-			rc = commands.getstatusoutput('setfiles -c %s %s' % ((self.getBinaryPolicy()), (self.getFileContextDir()+"/file_contexts.homedirs.tmp")))
+			rc = commands.getstatusoutput('/usr/sbin/setfiles -c %s %s' % ((self.getBinaryPolicy()), (self.getFileContextDir()+"/file_contexts.homedirs.tmp")))
 			if rc[0] == 0:
 				rc = commands.getstatusoutput('mv -f %s %s' % ((self.getFileContextDir()+"/file_contexts.homedirs.tmp"),(self.getFileContextDir()+"/file_contexts.homedirs")))
 				if rc[0] != 0:

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
