Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43DKKRb004909
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 09:20:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i43DI6Zx009606
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 13:18:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i43DI6Jv009603
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 13:18:06 GMT
Subject: Re: selinux + pb : libselinux.so.1 not found
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: amine.baina@ensi-bourges.fr
Cc: selinux@tycho.nsa.gov
In-Reply-To: <34102.172.20.128.112.1083592021.squirrel@ldap.ensi-bourges.fr>
References: <34102.172.20.128.112.1083592021.squirrel@ldap.ensi-bourges.fr>
Content-Type: text/plain
Message-Id: <1083590411.7446.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 May 2004 09:20:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-05-03 at 09:47, amine.baina@ensi-bourges.fr wrote:
> hello everybody,
> 
> I have some problems in installing selinux on Mandrake clic 9.1
> 
> when I launch sh ./build
> I have the error : libselinux.so.1 not found
> 
> I think I should download libselinux rpm and install it to solve
> the problem, because it provides libselinux.so.1 which is the origin
> of the problem

The build output that you included in your message showed the failure
occuring during the build of libselinux.  It doesn't make sense that a
libselinux build would fail due to a missing libselinux.so.1, since the
libselinux build is what produces libselinux.so.1.  I can't reproduce
the problem here on a Fedora base, even on a Fedora Core 1 system with
no libselinux installed.

Try doing a make by hand, i.e. cd libselinux && make.  Expected output
would start with:
make -C src
make[1]: Entering directory `/tmp/selinux-usr/libselinux/src'
cc -Wall -I../include  -c -o avc.o avc.c
cc -Wall -I../include  -c -o avc_internal.o avc_internal.c
cc -Wall -I../include  -c -o avc_sidtab.o avc_sidtab.c
cc -Wall -I../include  -c -o booleans.o booleans.c
cc -Wall -I../include  -c -o check_context.o check_context.c
cc -Wall -I../include  -c -o compute_av.o compute_av.c
...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
