Message-ID: <456C9017.1010903@tresys.com>
Date: Tue, 28 Nov 2006 14:37:59 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C7D9F@exchange.columbia.tresys.com> <4564AD82.5080300@redhat.com> <4564B3B1.2010509@tresys.com> <4564BF65.7040900@redhat.com>
In-Reply-To: <4564BF65.7040900@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>>> Fixes to make sure module name is all alphabet charaters.
>>>
> Added
>>
>> Still non-standard
>>
> Fine, I will go with your standard.
> 
> 
> ------------------------------------------------------------------------
> 
> diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-1.33.4/audit2allow/audit2allow
> --- nsapolicycoreutils/audit2allow/audit2allow	2006-11-16 17:14:29.000000000 -0500
> +++ policycoreutils-1.33.4/audit2allow/audit2allow	2006-11-22 16:16:37.000000000 -0500
> @@ -29,6 +29,7 @@
>  if __name__ == '__main__':
>  	import commands, sys, os, getopt, selinux
>          import gettext
> +	import re
>          try:
>                  gettext.install('policycoreutils')
>          except:
> @@ -59,6 +60,11 @@
>  			print msg
>  		sys.exit(1)
>  		
> +	def verify_module(module):
> +		m = re.findall("[^a-zA-Z0-9]", module)
> +		if len(m) != 0:
> +			usage(_("Alphanumeric Charaters Only"))
> +		
>  	def errorExit(error):
>  		sys.stderr.write("%s: " % sys.argv[0])
>  		sys.stderr.write("%s\n" % error)
> @@ -125,10 +131,12 @@
>  				if module != "" or a[0] == "-":
>  					usage()
>  				module = a
> +				verify_module(module)
>  			if o == "-M":
>  				if module != "" or output_ind  or a[0] == "-":
>  					usage()
>  				module = a
> +				verify_module(module)
>  				outfile = a+".te"
>  				buildPP = 1
>  				if not os.path.exists("/usr/bin/checkmodule"):
> @@ -184,22 +192,27 @@
>  		output.write(serules.out(requires, module))
>  		output.flush()
>  		if buildPP:
> -			cmd = "checkmodule %s -m -o %s.mod %s.te" % (get_mls_flag(), module, module)
> -			print _("Compiling policy")
> -			print cmd
> -			rc = commands.getstatusoutput(cmd)
> -			if rc[0] == 0:
> -				cmd = "semodule_package -o %s.pp -m %s.mod" % (module, module)
> -				if fc_file != "":
> -					cmd = "%s -f %s" % (cmd, fc_file)
> -					
> +			if ref_ind:
> +				rc, type = selinux.selinux_getpolicytype()
> +				cmd = "make -f /usr/share/selinux/%s/include/Makefile %s.pp" % (type, module)
> +				print _("Compiling policy")
> +				print cmd
> +				rc = commands.getstatusoutput(cmd)
> +			else:
> +				cmd = "checkmodule %s -m -o %s.mod %s.te" % (get_mls_flag(), module, module)
> +				print _("Compiling policy")
>  				print cmd
>  				rc = commands.getstatusoutput(cmd)
>  				if rc[0] == 0:
> -					print _("\n******************** IMPORTANT ***********************\n")
> -					print (_("In order to load this newly created policy package into the kernel,\nyou are required to execute \n\nsemodule -i %s.pp\n\n") % module)
> -				else:
> -					errorExit(rc[1])
> +					cmd = "semodule_package -o %s.pp -m %s.mod" % (module, module)
> +					if fc_file != "":
> +						cmd = "%s -f %s" % (cmd, fc_file)
> +					
> +					print cmd
> +					rc = commands.getstatusoutput(cmd)
> +			if rc[0] == 0:
> +				print _("\n******************** IMPORTANT ***********************\n")
> +				print (_("In order to load this newly created policy package into the kernel,\nyou are required to execute \n\nsemodule -i %s.pp\n\n") % module)
>  			else:
>  				errorExit(rc[1])
>  


Acked-By: Joshua Brindle <jbrindle@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
