Subject: Re: Changes to policycoreutils.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <441B2C7B.7050307@redhat.com>
References: <441B2C7B.7050307@redhat.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 16:26:53 -0500
Message-Id: <1142890013.16487.209.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-17 at 16:39 -0500, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.30/semanage/seobject.py
> --- nsapolicycoreutils/semanage/seobject.py	2006-03-10 09:48:05.000000000 -0500
> +++ policycoreutils-1.30/semanage/seobject.py	2006-03-17 15:37:21.000000000 -0500
> @@ -549,7 +548,7 @@
>  				raise ValueError("Could not list roles for user %s" % name)
>  
>  			roles = string.join(rlist, ' ');
> -			ddict[semanage_user_get_name(u)] = (semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
> +			ddict[semanage_user_get_name(u)] = (semanage_user_get_prefix(u), semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
>  
>  		return ddict
>  
> @@ -559,10 +558,10 @@
>  		keys.sort()
>  		if is_mls_enabled == 1:
>  			if heading:
> -				print "\n%-15s %-10s %-30s" % ("", "MLS/", "MLS/")
> -				print "%-15s %-10s %-30s %s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
> +				print "\n%-15s %-10s %-10s %-30s" % ("", "Labeling", "MLS/", "MLS/")
> +				print "%-15s %-10s %-10s %-30s %s\n" % ("SELinux User", "Prefix", "MCS Level", "MCS Range", "SELinux Roles")
>  			for k in keys:
> -				print "%-15s %-10s %-30s %s" % (k, translate(ddict[k][0]), translate(ddict[k][1]), ddict[k][2])
> +				print "%-15s %-10s %-10s %-30s %s" % (k, ddict[k][0], translate(ddict[k][1]), translate(ddict[k][2]), ddict[k][3])
>  		else:
>  			if heading:
>  				print "%-15s %s\n" % ("SELinux User", "SELinux Roles")

Merged this part of the diff (Ivan's earlier patch for semanage user -l
to display labeling prefixes).  However, he noted two concerns with it:
1) very long lines in the display, and 2) use of get_all by chcat could
be broken by this kind of change within seobject.py.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
