Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BDeFVV028072
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 09:40:15 -0400
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5BDeE2p028252
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 13:40:14 GMT
Received: by rv-out-0708.google.com with SMTP id f25so3082283rvb.54
        for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 06:40:13 -0700 (PDT)
Message-ID: <484FD5B9.1010302@gmail.com>
Date: Wed, 11 Jun 2008 08:40:09 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
CC: Chad Hanson <chanson@TrustedCS.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: MLS constraint interfaces
References: <cadfc0e40806091430j7d4734c6l7af3cfbce395eeae@mail.gmail.com> <D709A20F2164C84E8B7014B0301F5EF8012E7F32@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8012E7F32@HAVOC.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Hanson wrote:
> mls_trusted_object(xdm_xserver_t) won't help this problem, but something
> like mls_file_read_up and mls_file_write_down would be more approriate
> for xdm_xserver_t.
>
> -Chad
>
>   
>> type=AVC msg=audit(1213041678.053:8): avc:  denied  { read } for
>> pid=2649 comm="Xorg" name="mem" dev=tmpfs ino=3893
>> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
>> tcontext=system_u:object_r:memory_device_t:s15:c0.c1023
>> tclass=chr_file
>> type=AVC msg=audit(1213041678.432:10): avc:  denied  { write } for
>> pid=2649 comm="Xorg" name="mem" dev=tmpfs ino=3893
>> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
>> tcontext=system_u:object_r:memory_device_t:s15:c0.c1023
>> tclass=chr_file
>>
>> The xserver_common_domain_template seems to have the necessary allow
>> rules (dev_read_raw_memory and dev_wx_raw_memory) for the types so  I
>> create a local module and added:
>> mls_trusted_object(xdm_xserver_t)
>> to deal with the MLS constraint violation but I'm still getting these
>> AVC.What else can it be?
>>
>> Ted
>>
>>     
>
>   
As I said in another post I've added mls interface calls to deal with 
these constraint violations. However I'm concerned about the breath of 
the interfaces in that they cover many classes/types of files when as 
far as I know the X server really only needs multilevel access to 
'chr_file'. Should there be more class specific interfaces?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
