Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3C7uFRA017174
 for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2016 03:56:15 -0400
Received: by mail-wm0-f48.google.com with SMTP id a140so42442371wma.0
 for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2016 00:56:11 -0700 (PDT)
Received: from [84.245.30.81] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id jo6sm31885893wjb.48.2016.04.12.00.56.09
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Tue, 12 Apr 2016 00:56:09 -0700 (PDT)
Subject: Re: genhomedircon USERID and USERNAME patches
To: selinux@tycho.nsa.gov
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <570CAA18.2090804@gmail.com>
Date: Tue, 12 Apr 2016 09:56:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/11/2016 11:44 PM, Nicolas Iooss wrote:
<snip>

> 
> By the way, by grep'ing HOME_DIR in refpolicy I got a hit in a
> support script, "support/genhomedircon" [1]. This script is invoked
> only when building modular policy and I have not found an easy way
> to invoke semanage_genhomedircon() from either the command line or
> a Python script. Does this script needs to be updated or is there a
> way to use libsemanage implementation instead?

That script no longer works on modern systems AFAIK.

genhomedircon should not be part of libsemanage in my humble view.
Instead it should be standalone

my 0.02$


- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXDKoTAAoJECV0jlU3+UdpOswL/3tubV9Aa1IW/wqLbEfFdJYL
eT/BwBxqn9HoyR6I3EsvNrQ5rBJ5DNATWbCC08APW+U1Av8GvtlM2XPzzrYlr4e0
AY2e3Br1RXqOlwlYxdqjR+RvGpbhV5ZqI3zV2ZKSvy1z4S9qJ03mUyhd8FxhqACY
bAMNtim7C/CI9Fy0i5KYZE/bRozoVrix+0T1xKUuZDtrsxKxBcAMc+VN2yEA0c9Z
l54tmVQjKkTyqnA5YXGw/sHwVEfedvMmS+P7ZQzNOQAAIY+EFeHal+clhPo9eUI0
NYQflvmrnkHCKfWMCulWfKJIDwCifY/boO4Bk92IzY2bANR4KO/UgVxVG+R/Zmd+
jcadUeK/JuJkjSaZcwf5uja1/aCFsdsZu5IiskhLJpmbv/myTC8/uXJEs8HZ4S3D
gdUygCO0gjlqBJFN+6mGWps05fV9Zgmfn3VmdjWzne7AiESFOUfKlGf2MQFDR1oQ
d7W75bXZxiBdE+MIfZSwIsyQZgDyeCw87zKaW/co/g==
=hMAL
-----END PGP SIGNATURE-----
