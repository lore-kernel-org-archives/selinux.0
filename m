Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3BHRN0k026396
	for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2011 13:27:23 -0400
Received: from e24smtp04.br.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3BHRLob019145
	for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2011 17:27:22 GMT
Received: from /spool/local
	by e24smtp04.br.ibm.com with XMail ESMTP
	for <selinux@tycho.nsa.gov> from <rcvalle@linux.vnet.ibm.com>;
	Mon, 11 Apr 2011 14:27:18 -0300
Message-ID: <4DA339B9.9050903@linux.vnet.ibm.com>
Date: Mon, 11 Apr 2011 14:26:17 -0300
From: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux@tycho.nsa.gov
Subject: Re: SELinux mixed/virtualisation policy
References: <4DA1E50F.4060506@linux.vnet.ibm.com> <201104120020.42266.russell@coker.com.au>
In-Reply-To: <201104120020.42266.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/11/2011 11:20 AM, Russell Coker wrote:
> On Mon, 11 Apr 2011, Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com> 
> wrote:
>> The SELinux mixed policy can have non hierarchical sensitivities that
>> have the same behavior of a categorized only environment. Such
>> sensitivities should not be included in the default sensitivity
>> hierarchy (i.e. s0 to s15). Thus, all rules for these sensitivities
>> should be explicitly stated. This allows creating a unique sensitivity
>> for virtual machine environments that is not part of the default
>> sensitivity hierarchy.
> 
> One way of doing this is for the sysadmin to assign categories c0.c511 to non-
> VM levels and categories c512.c1023 to virtual machines - or any other 
> partitioning scheme that you might imagine.  Another possibility is to have 
> one category assigned to the sensitivity label for all virtual machines and 
> another assigned to the sensitivity label for all contexts that aren't used 
> for VMs.  If you have two sensitivity labels that are incomparable then no 
> data flows between them.
Yes, I agree. However, what I am looking for is a standardization of
what should be implemented in this type of situation, with an additional
level of granularity.

> 
> One of the many ways of using categories would be to assign a discrete pair of 
> categories to each thing you want to restrict.  One possibility I idly 
> considered some time ago was to use MMCS labels for a build server.  Every 
> package that would be built would be assigned a pair of categories as part of 
> the sensitivity label, with the default policy build of 1024 categories that 
> permits about half a million combinations which is more than enough to build 
> the ~15,000 Debian packages with a different context for each one.
Actually, this is what libvirt does with dynamic labeling enabled.
However, it currently does not work with MLS policy.

> 

- -- 
Ramon de Carvalho Valle
Security Engineer
IBM Linux Technology Center
rcvalle@linux.vnet.ibm.com
http://rcvalle.com/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk2jObgACgkQkcIYeh81wLm++wCbBZsh2w7fT8ZwNcYfpxyAa0vh
BysAnRi6U9mNGYShaqQ4uj2PhhcpFb4e
=W/Vj
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
