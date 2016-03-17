Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2HG48gi010865
 for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2016 12:04:08 -0400
Received: by mail-wm0-f51.google.com with SMTP id l124so315264wmf.1
 for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2016 09:04:06 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id t8sm8278421wjy.41.2016.03.17.09.04.03
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 17 Mar 2016 09:04:03 -0700 (PDT)
Subject: Re: Problem building CIL module with new class
To: selinux@tycho.nsa.gov
References: <1198187673.578619.1458228315066.JavaMail.yahoo.ref@mail.yahoo.com>
 <1198187673.578619.1458228315066.JavaMail.yahoo@mail.yahoo.com>
 <56EAD3B4.70304@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56EAD573.9000807@gmail.com>
Date: Thu, 17 Mar 2016 17:04:03 +0100
MIME-Version: 1.0
In-Reply-To: <56EAD3B4.70304@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/17/2016 04:56 PM, Dominick Grift wrote:
> On 03/17/2016 04:25 PM, Richard Haines wrote:
>> Using Fedora 23 targeted policy.
> 
>> Problem: When adding a new class via the CIL module listed below,
>>  the allow rule is not being resolved if the new class references
>> a common set of permissions.
> 
>> Viewing with apol shows that the new class has been allocated the
>>  unique and common permissions, however the allow rule is
>> missing.
> 
>> Note 1: If the 'all' expression is replaced in the 
>> 'classpermissionset' with the actual permissions, then the allow
>>  rule is resolved.
> 
>> Note 2: If I use the latest 2.5 libsepol with the (classorder 
>> (unordered sctp_socket)) statement I get the same result.
> 
>> The example CIL policy module is: 
>> ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; (classorder (proxy 
>> sctp_socket))  ; 'proxy' is the last class defined in F-23 ; and
>>  required when using libsepol 2.4
> 
>> (classcommon sctp_socket socket) (class sctp_socket (node_bind 
>> name_connect association bindx_add bindx_rem connectx peeloff 
>> set_addr set_params))
> 
>> (classpermission sctp_socket_all_perms) (classpermissionset 
>> sctp_socket_all_perms (sctp_socket (all)))
> 
>> (allow unconfined_t self sctp_socket_all_perms) 
>> ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
> 
>> And is built with the following command:
> 
>> semodule --priority 400 -i sctp_test_module.cil
> 
> Maybe it is related to semodule? Seems to work fine when tested
> with DSS P:
> 
> https://www.youtube.com/watch?v=NYMoPUNTqes
> 
> [root@void kcinimod]# rpm -qa | grep libselinux 
> libselinux-2.4-4.fc23.x86_64 libselinux-utils-2.4-4.fc23.x86_64 
> libselinux-python3-2.4-4.fc23.x86_64 libselinux-2.4-4.fc23.i686 
> [root@void kcinimod]# rpm -qa | grep libsepol 
> libsepol-2.5-9999.gitb3b5ede.fc24.x86_64 [root@void kcinimod]# rpm
> -qa | grep setools setools-4.0-9999.gitac4f846.fc23.x86_64 
> setools-gui-4.0-9999.gitac4f846.fc23.x86_64 [root@void kcinimod]#
> rpm -qa | grep secilc secilc-2.5-9999.gitb3b5ede.fc24.x86_64
> 
> 

What truly sucks though is that when you add a new access vector you
have to reboot because else you get issues like this:

avc:  denied  { send_msg } for msgtype=method_return dest=:1.186
spid=2137 tpid=17186
scontext=wheel.id:wheel.role:wheel_evosr.subj:s0-s0:c0.c1023
tcontext=wheel.id:wheel.role:wheel_evocf.subj:s0-s0:c0.c1023 tclass=dbus

[root@void kcinimod]# sesearch -A -s wheel_evocf.subj -t
wheel_evosr.subj -c dbus
allow wheel_evosr.sessbus_chat_client_subj_type_attribute
wheel_evosr.subj:dbus send_msg;

I.E. the user space access vectors/object managers get confused...
There is a rule to allow the above avc denials (as per the sesearch
output) but dbus still denies access.

>> Any ideas !!! Richard 
>> _______________________________________________ Selinux mailing 
>> list Selinux@tycho.nsa.gov To unsubscribe, send email to 
>> Selinux-leave@tycho.nsa.gov. To get help, send an email
>> containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
> 
> 

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW6tVuAAoJECV0jlU3+UdpaOUL/0lvAexcEmd3Nmiqs3M2S/wE
vCL9598nZk03uZgZub7qpCszCgmK3D5KV61Z6qIgnuIkCOFouFwohEEEMZt61fzb
bJUmUCCLvJZM0kO+RQ86J0VtZoDKE+dqcCmsOfxh+U+EyGGVPKyLWMQTb+NQ7HrG
ZgscKkU9Ujc901pPnyhTbXV/cO3okV9WEd5IvpxSn2DarNC4X++BInfZYqlFo8+n
9rk9ty3awFNwm5rUwcFSepnRAQQ+rRQRZjw9X50nMpQ9bigf7mON9xleUg+1Cjyz
ECcrxZDwjY4ne7y5DiJi/xHT3fAGRFfsyiJmFV1jOt/xMGla0c8mL7iUlbwbOMXv
aoQe+c/4VDuDStvGcXWCsbf6gZBKmjd02kuFlq+zEYXzUdTav2P1MjCvVhzj3VFf
Zenz/UPLB/y310D1ck+0zicq9sGiP5Rt7nTV9G0WxbGN05JqkXzacFsT5nKPPSQc
EQ09GsUTLGBxKhCdBkHQvy8gYBRZ06wOGX8rVDbhBw==
=OOvB
-----END PGP SIGNATURE-----
