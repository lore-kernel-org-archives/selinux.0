Message-ID: <72222DC86846D411ABD300A0C9EB08A101524353@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>,
        SELinux@tycho.nsa.gov
Subject: RE: SELinux RPM Version
Date: Mon, 22 Apr 2002 07:19:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Friday, April 19, 2002 5:37 PM, Russell Coker wrote:

> >
> > /etc/selinux/policy	The main policy directory
> > If the directory does not exist then the rpm
> > packages will create it and install example policy files.
> >
> > /etc/selinux/setfiles	Same for the policy directory
> 
> The setfiles policy will be under the same directory in the 
> next upstream and  that's what I'm doing in my Debian package, 
> you may want to do the same.

Will make the change

> 
> > The example policy is installed
> > /usr/share/doc/selinux/examples/policy
> 
> I'm now using /usr/share/selinux/policy/default for the default.
> 
> > Flask files
> > /usr/lib/flask
> 
> What files?

access_vectors, initial_sids, and security_classes

> Here's my current locations:
> /usr/bin/chsid
> /usr/bin/schfn
> /usr/bin/schsh
> /usr/bin/load_policy
> /usr/bin/spasswd
> /usr/bin/checkpolicy
> /usr/bin/newrole
> /usr/bin/avc_toggle
> /usr/bin/lchsid
> /usr/bin/list_sids
> /usr/bin/chsidfs
> /usr/bin/avc_enforcing
> /usr/sbin/se_dpkg		
	Not included in the rpm version
> /usr/sbin/run_init		
	will change to this location
> /usr/sbin/setfiles		
	will change to this location
> /usr/sbin/se_apt-get
	What is this ?	
> /usr/sbin/se_dselect
 	What is this ?

> > All packages such as
> > fileutils-4.1-4
> >
> > have been renamed to
> >
> > fileutils-selinux-4.1-4
> >
> > This packages provides: fileutils
> 
> Currently I'm just using an incrementally higher version number for my 
> packages while determining whether the changes can go into 
> the main packages.


I am going to keep my naming method of the modified utilities. 
I think using a higher version number is confusing to an end user. I will
keep with <utility>-selinux-<version>-<release> naming convention.
I will add Obsoletes: to the rpm spec files and see if the --replacefiles
in needed for an install. 



Mark


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
