Subject: Re: Changes to policycoreutils.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@namei.org>, Russell Coker <russell@coker.com.au>,
        Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1142891112.22881.12.camel@moss-spartans.epoch.ncsc.mil>
References: <441B2C7B.7050307@redhat.com>
	 <1142885461.16487.196.camel@moss-spartans.epoch.ncsc.mil>
	 <441F1D3B.1000003@redhat.com>
	 <1142891112.22881.12.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 08:56:40 -0500
Message-Id: <1142949400.28120.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-03-20 at 16:45 -0500, Stephen Smalley wrote:
> On Mon, 2006-03-20 at 16:23 -0500, Daniel J Walsh wrote:
> > Removed realpath stuff as well as LINK Handling.
> > 
> > Also added a check to make sure the file was not multiply linked.  If 
> > multiply linked it will syslog the failure.
> 
> diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/restorecond.c policycoreutils-1.30/restorecond/restorecond.c
> --- nsapolicycoreutils/restorecond/restorecond.c	1969-12-31 19:00:00.000000000 -0500
> +++ policycoreutils-1.30/restorecond/restorecond.c	2006-03-20 15:57:28.000000000 -0500
> <snip>
> +	if (lstat(filename, &st)!=0) return;
> +
> +	if (st.st_nlink > 1) {
> +		syslog(LOG_ERR,"Will not restore a file with more than one hard link (%s) %s\n", filename,strerror(errno));
> +		return;
> +	}
> +
> +	if (matchpathcon(filename, st.st_mode, &scontext) < 0) {
> +		if (errno == ENOENT)
> +			return;
> +		syslog(LOG_ERR,"matchpathcon(%s) failed %s\n", filename,strerror(errno));
> +		return;
> +	} 
> +	retcontext=lgetfilecon(filename,&prev_context);
> +	
> +	if (retcontext >= 0 || errno == ENODATA) {
> <snip>
> +			if (lsetfilecon(filename,scontext) < 0) {
> +
> 
> One obvious problem here is that the above sequence isn't necessarily
> acting on the same inode, so the file that is ultimately relabeled by
> lsetfilecon could still be a link to a different user's file.  An option
> for that problem is to use a open(..O_NOFOLLOW)+fstat+fgetfilecon
> +fsetfilecon+close sequence so that you are guaranteed to be operating
> on a single file throughout the sequence.  But this requires at least
> read permission to the file to be allowed to restorecond for the open()
> call, which is why we didn't take that approach in setfiles (as it would
> then require read access to all files).  restorecond is possibly
> operating on a much smaller set of files whose types can be
> enumerated/identified by an interface/attribute.

Also, your hard link check above will prevent relabeling of directories
altogether, right?  So you would need to at least distinguish the
S_IFDIR case.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
