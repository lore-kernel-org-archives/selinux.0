Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2NIbj89018887
 for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2016 14:37:45 -0400
Received: by mail-wm0-f41.google.com with SMTP id r129so148081574wmr.1
 for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2016 11:37:44 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id w125sm4193776wmw.18.2016.03.23.11.37.42
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 23 Mar 2016 11:37:43 -0700 (PDT)
Subject: Re: strange pam_selinux behavior
To: selinux@tycho.nsa.gov
References: <56F2D938.8030909@gmail.com> <56F2E136.6090304@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56F2E276.9070702@gmail.com>
Date: Wed, 23 Mar 2016 19:37:42 +0100
MIME-Version: 1.0
In-Reply-To: <56F2E136.6090304@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/23/2016 07:32 PM, Dominick Grift wrote:
> On 03/23/2016 06:58 PM, Dominick Grift wrote: <snip>
>> This seems to be the code:
> 
>>> /* we have to check that this user is allowed to go into the 
>>> range they have specified ... role is tied to an seuser, so 
>>> that'll be checked at setexeccon time */ if (mls_enabled && 
>>> !mls_range_allowed(pamh, defaultcon, newcon, debug)) { 
>>> pam_syslog(pamh, LOG_NOTICE, "Security context %s is not
>>> allowed for %s", defaultcon, newcon);
> 
>>> goto fail_set;
> 
> 
> 
> This seems related:
> 
>> class = string_to_security_class("context"); if (!class) { 
>> pam_syslog(pamh, LOG_ERR, "Failed to translate security class 
>> context. %m"); return 0; }
> 
> since:
> 
> pam_selinux(sshd:session): Failed to translate security class 
> context. Invalid argument
> 
> What is a "security class context"?
> 
> Is it choking on the periods in my identifiers?
> 

oh sh.. now i get it. It is choking on the "context" security class.

Yes i dont have that "user space" access vector because that seems to
be no longer used.

isnt the context security class a "setransd" thing? if so then i do
not believe that setransd still uses that. So this should probably be
adjusted then to not rely on that user space access vector?



- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW8uJxAAoJECV0jlU3+UdpfKUL/3NL9x8SmNR1RkikgOrv/ATY
gm0ZVACiObMmUoPLaqdl8F5zPUrT31JMv/OAsJcRgtl1QADTpPM+pTmGMzKsoqKE
5aF3QjZ3yhtrhTUsgGGhYQwumdzz9YBnqlHHT8UTz+GPAKDrhgIrQuK83fcN3dpG
02r6CaflD+1WK/5HTj0mzxg02EzdiJ0QSIAoJRcEy41hUuGb3Xfp9RopFJZvtFgi
ZpB+wwGQTveDTUO+Xp5xzg3YAQIwBXY3yKrb+Bg5sumz+QSyf2d/m2DxO29FxXth
tzsBcez8+VZ1K9wTVv03JCIg/JagoqcWu2zOdOM5pXCCy+px+rrbwISy6cHAGK4V
r2fro2Bisuz0ZSiKRYe/19RQ6SpB35ZG/0DpJH3fdLnZfZk/UqTIOrnn31P4rfLL
lA0pjtafrResaJmPUo8NPDXIQTU6PlCpFg8P30iW89d86aWZnH2F86Gpqk2uAzaP
sJIW5jf+XmFy9U2h6lf8CrxGM3tx0nQlBSAlP5vvZg==
=biHz
-----END PGP SIGNATURE-----
