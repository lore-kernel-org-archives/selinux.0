Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8CCrR9P000622
 for <selinux@tycho.nsa.gov>; Sat, 12 Sep 2015 08:53:27 -0400
Received: by wiclk2 with SMTP id lk2so84685104wic.1
 for <selinux@tycho.nsa.gov>; Sat, 12 Sep 2015 05:53:24 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by smtp.gmail.com with ESMTPSA id bs8sm5374443wjc.47.2015.09.12.05.53.23
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Sat, 12 Sep 2015 05:53:23 -0700 (PDT)
Date: Sat, 12 Sep 2015 14:53:22 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: secilc: segfault on what should be "Recursive block call found"?
Message-ID: <20150912125321.GB4006@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

- ----- Forwarded message from Dominick Grift <dac.override@gmail.com> -----

Date: Sat, 12 Sep 2015 14:51:22 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gove
Subject: secilc: segfault on what should be "Recursive block call found"?
User-Agent: Every email client sucks, this one just sucks less.

I am knee-deep in namespaces and hitting all kinds of exotic challenges

I had a macro with the same name as a macro call in it, like:

(in bla
    (macro foo ((type ARG1))
           call foo (ARG1)))

secilc helpfully threw a message telling me:

    Recursive macro call found
    Failed to compile cildb: -1

Great. after a short struggle i managed to locate the issue (unfortunately
secilc was not more specific as to the location of the issue)

Now i am hitting what seems to be a similar issue to the above. except
that in this case its not about macros but about block

consider:

(in bla
        (block foo_blk
        (blockabstract foo_blk)

        (blockinherit foo_blk))

In this case, though secilc segfaults, instead of telling me:

    Recursive block call found
    Failed to compile cildb: -1

this is just theory though... but i suspect the above is true

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift

- ----- End forwarded message -----

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV9CA8AAoJENAR6kfG5xmcbWoL/1bxjVcZTjSGEwvOJJL0HDSi
r1zyPy/o/9cjAE1Zw3uVBxnzESwpb1nWepQPYhkJ8d79tzS4vgV14MeEw3RHpboF
9eKJg5UvmhCjMk5H+Kjrg6wuAvK+4wqTHTY0IMNjkRrvzQ2PYNWM/kmJedAqO3SE
4R2uTw1H0JIx4+w+ZcQZwOP1oxYjdJAJCrvryY3I6FGPuhWB+yX5OIJ48oSHcbJR
WjYlKvYFuK2obAYlGcLBdf1Rdl4K5bCUUMm+rgv5r7cQnd8tlnqnx9rx8DKv0tt+
V5OZc4Kok3m4+U/mTNl/mwTwHh9muen9bw7AfJ8R1OaoW9TJmefKHETvqMVLv3MF
fEma8v+TZL+UXxE45tCYTeezm8YhIWeGJ9Xi6yTkDkAsNtUrW3aL9/R6tgimuIwF
aA3lsgHvm9fvBHRTAK/Db6OygDp1eedF0t/OMZHGhW4/bmLSwYOt3vnlE0NTJHk9
Je2lwOCHhnBXxnLfCUrUJMVdH1N5K91cI2ie6KBC5A==
=CkY3
-----END PGP SIGNATURE-----
