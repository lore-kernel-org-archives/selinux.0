Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9ODm9EE023664
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2012 09:48:09 -0400
Message-ID: <5087ED62.5050605@redhat.com>
Date: Wed, 24 Oct 2012 09:30:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Moyer, Thomas - 0668 - MITLL" <thomas.moyer@ll.mit.edu>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Question about policy module error message
References: <CCAC6810.2205%thomas.moyer@ll.mit.edu>
In-Reply-To: <CCAC6810.2205%thomas.moyer@ll.mit.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/23/2012 03:28 PM, Moyer, Thomas - 0668 - MITLL wrote:
> I am trying to build an SELinux policy module for a piece of software I am 
> writing. I used sepolgen to create an initial skeleton policy (running on
> Red Hat Enterprise Linux 6). I get the following error when I try and
> install the policy:
> 
> sudo ./interface.sh Building and Loading Policy + make -f
> /usr/share/selinux/devel/Makefile make: Nothing to be done for `all'. +
> /usr/sbin/semodule -i interface.pp libsemanage.semanage_fc_sort: WARNING:
> semanage_fc_sort: Incomplete context. libsepol.sepol_context_from_string:
> malformed context "dnl" libsepol.sepol_context_from_string: could not
> construct context from string libsepol.context_from_string: could not
> create context structure libsepol.sepol_context_to_sid: could not convert
> dnl to sid invalid context dnl libsemanage.semanage_install_active:
> setfiles returned error code 1. /usr/sbin/semodule:  Failed!
> 
> Below is the interface.fc file since I think the error might be in there. 
> /usr/local/bin/interface--gen_context(system_u:object_r:interface_exec_t,s0)
>
> 
/usr/local/libexec/interfacegen_context(system_u:object_r:usr_t,s0)
> /usr/local/libexec/interface/WebApp.jar--gen_context(system_u:object_r:httpd_sys_content_t,s0)
>
> 
/usr/local/libexec/interface/keystore--gen_context(system_u:object_r:interfaceKey_t,s0)
> /usr/local/libexec/interface/ui-files(/.*)?gen_context(system_u:object_r:httpd_sys_content_t,s0)
>
>  Not sure how to go about debugging this.
> 
> Thanks for the help.
> 
> -Tom
> 
> -- Thomas Moyer, Technical Staffvoice: (781) 981-1374 Cyber Systems
> Technology Groupmobile: (857) 268-0493 MIT Lincoln Laboratoryemail:
> thomas.moyer@ll.mit.edu <mailto:thomas.moyer@ll.mit.edu> 244 Wood Street 
> Lexington, MA 02420
Can you attach all the files  libsemanage seems to be complaining about dnl,
but not sure if that is really in one of your files.  Also defining context
for usr_t,  and httpd_sys_content_t should not be required or should be pushed
to the base httpd package.

- From looking at the file context layout it looks like your app should be
cleaned up to put content into better directories.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCH7WIACgkQrlYvE4MpobMNAgCguTt/8z+zEyTNx9nlFAA7EBgP
9aAAn1gWyEgUoP4yB06o3dan+GjvniJp
=3avV
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
