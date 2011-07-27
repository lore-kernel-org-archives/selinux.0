Message-ID: <4E2FEDB5.9030902@secunet.com>
Date: Wed, 27 Jul 2011 12:51:33 +0200
From: Martin Christian <martin.christian@secunet.com>
MIME-Version: 1.0
To: Rongqing Li <rongqing.li@windriver.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: "netstat -Z" reimplementation
References: <4E2FDA3A.5040408@windriver.com>
In-Reply-To: <4E2FDA3A.5040408@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Rongqing,

we would appreciate such an extension to netstat. We shortly had a
problem where it had helped if we could have see the labels of unix
domain sockets.

I'll try to help as much as possible (considering our project constraints).

Regards,

Martin.


Am 27.07.2011 11:28, schrieb Rongqing Li:
> SELinux folks, Stephen:
> 
> I have some thoughts about reimplementation of 'netstat -Z', but I do
> not know if it is valuable, or if there are other risks. Could you
> evaluate my implementation, or give me your valuable advice?
> 
> 1. From kernel, print the socket labels to tcp, udp, raw, unix
> files under /proc/net/.
> 
> Now the /proc/net/tcp /proc/net/udp ... include many socket's
> information, like local address, remote address, inode, I think we can
> put the socket's security context to these files.
> 
> To avoid to expose these information to non-privileged users, security
> checking should be done when expose the socket security context to procfs.
> 
> 2. reimplementation the "netstat -Z", "netstat -Z" will first parse the
> security context from procfs's tcp, udp, raw files, and get the security
> context, if this step fails, "netstat -Z" will try as legacy method.
> 
> 
> If this implementation could be accepted by mainstream, netstat could
> print the correct socket label even if the type_transition has been
> happen on socket, or application changes socket labels by setting
> /proc/self/attr/sockcreate.
> 
> 
> Do you think it is valuable?
> 
> Thanks
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOL+2uAAoJEGpTkDITRjmoT3EH/j6Egi1tg9FUqa3nELZKepQY
lIOvvlHMJyboNlaisHkLS+MeMgO32mKfwiO2Vq4MNNFFHgEHt1J2BoIaNUU/D07K
KVNvfEVcD3jV/B2vpqM6ugUjrzmxmueDhdYvnG2l4nTPVxnN+irZ60ECcpgW7b2h
YZ5HKRAQ4MJkkCZacX03g3YX5J7inI3GU6eXUsim1/g54vdyCTRHn6M3AIizYozt
+7Ey60CdgPBKHr8MnwZVgkC21zkZS0E/8ZOYFxYPKATBbdlINxOWG2i4mUTp9eJE
svK/IMqJ4DXEg6RfGNwEB/KEms0W5ExOW/0M2TqoaukJBlLjZ20g4tQWZSVMVkg=
=zm+N
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
