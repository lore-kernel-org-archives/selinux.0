Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2NIWP0R017738
 for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2016 14:32:25 -0400
Received: by mail-wm0-f41.google.com with SMTP id p65so244998567wmp.1
 for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2016 11:32:24 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id gb9sm3776936wjb.26.2016.03.23.11.32.22
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 23 Mar 2016 11:32:22 -0700 (PDT)
Subject: Re: strange pam_selinux behavior
To: selinux@tycho.nsa.gov
References: <56F2D938.8030909@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56F2E136.6090304@gmail.com>
Date: Wed, 23 Mar 2016 19:32:22 +0100
MIME-Version: 1.0
In-Reply-To: <56F2D938.8030909@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/23/2016 06:58 PM, Dominick Grift wrote:
<snip>
> This seems to be the code:
> 
>> /* we have to check that this user is allowed to go into the
>> range they have specified ... role is tied to an seuser, so
>> that'll be checked at setexeccon time */ if (mls_enabled && 
>> !mls_range_allowed(pamh, defaultcon, newcon, debug)) { 
>> pam_syslog(pamh, LOG_NOTICE, "Security context %s is not allowed 
>> for %s", defaultcon, newcon);
> 
>> goto fail_set;
> 


This seems related:

> class = string_to_security_class("context"); if (!class) { 
> pam_syslog(pamh, LOG_ERR, "Failed to translate security class
> context. %m"); return 0; }

since:

pam_selinux(sshd:session): Failed to translate security class
context. Invalid argument

What is a "security class context"?

Is it choking on the periods in my identifiers?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW8uExAAoJECV0jlU3+UdpAeML/2jEcDzPDAs6zQlDg3EIk4bg
Dtrs3YD5xVyFH6EyheiG5ZZQBDqge0b5jY3YX0l5eabGyjSI4yTvQOSwUTDtHwqR
NQcZQCKWYE/gA72uRjqok7pxHBj5B84TM8SwVc12xAgs3znyy4yHZjlGFmq0VGXO
K9dn6hDvHK6Hk3p8FhnLvumB+Xd6VZ6Ju76JaKSdA19OQ8tYhN7wMvvYEpAAMNJy
Qh+EMPYkMZfcqemru8A7jZ40wh+pb9XuqZCiE2JtW0F1PpC2Aa6RKlwt79de52fB
AAFn6vD/EPlnDksgFhOn+9bUKtT+/zGA4gaflDLtmv3Z2K6U3txHxMIZOhD3XDc6
/pjcIo2gu0cA7gP1r6jkC2dX3uZzx2BHu00e8ilXuI90nXI51nUoi6HzBDVg6Tdd
fnHrAvkl4qJJCRvNXCRDIUxbOecIuwWbVoHRZJWR/0q2TOIIujPzhYsE0dmzPAif
rmygoDv2H6sNKxqaENT1xZlstkSItRuIeeE31q3Rzw==
=gYpm
-----END PGP SIGNATURE-----
