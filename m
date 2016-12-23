Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBNM0Za0006424
 for <selinux@tycho.nsa.gov>; Fri, 23 Dec 2016 17:00:35 -0500
Received: by mail-ua0-f194.google.com with SMTP id 2so16606634uax.3
 for <selinux@tycho.nsa.gov>; Fri, 23 Dec 2016 14:00:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <dde18b9f-58e8-680b-7d91-391029bfd682@tycho.nsa.gov>
References: <1481299051-27863-1-git-send-email-sds@tycho.nsa.gov>
 <dde18b9f-58e8-680b-7d91-391029bfd682@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Dec 2016 17:00:33 -0500
Message-ID: <CAHC9VhQqc+vUrC_WwBKqKBMPhWbyFNN6mSugrNJ5ypdn4Bsb3g@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Add tests for extended socket classes.
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.net,
 richard_c_haines@btinternet.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 9, 2016 at 11:14 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/09/2016 10:57 AM, Stephen Smalley wrote:
>> Add tests for the extended_socket_class policy capability.
>> This change includes the following tests:
>> - Test that ICMP datagram sockets are mapped to the new icmp_socket
>> class and not to rawip_socket for both IPv4 and IPv6.
>>
>> - Test that SCTP stream and seqpacket sockets are mapped to the
>> new sctp_socket class and not to rawip_socket for both IPv4 and IPv6.
>>
>> - Test that Bluetooth sockets are mapped to the new bluetooth_socket
>> class and not to socket.
>>
>> - Test that AF_ALG sockets are mapped to the new alg_socket class
>> and not to socket.
>>
>> The tests are only run if the extended_socket_class policy capability
>> is present and enabled in the kernel and the base policy, and only if
>> the new classes are defined in the base policy.  This avoids breaking
>> the testsuite on systems with older kernels, older policies, or
>> policies that do not enable the policy capability.
>
> BTW, while creating these tests, I was also trying to test AF_BRIDGE
> originally, but it doesn't appear that you can in fact create AF_BRIDGE
> sockets AFAICT; socket(AF_BRIDGE, <any>, <any>) seems to always return
> EAFNOSUPPORT even though CONFIG_BRIDGE_* is enabled in the kernel
> config.  So possibly we don't need a bridge_socket security class?  Not
> sure what other address families are similar?

It sounds like a good idea to try each of the address families we're
adding in your previous kernel patch; if the socket family isn't
readily accessible from userspace I'm not sure it makes sense to add
the object class at this point in time.

-- 
paul moore
www.paul-moore.com
