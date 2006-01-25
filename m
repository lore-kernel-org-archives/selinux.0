Subject: Re: policycoreutils 1.29.10
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43D7A46C.7020605@redhat.com>
References: <1138044857.20815.142.camel@moss-spartans.epoch.ncsc.mil>
	 <1138193526.20815.309.camel@moss-spartans.epoch.ncsc.mil>
	 <43D7A46C.7020605@redhat.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 13:26:34 -0500
Message-Id: <1138213595.13075.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-25 at 11:16 -0500, Daniel J Walsh wrote:
> Here is my latest diff also, mainly  adding translation support to 
> semanage and cleaning up some of the error reporting.

> diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-1.29.10/semanage/semanage
> --- nsapolicycoreutils/semanage/semanage	2006-01-20 10:37:37.000000000 -0500
> +++ policycoreutils-1.29.10/semanage/semanage	2006-01-20 15:17:56.000000000 -0500
> -	-v, --verbose    verbose output\n\

The code still checks for -v and --verbose later and sets verbose = 1,
so that likely should be dropped too.

> +	def get_options():
> +		valid_option={}
> +		valid_everyone=[ '-a', '--add', '-d', '--delete', '-m', '--modify', '-l', '--list', '-h', '--help', '-n', '--noheading' ]
> +		valid_option["login"] = []
> +		valid_option["login"] += valid_everyone + [ '-s', '--seuser', '-r', '--range']
> +		valid_option["user"] = []
> +		valid_option["user"] += valid_everyone + [ '-L', '--level', '-r', '--range', '-R', '--roles' ] 
> +		valid_option["port"] = []
> +		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range'] 
> +		valid_option["port"] = []
> +		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--protocol' ] 

Cut-and-paste error - multiple definitions for "port"

> +		valid_option["interface"] = []
> +		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range'] 
> +		valid_option["fcontext"] = []
> +		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
> +		valid_option["translation"] = []
> +		valid_option["fcontext"] += valid_everyone + [ '-T', '--trans' ]

Cut-and-paste error - last one should be for "translation", right?

>  		gopts, cmds = getopt.getopt(args,
> -					    'adf:lhmnp:P:s:R:L:r:t:vT:',
> +					    'adf:lhmnp:s:R:L:r:t:vT:',

-v still listed here.


>  			if o == "-R" or o == '--roles':
> -				roles = roles + " " + a
> +				roles = a

Why?  Aggregating multiple role specs seemed nice.  Implementation
problem?

> +.I                \-R, \-\-role
> +SELinux Roles.  You must inclose multiple roles within quotes, separate by spaces.
> +.TP

Reverts Russell's change, which as he said seems more script-friendly
and user-friendly (aggregate multiple -R options together).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
