Subject: Re: [PATCH] add version option to newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: Selinux@tycho.nsa.gov
In-Reply-To: <200602080934.33613.glommer@br.ibm.com>
References: <200602080934.33613.glommer@br.ibm.com>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 07:43:57 -0500
Message-Id: <1139402637.2872.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-08 at 09:34 -0200, Glauber de Oliveira Costa wrote:
> When trying to isolate a problem today, I missed a lot an version option (-v 
> or such). This simple patch adds such an option.
> 
> If it's of interest, such an option may be added to whole policycoreutils 
> package. (IMHO, it would be useful). With this possibility in mind, I decided 
> to  implement the version string in a separate version.h file, that could be 
> included by other packages too. 
> 
> Patch follows.

If we were going to do this, I'd auto-generate version.h from the
already existing VERSION file, or just have the Makefile add -DVERSION=
with the contents of the already existing VERSION file.  Otherwise, we
have to update both files.  And this would only tell you the upstream
base version, not the complete package version.  Why not just run rpm -q
-f /usr/bin/newrole?  And rpm -V -f /usr/bin/newrole to check that it is
unmodified from the package-provided version.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
