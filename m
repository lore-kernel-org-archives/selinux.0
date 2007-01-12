Subject: Re: [RFC] clarifications for -l to newrole.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Klaus Weidner <klaus@atsec.com>
In-Reply-To: <45A7B520.5090405@us.ibm.com>
References: <45A6A064.2040707@us.ibm.com>
	 <1168549320.7993.458.camel@moss-spartans.epoch.ncsc.mil>
	 <45A6D0A1.6020301@us.ibm.com>
	 <1168614985.7993.494.camel@moss-spartans.epoch.ncsc.mil>
	 <45A7B520.5090405@us.ibm.com>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 16:52:48 -0500
Message-Id: <1168638769.7993.604.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-12 at 10:19 -0600, Michael C Thompson wrote:
> Stephen Smalley wrote:
> <snip>
> > Looks sane as far as content is concerned, although I don't understand
> > the author ordering (I'd typically expect alphabetically by last name or
> > by amount of involvement or by date of involvement).  But it doesn't
> > apply (whitespace damage) for me.   Also, please make the patch -p1
> > appliable from the top of the tree, e.g. result of svn diff
> > policycoreutils.
> 
> I've reordered the authors in alphabetical order, and re-patched with -p1.

Still whitespace damaged. See:
http://mbligh.org/linuxdocs/Email/Clients/Thunderbird

Or just attach it.

BTW, newrole.c also has an Authors list in the comments, so either needs
to be updated or dropped.

> 
> Thanks,
> Mike
> 
> ---
> 
> --- policycoreutils-1.33.12.orig/newrole/newrole.1      2007-01-11 
> 13:01:39.000000000 -0600
> +++ policycoreutils-1.33.12/newrole/newrole.1   2007-01-12 
> 10:15:14.000000000 -0600
> @@ -57,16 +57,45 @@
>   .B --version
>   shows the current version of newrole
>   .PP
> +.SH EXAMPLE
> +.br
> +Changing role:
> +   # id -Z
> +   staff_u:staff_r:staff_t:SystemLow-SystemHigh
> +   # newrole -r sysadm_r
> +   # id -Z
> +   staff_u:sysadm_r:sysadm_t:SystemLow-SystemHigh
> +
> +Changing sensitivity only:
> +   # id -Z
> +   staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
> +   # newrole -l Secret
> +   # id -Z
> +   staff_u:sysadm_r:sysadm_t:Secret-SystemHigh
> +
> +.PP
> +Changing sensitivity and clearance:
> +   # id -Z
> +   staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
> +   # newrole -l Secret-Secret
> +   # id -Z
> +   staff_u:sysadm_r:sysadm_t:Secret
> +
>   .SH FILES
>   /etc/passwd - user account information
>   .br
>   /etc/shadow - encrypted passwords and age information
> +.br
> +/etc/selinux/<policy>/contexts/default_type - default types for roles
> +.br
>   .SH SEE ALSO
> -.B su
> -(1),
> -.B runas
> +.B runcon
>   (1)
>   .SH AUTHORS
>   .nf
> -Tim Fraser (tfraser@tislabs.com)
> -Anthony Colatrella (amcolat@epoch.ncsc.mil)
> +Anthony Colatrella
> +Tim Fraser
> +Steve Grubb <sgrubb@redhat.com>
> +Darrel Goeddel <DGoeddel@trustedcs.com>
> +Michael Thompson <mcthomps@us.ibm.com>
> +Dan Walsh <dwalsh@redhat.com>
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
