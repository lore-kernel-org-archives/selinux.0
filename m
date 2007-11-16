Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAGJs6m3016152
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 14:54:06 -0500
Received: from web36613.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAGJrwgY003887
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 19:53:59 GMT
Date: Fri, 16 Nov 2007 11:53:41 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [Fwd: type class key]
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
In-Reply-To: <26736.1195148091@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <310872.79777.qm@web36613.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> David Howells <dhowells@redhat.com> wrote:
> 
> > I've attached the patch I've come up with so far.
> 
> Oops.  One error - I forgot to connect up the new function.
> 
> 	# LD_PRELOAD=/tmp/libkeyutils-1.2.so /tmp/keyctl add user a a @s
> 	762693819
> 	# LD_PRELOAD=/tmp/libkeyutils-1.2.so /tmp/keyctl security 762693819
> 	root:system_r:unconfined_t:s0-s0:c0.c1023
> 
> That what you want?
> 
> New patch attached.
> 
> David
> ---
> KEYS: Add keyctl function to get a security label
> 
> From: David Howells <dhowells@redhat.com>
> 
> Add a keyctl() function to get the security label of a key.
> 
> The following is added to Documentation/keys.txt:
> 
>  (*) Get the LSM security context attached to a key.
> 
> 	long keyctl(KEYCTL_GET_SECURITY, key_serial_t key, char *buffer,
> 		    size_t buflen)
> 
>      This function returns a string that represents the LSM security context
>      attached to a key in the buffer provided.
> 
>      Unless there's an error, it always returns the amount of data it could
>      produce, even if that's too big for the buffer, but it won't copy more
>      than requested to userspace. If the buffer pointer is NULL then no copy
>      will take place.
> 
>      A NUL character is included at the end of the string if the buffer is
>      sufficiently big.  This is included in the returned count.  If no LSM is
>      in force then an empty string will be returned.
> 
>      A process must have view permission on the key for this function to be
>      successful.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  Documentation/keys.txt   |   21 +++++++++++++++
>  include/linux/keyctl.h   |    1 +
>  include/linux/security.h |   20 +++++++++++++-
>  security/dummy.c         |    8 ++++++
>  security/keys/compat.c   |    3 ++
>  security/keys/keyctl.c   |   66
> ++++++++++++++++++++++++++++++++++++++++++++++
>  security/security.c      |    5 +++
>  security/selinux/hooks.c |   21 +++++++++++++--
>  8 files changed, 141 insertions(+), 4 deletions(-)

If you're changing the LSM interface you should cross post this to
the LSM list.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
