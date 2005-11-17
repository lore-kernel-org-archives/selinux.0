Subject: Re: Audit2allow in python generates module code.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437CA2F6.4070603@redhat.com>
References: <437C0256.509@redhat.com>
	 <1132235886.17726.13.camel@moss-spartans.epoch.ncsc.mil>
	 <1132236399.17726.22.camel@moss-spartans.epoch.ncsc.mil>
	 <437CA2F6.4070603@redhat.com>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 11:08:27 -0500
Message-Id: <1132243707.17726.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-17 at 10:34 -0500, Daniel J Walsh wrote:
> Added -M which does
> 
> audit2allow -a -m local -o local.te
> checkmodule -M -m -o local.mod local.te
> semodule_package -o local.pp -m local.mod
> 
> And tells the user to do:
> semodule -i local.pp

# ./audit2allow -a -M local
Generating type enforcment file: local.te
Compiling policy: checkmodule -M -m -o local.mod local.te
./audit2allow: (unknown source)::ERROR 'syntax error' at token '' on line 235:
allow test_create_no_t self:process fork;
allow test_noioctl_t test_ioctl_file_t:file { getattr ioctl seta
checkmodule:  error(s) encountered while parsing configuration
checkmodule:  loading policy configuration from local.te

Line 235 of local.te is:
allow test_noioctl_t test_ioctl_file_t:file { getattr ioctl setattr };

Running checkmodule by hand yields:
# checkmodule -M -m -o local.mod local.te
checkmodule:  loading policy configuration from local.te
checkmodule:  policy configuration loaded
checkmodule:  writing binary representation (version 5) to local.mod

So I'm not clear on why it fails from audit2allow.

audit2allow -a -m local -o local.te no longer appears to be accepted:
# ./audit2allow -a -m local -o local.te
audit2allow [-adhilrv] [-i <inputfile> ] [[-m|-M] <modulename> ] [-o <outputfile>]
...

One other observation:  Use of -M by checkmodule needs to be selectable
in some manner, as not everyone will have a MLS-enabled policy (outside
of Fedora).  Ideally, audit2allow could just query whether MLS is
enabled via libsemanage.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
