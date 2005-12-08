Subject: Re: libsemanage patch to make seusers world readable.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux-dev@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <1133977698.2366.81.camel@moss-spartans.epoch.ncsc.mil>
References: <43971CDB.1070507@redhat.com>
	 <1133977698.2366.81.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 08:07:40 -0500
Message-Id: <1134047260.2366.149.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-07 at 12:48 -0500, Stephen Smalley wrote:
> On Wed, 2005-12-07 at 12:33 -0500, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-1.3.64/src/semanage_store.c
> --- nsalibsemanage/src/semanage_store.c	2005-11-16 08:44:47.000000000 -0500
> +++ libsemanage-1.3.64/src/semanage_store.c	2005-12-07 08:07:02.000000000 -0500
> @@ -917,6 +917,7 @@
>  		INFO(sh, "Non-fatal error:  Could not copy %s to %s.", active_seusers, store_seusers);
>  		/* Non-fatal; fall through */
>  	}
> +	chmod(store_seusers, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
>  
>  	if (!sh->do_reload)
>  		goto skip_reload;
> 
> Why does seusers need to be world readable?  Also, I think we would want
> to solve this more generally, e.g. file_contexts has a similar issue if
> you want it to remain useable by ordinary users for restorecon.

libsemanage needs a saner way of setting the modes on the files it
installs.  The installed files presently include the kernel policy file,
the file_contexts file, the homedir_template file, and the seusers file.
Options are:
- Create them world readable as far as DAC mode is concerned, but
restrict access via SELinux policy based on file contexts as desired.
That seems to be the situation prior to libsemanage, with targeted
policy allowing users to access them.
- Make the DAC mode configurable via semanage.conf.  In this case, we
need to decide whether a single mode is sufficient for all of the files
or if we want separate modes for different files (e.g.
kernel-policy=0600, file-contexts=0644, seusers=0644).

Also, it occurs to me that libsemanage doesn't presently do anything
about setting file contexts for these files, so they always just inherit
the default (parent directory type or transition type if one is defined
in policy).  I think that is currently ok since that is the current
labeling anyway for these files, but it could be a problem if we later
introduce distinct types for e.g. seusers.  Likely should be doing a
matchpathcon() and setfscreatecon() when creating the new file (or
setfilecon prior to renaming it into place, as long as it is adequately
protected while within the sandbox).

Thoughts?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
