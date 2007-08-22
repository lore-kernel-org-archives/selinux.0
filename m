Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MLaK2Q027611
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 17:36:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7MLaJFu019392
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 21:36:19 GMT
Message-ID: <46CCAC4B.1060506@redhat.com>
Date: Wed, 22 Aug 2007 17:36:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov, Tom London <selinux@gmail.com>
Subject: Re: [PATCH] refpolicy: apps_vmware changes
References: <200708021956.l72Ju2S3029420@redsox.boston.devel.redhat.com> <1187812502.13874.98.camel@gorn>
In-Reply-To: <1187812502.13874.98.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Thu, 2007-08-02 at 15:56 -0400, dwalsh@redhat.com wrote:
>> Fixes for vmware
>> --- nsaserefpolicy/policy/modules/apps/vmware.fc        2007-07-03 07:05:43.000000000 -0400
>> +++ serefpolicy-3.0.5/policy/modules/apps/vmware.fc     2007-08-02 11:02:02.000000000 -0400
>> @@ -23,6 +23,7 @@
>>  /usr/bin/vmware-smbd           --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
>>  /usr/bin/vmware-smbpasswd      --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
>>  /usr/bin/vmware-smbpasswd\.bin --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
>> +/usr/bin/vmware-vmx            --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
>>  /usr/bin/vmware-wizard         --      gen_context(system_u:object_r:vmware_exec_t,s0)
>>  /usr/bin/vmware                        --      gen_context(system_u:object_r:vmware_exec_t,s0)
>>
>> --- nsaserefpolicy/policy/modules/apps/vmware.te        2007-07-25 10:37:37.000000000 -0400
>> +++ serefpolicy-3.0.5/policy/modules/apps/vmware.te     2007-08-02 11:02:02.000000000 -0400
>> @@ -29,7 +29,7 @@
>>
>>  allow vmware_host_t self:capability { setuid net_raw };
>>  dontaudit vmware_host_t self:capability sys_tty_config;
>> -allow vmware_host_t self:process signal_perms;
>> +allow vmware_host_t self:process { execstack execmem signal_perms };
>>  allow vmware_host_t self:fifo_file rw_fifo_file_perms;
>>  allow vmware_host_t self:unix_stream_socket create_stream_socket_perms;
>>  allow vmware_host_t self:rawip_socket create_socket_perms;
> 
> Which version of vmware requires this?  Other parts merged.
> 
>> @@ -56,6 +56,8 @@
>>  corenet_tcp_sendrecv_all_ports(vmware_host_t)
>>  corenet_udp_sendrecv_all_ports(vmware_host_t)
>>  corenet_raw_bind_all_nodes(vmware_host_t)
>> +corenet_tcp_bind_all_nodes(vmware_host_t)
>> +corenet_udp_bind_all_nodes(vmware_host_t)
>>  corenet_tcp_connect_all_ports(vmware_host_t)
>>  corenet_sendrecv_all_client_packets(vmware_host_t)
>>  corenet_sendrecv_all_server_packets(vmware_host_t)
>>
>>
I think these came from Tom?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGzKxKrlYvE4MpobMRAlW3AJ9PiuuwwMdoD074Sr8iQ5zgqcNUjACcDNmv
Pe0RvYxFAOqr7GVNah0hWPI=
=nEA0
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
