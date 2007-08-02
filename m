Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72I2Xsm011165
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:02:33 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l72I2Vev003770
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:02:32 GMT
Message-ID: <46B21C29.906@manicmethod.com>
Date: Thu, 02 Aug 2007 14:02:17 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: fedora-selinux-list@redhat.com, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        selinux@tycho.nsa.gov
Subject: Re: SE-PostgreSQL for Fedora (Re: Guideline for RPM packages)
References: <46681714.3030009@kaigai.gr.jp> <1181227502.11979.24.camel@moss-spartans.epoch.ncsc.mil> <46681ED6.1010408@kaigai.gr.jp> <46A861F6.10709@ak.jp.nec.com> <46A8CAE0.7030809@kaigai.gr.jp> <46B207B3.6040703@manicmethod.com> <46B21986.5040806@kaigai.gr.jp>
In-Reply-To: <46B21986.5040806@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Joshua Brindle wrote:
>   
>> KaiGai Kohei wrote:
>>     
>>> By the way, I'm seeking sponsors who can review SE-PostgreSQL package.
>>>
>>>   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249522
>>>
>>> If you can volunteer the reviewing process, please contact me.
>>>   
>>>       
>> So, I tried grabbing the sepostgres srpm and building it (you didn't
>> provide an x86_64 rpm) and I get these compilation errors:
>>
>> gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
>> -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic -Wall
>> -Wmissing-prototypes -Wpointer-arith -Winline
>> -Wdeclaration-after-statement -Wendif-labels -fno-strict-aliasing -g -D
>> SECCLASS_DATABASE= -I../../../src/include -D_GNU_SOURCE -c -o
>> sepgsqlCore.o sepgsqlCore.c
>> sepgsqlCore.c: In function 'sepgsqlGetDatabaseContext':
>> sepgsqlCore.c:792: error: expected expression before ')' token
>> sepgsqlCore.c: In function 'sepgsqlInitialize':
>> sepgsqlCore.c:836: error: expected expression before ',' token
>> sepgsqlCore.c:854: error: expected expression before ',' token
>> make[3]: *** [sepgsqlCore.o] Error 1
>> make[3]: Leaving directory
>> `/usr/src/redhat/BUILD/postgresql-8.2.4/src/backend/security'
>> make[2]: *** [security-recursive] Error 2
>>     
>
> Joshua,
>
> It seems to me that SECCLASS_DATABASE is defined as empty.
>
> It is normally computed at %build section of the specfile as follows:
>
>   SECCLASS_DATABASE=`grep ^define %{_datadir}/selinux/devel/include/support/all_perms.spt \
>                          | cat -n | grep all_database_perms | awk '{print $1}'`
>   make CUSTOM_COPT=" -D SECCLASS_DATABASE=${SECCLASS_DATABASE}" %{?_smp_mflags}
>
> Thus, selinux-policy-devel-xxx-sepgsql have to be installed to build.
>
> If SECCLASS_DATABASE is not defined, it's defined as 61 being next to SECCLASS_DCCP_SOCKET.
> It is correct, if Fedora 6. But incorrect on the latest Fedora 7 and Rawhide.
>
>   

Err, I think you should be using the new userland discovery interface
for this, hardcoding at compile time is a very bad idea (it makes the
compiled binaries completely non-portable).

look at libselinux/checkAccess.c in the trunk version to see how it is
used, essentially something like:

dbase_class = string_to_security_class("database");
if (dbase_class == 0)
return 0;

That lets you discover the class offset at runtime. There are also
facilities for doing the same with permissions.

> As you mentioned, I also think this trick is not a good idea.
> However, the number of object classes is not constant between policy versions,
> so I had to handle the difference and to follow the version up.
> I modified it by hand at first, but conditional definition for SECCLASS_DATABASE
> got necessary, because the number of object classes got differ between Fedora core 6
> and Fedora 7.
>
> I think integration of these definitions into the base policy is the best way
> to avoid such a ugly implementation. :)
>
> Thanks,
>
>   
>> As an aside to this, I notice that you tried to integrate policy
>> management into the RPM, and I had to modify my spec file to not do this
>> because I have my own custom policies on the system. I don't think this
>> is the best way, long term, to handle policy integration, though,
>> unfortunately, I don't have any better suggestions. This is something I
>> intend to look into soon though so I'll provide some feedback on the
>> previous thread when I have something useful to say :)
>>     
>
> --
> KaiGai Kohei <kaigai@kaigai.gr.jp>
>
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
