Message-ID: <49B18813.7050906@redhat.com>
Date: Fri, 06 Mar 2009 15:31:15 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I have not used the selabel interface replacement for matchpathcon,
 that much
References: <49B1464A.6020606@redhat.com> <1236364545.16365.5.camel@localhost.localdomain>
In-Reply-To: <1236364545.16365.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2009-03-06 at 10:50 -0500, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Is there an equivalent to this?
>>
>> The question we are getting is can we speed up the execution of
>> restorecon in boot.
>>
>> restorecon /etc/resolv.conf
>>
>> should only search prefix /etc.
> 
> man selabel_file
> 
> SELABEL_OPT_SUBSET is the option you want to set in the options
> structure for selabel_open(3).
> 
Yes I read the code and found that matchpathcon_init does the
selabel_open under the covers.

int matchpathcon_init_prefix(const char *path, const char *subset)
{
	if (!mycanoncon)
		mycanoncon = default_canoncon;

	options[SELABEL_OPT_SUBSET].type = SELABEL_OPT_SUBSET;
	options[SELABEL_OPT_SUBSET].value = subset;
	options[SELABEL_OPT_PATH].type = SELABEL_OPT_PATH;
	options[SELABEL_OPT_PATH].value = path;

	hnd = selabel_open(SELABEL_CTX_FILE, options, SELABEL_NOPT);
	return hnd ? 0 : -1;
}


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmxiBIACgkQrlYvE4MpobM1QQCeLDPSkN29rm/39MjcxlPCu9A9
1CUAoIf7W4cW3/Ncw5He1X6qEEipPJC7
=5uhw
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
