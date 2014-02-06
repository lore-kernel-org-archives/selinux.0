Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s169CQeI000885
 for <selinux@tycho.nsa.gov>; Thu, 6 Feb 2014 04:12:27 -0500
Message-ID: <52F351F3.5050801@redhat.com>
Date: Thu, 06 Feb 2014 10:12:19 +0100
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: leo kirotawa <kirotawa@gmail.com>,
 Fedora SELinux Users <selinux@lists.fedoraproject.org>,
 SELinux <selinux@tycho.nsa.gov>
Subject: Re: audit2allow: invalid binary policy
References: <CA+KS1kaJu1RarB3X60NZFsoJduYrP4ZD+UnzppeHH9-x+jPYiw@mail.gmail.com>
In-Reply-To: <CA+KS1kaJu1RarB3X60NZFsoJduYrP4ZD+UnzppeHH9-x+jPYiw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/05/2014 07:07 PM, leo kirotawa wrote:
> Hi,
> 
> I'm having issues when use audit2allow in a Z machine with Fedora 19. This
> is the output message it raises:
> 
> audit2allow -a security: ebitmap: map size 1064 does not match my size 64
> (high bit was 595) invalid binary policy
> 
audit2allow is trying to read policy from the kernel, their might be a bug there.

try audit2allow -a -p /etc/selinux/policy/policy.$VERSION
> 
> As a solution I thought in recompile my whole policy and generate a new 
> /policy/binary, but this time I grabbed a ERROR: (serefpolicy-3.12.1)
> 
> /usr/bin/checkmodule base.conf -o tmp/base.mod /usr/bin/checkmodule:
> loading policy configuration from base.conf 
> policy/modules/kernel/domain.te":256:ERROR 'unknown type tape_device_t used
> in transition definition' at token ';' on line 22729: #line 256 
> type_transition unconfined_domain_type device_t:chr_file tape_device_t
> "ht00"; /usr/bin/checkmodule:  error(s) encountered while parsing
> configuration make: *** [tmp/base.mod] Error 1
> 
> Looking in my /dev/ I did not find any 'ht00' device, what makes me
> suppose maybe it is the problem. Also looking in .te files I saw
> tape_device_t is defined into storage.te, and in this point I have no idea
> what is cause of this problem or how to fix it.
> 
> Have you ever seen it before?
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________ Selinux mailing list 
> Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
> to Selinux-request@tycho.nsa.gov.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLzUfMACgkQrlYvE4MpobOkOACeNXUaLcyJ8V4jPMcGU3rNh/aO
F0MAoMkeafrYMdf17yvWv/ZUlb3GygyG
=x/gR
-----END PGP SIGNATURE-----
