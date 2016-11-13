Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uADLK9x3016315
 for <selinux@tycho.nsa.gov>; Sun, 13 Nov 2016 16:20:09 -0500
In-Reply-To: <20150915120820.GA18065@x250>
References: <CA+=dQ-_wPGkCzK9EC0tdUbm+CTf2mLo9TY94fVaoJ5hCLR1gKw@mail.gmail.com>
 <20150915120820.GA18065@x250>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Policy disable error
From: Russell Coker <russell@coker.com.au>
Date: Sun, 13 Nov 2016 20:49:34 +1100
To: Dominick Grift <dac.override@gmail.com>, Divya Vyas <dvyas@mvista.com>
CC: selinux <selinux@tycho.nsa.gov>
Message-ID: <DC861750-BEA3-4585-AA17-DE55CEBF3995@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

That sort of thing is a bug and should be fixed. If it can't be fixed then IMHO the Apache module should be linked in base.pp to make it explicit that it shouldn't be removed.

On 15 September 2015 10:08:21 pm AEST, Dominick Grift <dac.override@gmail.com> wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA512
>
>On Tue, Sep 15, 2015 at 05:25:58PM +0530, Divya Vyas wrote:
>> Hi,
>> 
>> I am getting below error while disabling the apache module policy
>> 
>> semodule -d apache
>> libsepol.context_from_record: type httpd_sys_content_t is not defined
>(No
>> such file or directory).
>> libsepol.context_from_record: could not create context structure
>(Invalid
>> argument).
>> libsemanage.validate_handler: invalid context
>> system_u:object_r:httpd_sys_content_t:s0 specified for htdocs/ [all
>files]
>> (Invalid argument).
>> libsemanage.dbase_llist_iterate: could not iterate over records
>(Invalid
>> argument).
>> semodule:  Failed!
>
>most likely a dependency issue. apache module is notorious for being
>essentially mandatory.
>
>You would have to identity all modules that depends on the apache
>module
>and then disable those as well in the same transaction. Be warned that
>those modules in turn may have dependencies of their own.
>
>kind of like "dll hell" in a sense
>
>- -- 
>02DFF788
>4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
>https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
>Dominick Grift
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v2
>
>iQGcBAEBCgAGBQJV+AovAAoJENAR6kfG5xmcx4wL/jZrT5OvwN3xpWd+/fHl/unO
>fqowsf+h+IPHIJblVpsd9byMRqmVtka5I630/g9UMpdj/oGyeLFqiNSvwveVAdJV
>LymzJ7+OT8R8oSakSK5xI3cf2l6yx1q+vDNueJaoP8Ss9XSmNf/tefSOc66QKtNy
>1KIXSqaQLZwhT85QjtKjBD8KmQkxIMO4nMNBiBkQCbbqBlHfYYZummSdHfQt8xz7
>2e05ycc2lUrJLlztQUWXrHkFRqM7g5I6SKOoCJfed1uxWb3gVNPVJIDpJeDdDNmF
>UpDvmlq72JTUvv1qjJskiIIU4NMfV469B/3OyMIrdORkEzPgiNNnUdyTro8Pwnk2
>C2g8Ef57CCQC78tPeAMP57IJKMhq32fc+TBgNAyNfQqNvFMmGEdqTWFmImpv6ula
>yW1oSJa+6NBhvkB44LVqwh2GY0ei1dfQV1sOOLc6QARmMQm3glSrk500z/3s55eo
>opuPIJN4XGy1ODI8Yy9i+7dsFTxUFl8qqM37rfoNpQ==
>=sDw/
>-----END PGP SIGNATURE-----
>_______________________________________________
>Selinux mailing list
>Selinux@tycho.nsa.gov
>To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>To get help, send an email containing "help" to
>Selinux-request@tycho.nsa.gov.

-- 
Sent from my Nexus 6P with K-9 Mail.
