Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5UIr9J9016313
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 14:53:09 -0400
Received: from mail-yx0-f191.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5UIqpCl011719
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 18:52:52 GMT
Received: by yxe29 with SMTP id 29so464385yxe.32
        for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 11:53:08 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 30 Jun 2009 11:53:06 -0700
Message-ID: <4c4ba1530906301153s5b8e4e93q4a1c970e1e96ea61@mail.gmail.com>
Subject: "Policy inclusion" tool ... ?
From: Tom London <selinux@gmail.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I quite often am testing the latest Fedora selinux-policy packages
against Fedora Rawhide.

When I bump into SELinux policy "slippage" with new packages and
components, I typically email off the evidence to Dan Walsh, and
create some local policy "fixes" to patch around the potholes.

Typically, Dan fixes these pretty quickly.  I am then left with the
following question: Does the currently installed policy "include" the
rules added by my local .{te,pp} fixes.

Of course, I can "semodule -r" the local module and then try to
recreate the trigger, but this is sometimes not all that easy to do.

What would be handy would be a tool that would check a .{te,pp} file
against the currently running  policy, something like "se-is-included
localfoo.{te,pp}".

I would think this could be of interest beyond my use case.

As a quick and dirty hack, I composed the following shell script to
leverage "sesearch":

#!/bin/bash

while read a b c d e
do
       if [ "$a" == "allow" ]; then
               source=$b
               target=${c%%:*}
               class=${c##*:}
               if [ "$target" == "self" ]; then
                       target=$source
               fi
               echo "sesearch --allow -s $source -t $target -c $class"
               sesearch --allow -s $source -t $target -c $class
       fi
done

Is something like this more generally interesting/useful?  Of course,
I'm certain there are better ways to implement this (e.g., parse the
.pp file instead of the .te file, handle more stuff from the modules,
etc.) but is the use of interest?

tom
- --
Tom London


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpKXxAACgkQuCS0flj2OB2WhwCcCwO+vxDLOCuPXmU4cJAUuhY6
xZ8AoK0fGxQDutBo/xA/BIRHJ8qSBIw7
=N68U
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
