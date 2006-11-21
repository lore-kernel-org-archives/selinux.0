Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kALLsdpn019176
	for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 16:54:39 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kALLqx9d020605
	for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 21:52:59 GMT
Message-ID: <45637591.2070406@mentalrootkit.com>
Date: Tue, 21 Nov 2006 16:54:25 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] genhomedircon
References: <455C9EB3.5050602@us.ibm.com>
In-Reply-To: <455C9EB3.5050602@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael C Thompson wrote:
> I've noticed that genhomedircon does not have the proper return codes on 
> some error and success paths. This patch addresses these return codes as 
> follow:
> 
> * usage function by default returns 0, and the desired return code can 
> be specified via a parameter. This facilitates the fix to the current 
> behaviour that 1 is returned on 'genhomedircon -h'.
> 
> * I have noticed that as secadm (this is a bug? will start a separate 
> thread) fails to successfully call semanage_connect(). The result of 
> this operation is now checked, and the script will exit on error.
> 
> * If the attempt to write the homedir contexts out fails, a proper error 
> code will be returned (previously, 1 would be returned).
> 
> This also moves the parsing of /etc/shells to after the uid check for a 
> minimal time savings.
> 
> Thanks,
> Mike
> 
> Signed-of-by: Michael Thompson <mcthomps@us.ibm.com>
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Naur policycoreutils-1.33.1/scripts/genhomedircon policycoreutils-1.33.1.dev/scripts/genhomedircon
> --- policycoreutils-1.33.1/scripts/genhomedircon	2006-11-14 08:46:14.000000000 -0600
> +++ policycoreutils-1.33.1.dev/scripts/genhomedircon	2006-11-16 06:03:50.000000000 -0600
> @@ -29,17 +29,6 @@
>  import gettext
>  gettext.install('policycoreutils')
>  
> -try:
> -	fd = open("/etc/shells", 'r')
> -	VALID_SHELLS = fd.read().split("\n")
> -	fd.close()
> -	if "/sbin/nologin" in VALID_SHELLS:
> -		VALID_SHELLS.remove("/sbin/nologin")
> -	if "" in VALID_SHELLS:
> -		VALID_SHELLS.remove("")
> -except:
> -	VALID_SHELLS = ['/bin/sh', '/bin/bash', '/bin/ash', '/bin/bsh', '/bin/ksh', '/usr/bin/ksh', '/usr/bin/pdksh', '/bin/tcsh', '/bin/csh', '/bin/zsh']
> -
>  def grep(file, var):
>  	ret = ""
>  	fd = open(file, 'r')
> @@ -114,12 +103,13 @@
>  		return val
>  	return "targeted"
>  
> -def usage(error = ""):
> +def usage(rc=0, error = ""):
>  	if error != "":
>  		sys.stderr.write("%s\n" % error)
> +		rc = 1
>  	sys.stderr.write("Usage: %s [ -d selinuxdir ] [-n | --nopasswd] [-t selinuxtype ]\n" % sys.argv[0])
>  	sys.stderr.flush()
> -	sys.exit(1)
> +	sys.exit(rc)
>  
>  def warning(warning = ""):
>  	sys.stderr.write("%s\n" % warning)
> @@ -136,7 +126,9 @@
>  		self.semanageHandle = semanage_handle_create()
>  		self.semanaged = semanage_is_managed(self.semanageHandle)
>  		if self.semanaged:
> -			semanage_connect(self.semanageHandle)
> +			rc = semanage_connect(self.semanageHandle)
> +			if rc:
> +				errorExit("Unable to connect to semanage")
>  			(status, self.ulist) = semanage_user_list(self.semanageHandle)
>  		self.type = type
>  		self.selinuxdir = selinuxdir +"/"
> @@ -336,18 +328,25 @@
>  		print self.genoutput()
>  
>  	def write(self):
> -		try:
> -			fd = open(self.getFileContextDir()+"/file_contexts.homedirs", "w")
> -			fd.write(self.genoutput())
> -			fd.close()
> -		except IOError, error:
> -			sys.stderr.write("%s: %s\n" % ( sys.argv[0], error ))
> -
> +		fd = open(self.getFileContextDir()+"/file_contexts.homedirs", "w")
> +		fd.write(self.genoutput())
> +		fd.close()
>  
>  if os.getuid() > 0 or os.geteuid() > 0:
>  	print _("You must be root to run %s.") % sys.argv[0]
>  	sys.exit(1)
>  
> +try:
> +	fd = open("/etc/shells", 'r')
> +	VALID_SHELLS = fd.read().split("\n")
> +	fd.close()
> +	if "/sbin/nologin" in VALID_SHELLS:
> +		VALID_SHELLS.remove("/sbin/nologin")
> +	if "" in VALID_SHELLS:
> +		VALID_SHELLS.remove("")
> +except:
> +	VALID_SHELLS = ['/bin/sh', '/bin/bash', '/bin/ash', '/bin/bsh', '/bin/ksh', '/usr/bin/ksh', '/usr/bin/pdksh', '/bin/tcsh', '/bin/csh', '/bin/zsh']
> +
>  #
>  # This script will generate home dir file context
>  # based off the homedir_template file, entries in the password file, and
> @@ -369,15 +368,19 @@
>  			directory = a
>  		if o == '--help'  or o == "-h":
>  			usage()
> +except getopt.error, error:
> +	errorExit(_("Options Error %s ") % error)
>  
> +if type == None:
> +	type = getSELinuxType(directory)
>  
> -	if type == None:
> -		type = getSELinuxType(directory)
> +if len(cmds) != 0:
> +	usage(1)
>  
> -	if len(cmds) != 0:
> -		usage()
> -	selconf = selinuxConfig(directory, type, usepwd)
> +selconf = selinuxConfig(directory, type, usepwd)
> +try:
>  	selconf.write()
> +except IOError, error:
> +	sys.stderr.write("%s: %s\n" % ( sys.argv[0], error ))
> +	sys.exit(1)
>  
> -except getopt.error, error:
> -	errorExit(_("Options Error %s ") % error)

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
