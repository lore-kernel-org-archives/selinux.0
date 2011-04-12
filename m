MIME-Version: 1.0
In-Reply-To: <4DA48F40.6020608@redhat.com>
References: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
	<1301032323-20363-9-git-send-email-qingtao.cao@windriver.com>
	<4DA48F40.6020608@redhat.com>
Date: Tue, 12 Apr 2011 14:03:42 -0400
Message-ID: <BANLkTimKVRntdot769CDXwRPNq9gZhyjUw@mail.gmail.com>
Subject: Re: [v2 PATCH 5/5] Userspace: display the class in role_transition rule
From: Eric Paris <eparis@parisplace.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Harry Ciao <qingtao.cao@windriver.com>, sds@tycho.nsa.gov,
        jmorris@namei.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm betting on:

src/write.c::role_trans_rule_write() which does:
+               if (ebitmap_write(&tr->classes, fp))
+                       return POLICYDB_ERROR;

But I'd think that would need to be conditionalized on a policy
version that supports role trans....

-Eric

On Tue, Apr 12, 2011 at 1:43 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> This patch is blowing up in Fedora.
>
>
>
> semodule -s mls -b /usr/share/selinux/mls/base.pp.bz2
> security: ebitmap: map size 2 does not match my size 64 (high bit was 1)
> libsepol.sepol_module_package_read: invalid module in module package (at
> section 0) (No such file or directory).
> libsemanage.semanage_load_module: Error while reading from module file
> /etc/selinux/mls/modules/tmp/modules/dbadm.pp. (No such file or directory).
> semodule:  Failed!
>
>
> semodule -i mykernel.pp
> security: ebitmap: map size 2 does not match my size 64 (high bit was 1)
> libsepol.sepol_module_package_read: invalid module in module package (at
> section 0) (No such file or directory).
> libsemanage.semanage_load_module: Error while reading from module file
> /etc/selinux/targeted/modules/tmp/modules/dbadm.pp. (No such file or
> directory).
> semodule:  Failed!
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk2kj0AACgkQrlYvE4MpobOsRgCgiPRH/ttp1VmeRfuQMnD76xzF
> 3VYAoMp26ILjzC1+tAQqf35gEknnp+Z1
> =c8Km
> -----END PGP SIGNATURE-----
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
