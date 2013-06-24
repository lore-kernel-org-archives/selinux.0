Message-ID: <51C85693.5040603@redhat.com>
Date: Mon, 24 Jun 2013 10:24:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Sven Vermeulen <sven.vermeulen@siphos.be>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@redhat.com>
Subject: Re: pcre 8.33 changes restorecon behavior
References: <20130622161711.GA2010@siphos.be> <51C840AB.2030606@tycho.nsa.gov>
In-Reply-To: <51C840AB.2030606@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/24/2013 08:50 AM, Stephen Smalley wrote:
> On 06/22/2013 12:17 PM, Sven Vermeulen wrote:
>> Hi guys
>> 
>> Since libpcre 8.33, the behavior of restorecon is different. Take the 
>> context for /sbin for instance:
>> 
>> Before libpcre 8.33: # matchpathcon /sbin /sbin
>> system_u:object_r:bin_t:s0
>> 
>> With and after libpcre 8.33: # matchpathcon /sbin /sbin    <<none>>
>> 
>> As a result, trying to reset the label fails:
>> 
>> # restorecon -Fv /sbin restorecon:  Warning no default label for /sbin
>> 
>> Is this a bug in libpcre or are we using it differently? According to 
>> Alphat-PC, it is due to rev 1313 of libpcre: 
>> http://vcs.pcre.org/viewvc?view=revision&revision=1313
>> 
>> Thanks to Alphat-PC for reporting and debugging it at 
>> https://bugs.gentoo.org/show_bug.cgi?id=471718
> 
> Looks to me as if the compiled regex format changed.  So that would be a
> problem for previously compiled regexes cached in the .bin files under 
> /etc/selinux/$SELINUXTYPE/contexts/files.  You would need to re-run 
> sefcontext_compile to regenerate them or delete them and fall back to
> loading from the source configurations.
> 
> Not sure if there is a way to automatically detect the change in format
> and handle the conversion on the libselinux side.
> 
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
We could add a trigger when pcre is updated to rerun the commands.

Adding something like the following to selinux-policy, would rebuild the pcre
files.

%triggerin -- pcre
selinuxenabled && semodule -nB
exit 0


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHIVpIACgkQrlYvE4MpobMpuwCfdb+UwZ74gavG11w42u+z4gTK
0oYAnj70/y55Ucg5IIUyEiFRFCprRKso
=8wim
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
