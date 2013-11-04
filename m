Message-ID: <5277A835.9000804@redhat.com>
Date: Mon, 04 Nov 2013 08:59:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Laurent Bigonville <bigon@debian.org>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] Explicitly link libselinux against -lpthread
References: <1383434030-5853-1-git-send-email-bigon@debian.org> <52779C9A.4050306@tycho.nsa.gov> <52779EB0.1020700@tycho.nsa.gov>
In-Reply-To: <52779EB0.1020700@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/04/2013 08:18 AM, Stephen Smalley wrote:
> On 11/04/2013 08:09 AM, Stephen Smalley wrote:
>> On 11/02/2013 07:13 PM, Laurent Bigonville wrote:
>>> From: Laurent Bigonville <bigon@bigon.be>
>>> 
>>> libselinux is using pthread functions internally without explicitly 
>>> linking against it.
>>> 
>>> If the executable is itself not linked against libpthread, this could 
>>> lead to some weird ld.so assertions, see: 
>>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=728529
>> 
>> This seems to effectively revert a portion of: commit
>> c32da69e016061c1a06ec08298aae8c995fbea31 Author: Dan Walsh
>> <dwalsh@redhat.com> Date:   Wed Oct 9 16:27:43 2013 -0400
>> 
>> Fixes for procattr calls to handle cache properly.
>> 
>> We were asked not to link to libpthread but to use gcc internals. We were
>> not handling properly the fact that a cache was UNSET, and this patch
>> fixes this.
>> 
>> Can the two of you work out a proper fix that works for you both?
> 
> Also, at least in the original of pthread_once, it was made a weak binding
> on purpose to avoid requiring use of libpthread, switching the 
> implementation between a pthread-based one and a non-thread-safe 
> implementation depending on whether the caller links with libpthread. So
> having libselinux link directly to libpthread seems to defeat the purpose
> of that approach.
> 
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
Yes we originally added the link for pthread_atfork, but have replaced that
with a GCC Equivalebt __selinux_atfork.

Laurent, does debian not work without -lpthread?  Gcc guys did  not want to
require all apps that use libselinux to compile against lpthread.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlJ3qDUACgkQrlYvE4MpobNPtgCcDKOA5WLeF9oV0oAP7uun5Mpo
rh8AmIn8pgwqO4bV0J7ooxXRllpBdaI=
=3Ljj
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
