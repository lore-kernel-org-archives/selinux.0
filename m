Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3DGYAWN024907
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 12:34:11 -0400
Received: by mail-wm0-f42.google.com with SMTP id u206so88055456wme.1
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 09:34:05 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id us3sm21679728wjc.41.2016.04.13.09.34.03
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 13 Apr 2016 09:34:03 -0700 (PDT)
Subject: Re: genhomedircon USERID and USERNAME patches
To: selinux@tycho.nsa.gov
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
 <570CF09E.10100@tycho.nsa.gov> <570D079B.40106@tresys.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <570E74FA.8060600@gmail.com>
Date: Wed, 13 Apr 2016 18:34:02 +0200
MIME-Version: 1.0
In-Reply-To: <570D079B.40106@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/12/2016 04:35 PM, Christopher J. PeBenito wrote:

> Right, the script that refpolicy has is only used on monolithic
> builds.
> 

As I recall, last time i tried it, it was not working on a
redhat-based system. Probably bit-rot has set in. There is also some
hard-coding going on in there i believe.

Someone with c-skills should rewrite it in c, make it truly portable.
That way it can be used with both monolithic as well as modular policy
(i don't mean binary-based module policy here but text-based module
policy that otherwise does not require the presence of semodule)


- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXDnT0AAoJECV0jlU3+UdpemoL/1gd68W5tPnsbgHbZev28M4Z
d6hhjMJne1uMeANuvPUfPeGQpamd0+dhpJrROyLDe9V1KjbDENbu9PlHIfFncdOX
VyJNj+o+YEHx34nKOZRQAvWcjp1Kgn6JztjA6yfb2mf0D93BNkHQWadRllUzp7Lt
kUyFgZFzr1GbsEyK77hEr2/4k4JBWb2idf8XlMIyg6+51JX11eVjAmhXQn9uaJgF
rvyYvfUnr8DK+MVH2BMRIBNM10gPpVQvNlYrwsPfhXW+HyoS9ZE1HtXn9h3gr58A
sWg655PKTBtUU0fkrXJzRLCcmPWekOmh1lK82V23qfT2xcEG44XakBLlGlIQuX+k
l7R0DDE79QdLVDv7Joh+nVtiFuVYTOqtDWLyzq7RoDVMfuGU+Ni2c2LKONbYwKf4
J3YoS5KbMUr4IjQVlMo2+iGvsOLeI4g6SeppA2taZz2K01fdw2fYRD7chIN5ghqS
+EEhM8veTPpEq87ifpZQMIcBdKTXDqJRU9ppVUzoxQ==
=uIXm
-----END PGP SIGNATURE-----
