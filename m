Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHh0p7015160
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:43:01 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHgx2p009623
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:43:00 GMT
Message-ID: <465DB770.8050903@redhat.com>
Date: Wed, 30 May 2007 13:42:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Bernd Bartmann <bernd.bartmann@gmail.com>
CC: CentOS mailing list <centos@centos.org>, selinux@tycho.nsa.gov
Subject: Re: Centos 5 OpenVPN / SElinux
References: <6c18a4f0705301003xc08b41dsd871345a20197cd@mail.gmail.com>
In-Reply-To: <6c18a4f0705301003xc08b41dsd871345a20197cd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Bernd Bartmann wrote:
> Hi,
>
> I'm running Centos 5 32bit and installed openvpn-2.0.9-1.el5.rf from
> Dag Wieers Repo. When OpenVPN is started during boot-up it just shows
> an SElinux related error message. When I start OpenVPN manually after
> the system has come up completely it works fine.
>
> Here are all the messages from /var/log/messages that are SElinux 
> related:
>
> May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.395:10): avc:
> denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.395:11): avc:
> denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.395:12): avc:
> denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.458:13): avc:
> denied  { execstack } for  pid=3012 comm="openvpn"
> scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:openvpn_t:s0 tclass=process
> May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.465:14): avc:
> denied  { use } for  pid=3014 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.465:15): avc:
> denied  { use } for  pid=3014 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.465:16): avc:
> denied  { use } for  pid=3014 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.466:17): avc:
> denied  { execstack } for  pid=3014 comm="openvpn"
> scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:openvpn_t:s0 tclass=process
> May 28 21:40:06 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 21:40:06 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.319:10): avc:
> denied  { use } for  pid=3010 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.319:11): avc:
> denied  { use } for  pid=3010 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.319:12): avc:
> denied  { use } for  pid=3010 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.382:13): avc:
> denied  { execstack } for  pid=3010 comm="openvpn"
> scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:openvpn_t:s0 tclass=process
> May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.390:14): avc:
> denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.390:15): avc:
> denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.390:16): avc:
> denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
> ino=1396 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:pppd_t:s0 tclass=fd
> May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.390:17): avc:
> denied  { execstack } for  pid=3012 comm="openvpn"
> scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:openvpn_t:s0 tclass=process
> May 28 22:18:52 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
> For complete SELinux messages. run sealert -l
> 5701a4da-1d96-4c86-9747-e31b3d5d2219
> May 28 22:18:52 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 22:18:52 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
> For complete SELinux messages. run sealert -l
> 5701a4da-1d96-4c86-9747-e31b3d5d2219
> May 28 22:18:52 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 22:26:00 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
> For complete SELinux messages. run sealert -l
> 5701a4da-1d96-4c86-9747-e31b3d5d2219
> May 28 22:26:00 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 22:26:00 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
> For complete SELinux messages. run sealert -l
> 5701a4da-1d96-4c86-9747-e31b3d5d2219
> May 28 22:26:00 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 22:42:03 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
> For complete SELinux messages. run sealert -l
> 5701a4da-1d96-4c86-9747-e31b3d5d2219
> May 28 22:42:03 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 22:42:03 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
> For complete SELinux messages. run sealert -l
> 5701a4da-1d96-4c86-9747-e31b3d5d2219
> May 28 22:42:03 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 22:42:05 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 22:42:05 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 22:56:42 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
> May 28 22:56:42 srsblnfw01 setroubleshoot:      SELinux is preventing
> /usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
> (openvpn_t).      For complete SELinux messages. run sealert -l
> 0b738097-f92a-44c4-952b-7247d88a40e0
>
> In Centos4 one could enable / disable SElinux for certain services
> using system-config-securitylevel. This is not possible anymore in
> Centos5. One can only either enable or disable SElinux completely.
>
> Any ideas how to fix the problem so that OpenVPN starts-up correctly
> during boot-up?

Easiest thing to do is update policy with these two rules.

# grep openvpn /var/log/audit/audit.log | audit2allow -M myopenvpn
# semodule -i myopenvpn.pp

This will add the following rules:
allow openvpn_t pppd_t:fd use;
allow openvpn_t self:process execstack;

The pppd_t:fd is probably a leaked file descriptor and could probably be 
dontaudited.
The execstack is potentially a problem in openvpn_t.  This is probably a 
coding problem and should be reported as a bug/

SELinux Memory Protection Tests 
<http://people.redhat.com/%7Edrepper/selinux-mem.html>
>
> Best regards,
> Bernd
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
