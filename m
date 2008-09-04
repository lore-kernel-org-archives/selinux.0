Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m84ITUCW011055
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 14:29:30 -0400
Received: from yx-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m84ISrmp015729
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 18:28:53 GMT
Received: by yx-out-1718.google.com with SMTP id 3so46541yxi.84
        for <selinux@tycho.nsa.gov>; Thu, 04 Sep 2008 11:29:30 -0700 (PDT)
Message-ID: <cadfc0e40809041129r7f5e084cme61ad2ad3c38a689@mail.gmail.com>
Date: Thu, 4 Sep 2008 13:29:30 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: [PATCH][gnome.if]: bad gen_require type
Cc: "SELinux Mailing List" <selinux@tycho.nsa.gov>
In-Reply-To: <48C01A74.3070204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40809040809v43b12641n4a3556f1a53c384e@mail.gmail.com>
	 <48C01A74.3070204@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 4, 2008 at 12:27 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Xavier Toth wrote:
>> When I attempted to use this interface I got the follow error:
>> /usr/bin/checkmodule:  loading policy configuration from tmp/ml-launch.tmp
>> ml-launch.te":72:ERROR 'unknown type user_gconf_tmp_t' at token ';' on
>> line 5970:
>>       allow ml_launch_t user_gconf_tmp_t:dir { getattr search };
>>
>> --- serefpolicy-3.5.4/policy/modules/apps/gnome.if    2008-08-28
>> 17:36:53.000000000 -0500
>> +++ serefpolicy-3.5.4.new/policy/modules/apps/gnome.if        2008-08-28
>> 17:35:59.000000000 -0500
>> @@ -125,7 +125,7 @@
>>  #
>>  template(`gnome_stream_connect_gconf_template',`
>>       gen_require(`
>> -             type $1_gconfd_t, gconf_tmp_t;
>> +             type $1_gconfd_t, $1_gconf_tmp_t;
>>       ')
>>
>>       read_files_pattern($2, $1_gconf_tmp_t, $1_gconf_tmp_t)
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>
> In Rawhide it should be, since we don't types based on role.
>
>  #
>  template(`gnome_stream_connect_gconf_template',`
>        gen_require(`
>                type $1_gconfd_t, gconf_tmp_t;
>        ')
>>
>        read_files_pattern($2, gconf_tmp_t, gconf_tmp_t)
>

I just got 3.5.6 from koji and which contains:

template(`gnome_stream_connect_gconf_template',`
        gen_require(`
                type $1_gconfd_t, gconf_tmp_t;
        ')

        read_files_pattern($2, $1_gconf_tmp_t, $1_gconf_tmp_t)
        allow $2 $1_gconfd_t:unix_stream_socket connectto;
')

and not what your email indicated it should be for the read_files_pattern.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
