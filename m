Message-ID: <491B4354.1090204@manicmethod.com>
Date: Wed, 12 Nov 2008 15:57:56 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] semanage:  Use semanage_mls_enabled
References: <1226349176.8814.62.camel@moss-spartans.epoch.ncsc.mil> <1226501006.21407.9.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1226501006.21407.9.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Change semanage/seobject to use semanage_mls_enabled() rather than
> is_selinux_mls_enabled().  I dropped the mls enabled tests altogether
> from the semanage front-end script since setting up a handle is done by
> seobject.py; if those checks are actually important, we could move them
> inside of the seobject methods, but I'm not clear on the real benefit of
> those checks.  In seobject.py, I moved the setting of the is_mls_enabled
> variable inside of get_handle(store) after the connect.  I also dropped
> the is_mls_enabled test from setransRecords since no handle/connection
> exists there (since translations are not managed via libsemanage), and
> again I'm not clear that the check there was overly important/useful.
>
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
>
> diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
> index c34e594..eb0ac34 100644
> --- a/policycoreutils/semanage/semanage
> +++ b/policycoreutils/semanage/semanage
> @@ -38,8 +38,6 @@ except IOError:
>         import __builtin__
>         __builtin__.__dict__['_'] = unicode
>  
> -is_mls_enabled=selinux.is_selinux_mls_enabled()
> -
>  if __name__ == '__main__':
>  
>  	def usage(message = ""):
> @@ -270,16 +268,12 @@ Object-specific Options (see above):
>  				store = a
>  
>  			if o == "-r" or o == '--range':
> -				if is_mls_enabled == 0:
> -                                       raise ValueError(_("range not supported on Non MLS machines"))
>  				serange = a
>  
>  			if o == "-l" or o == "--list":
>  				list = True
>  
>  			if o == "-L" or o == '--level':
> -				if is_mls_enabled == 0:
> -                                       raise ValueError(_("range not supported on Non MLS machines"))
>  				selevel = a
>  
>  			if o == "-p" or o == '--proto':
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
> index c5379ac..8bf188a 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -35,14 +35,13 @@ except IOError:
>         import __builtin__
>         __builtin__.__dict__['_'] = unicode
>  
> -is_mls_enabled = selinux.is_selinux_mls_enabled()
> -
>  import syslog
>  
>  handle = None
>  
>  def get_handle(store):
>         global handle
> +       global is_mls_enabled
>  
>         handle = semanage_handle_create()
>         if not handle:
> @@ -63,7 +62,13 @@ def get_handle(store):
>         rc = semanage_connect(handle)
>         if rc < 0:
>                semanage_handle_destroy(handle)
> -              raise ValueError(_("Could not establish semanage connection"))       
> +              raise ValueError(_("Could not establish semanage connection"))
> +
> +       is_mls_enabled = semanage_mls_enabled(handle)
> +       if is_mls_enabled < 0:
> +              semanage_handle_destroy(handle)
> +              raise ValueError(_("Could not test MLS enabled status"))
> +
>         return handle
>  
>  file_types = {}
> @@ -192,8 +197,6 @@ def untranslate(trans, prepend = 1):
>  	
>  class setransRecords:
>  	def __init__(self):
> -		if not is_mls_enabled:
> -			raise ValueError(_("translations not supported on non-MLS machines"))			
>  		self.filename = selinux.selinux_translations_path()
>  		try:
>  			fd = open(self.filename, "r")
>
>   

Looks good to me


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
