Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2HFue3j008294
 for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2016 11:56:40 -0400
Received: by mail-wm0-f49.google.com with SMTP id l68so81509wml.1
 for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2016 08:56:38 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id za6sm8306304wjc.18.2016.03.17.08.56.36
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 17 Mar 2016 08:56:37 -0700 (PDT)
Subject: Re: Problem building CIL module with new class
To: selinux@tycho.nsa.gov
References: <1198187673.578619.1458228315066.JavaMail.yahoo.ref@mail.yahoo.com>
 <1198187673.578619.1458228315066.JavaMail.yahoo@mail.yahoo.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56EAD3B4.70304@gmail.com>
Date: Thu, 17 Mar 2016 16:56:36 +0100
MIME-Version: 1.0
In-Reply-To: <1198187673.578619.1458228315066.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/17/2016 04:25 PM, Richard Haines wrote:
> Using Fedora 23 targeted policy.
> 
> Problem: When adding a new class via the CIL module listed below, 
> the allow rule is not being resolved if the new class references a 
> common set of permissions.
> 
> Viewing with apol shows that the new class has been allocated the 
> unique and common permissions, however the allow rule is missing.
> 
> Note 1: If the 'all' expression is replaced in the 
> 'classpermissionset' with the actual permissions, then the allow 
> rule is resolved.
> 
> Note 2: If I use the latest 2.5 libsepol with the (classorder 
> (unordered sctp_socket)) statement I get the same result.
> 
> The example CIL policy module is: 
> ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; (classorder (proxy 
> sctp_socket))  ; 'proxy' is the last class defined in F-23 ; and 
> required when using libsepol 2.4
> 
> (classcommon sctp_socket socket) (class sctp_socket (node_bind 
> name_connect association bindx_add bindx_rem connectx peeloff 
> set_addr set_params))
> 
> (classpermission sctp_socket_all_perms) (classpermissionset 
> sctp_socket_all_perms (sctp_socket (all)))
> 
> (allow unconfined_t self sctp_socket_all_perms) 
> ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
> 
> And is built with the following command:
> 
> semodule --priority 400 -i sctp_test_module.cil

Maybe it is related to semodule? Seems to work fine when tested with DSS
P:

https://www.youtube.com/watch?v=NYMoPUNTqes

[root@void kcinimod]# rpm -qa | grep libselinux
libselinux-2.4-4.fc23.x86_64
libselinux-utils-2.4-4.fc23.x86_64
libselinux-python3-2.4-4.fc23.x86_64
libselinux-2.4-4.fc23.i686
[root@void kcinimod]# rpm -qa | grep libsepol
libsepol-2.5-9999.gitb3b5ede.fc24.x86_64
[root@void kcinimod]# rpm -qa | grep setools
setools-4.0-9999.gitac4f846.fc23.x86_64
setools-gui-4.0-9999.gitac4f846.fc23.x86_64
[root@void kcinimod]# rpm -qa | grep secilc
secilc-2.5-9999.gitb3b5ede.fc24.x86_64

> 
> Any ideas !!! Richard 
> _______________________________________________ Selinux mailing 
> list Selinux@tycho.nsa.gov To unsubscribe, send email to 
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing 
> "help" to Selinux-request@tycho.nsa.gov.
> 


- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW6tOvAAoJECV0jlU3+UdpijYL+gPumCA7OVEC4MlZ7gqBj7+P
EXaWX7MKUC4FUdyKljd416/l1aj0y5m3ihKmx/Iiyk9ZJim//BIQCoKtySXooo3w
RmAIFx1vRd3qet88W9L9zhfq+q+wPnXSOBsbBwSylVQdC5dLMtxYnZwAgm1Jraxp
LRw92wz5rn1OS33M5+/v7sLwfP5sx8yakoD//DN2hJO0FmOmrbB+/I77iXMjoIjH
jDIKSqBufS4IgQO+xN5a42hjfzxVlhrKX4wCDaafagkQQBOQpD4Il5xHx70ZzE55
mvVzyCyIGZ8QpVGM4MhyaKIvXPwffCFNwivCSPjiEz5AMDc2IbbNDEb4cH6br7SR
4DCHyGWwyO3QhbW2BALGFp3mH4lYoFNyetRE6xVKqDYf6OZ5jLJaQZwqHuUpSkvG
XGb3fzLsSFFQo/0X8Et9yGLyvsFNf/Gb5K85mYOSKDhYFMQ9ZIL56rQKK+GXZtrA
+54icfOw1f8laVISosIuoCX4T/W5U+4ap90bpHbdRQ==
=r/id
-----END PGP SIGNATURE-----
