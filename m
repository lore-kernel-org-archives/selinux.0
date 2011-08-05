Message-ID: <4E3B441A.1090900@windriver.com>
Date: Fri, 5 Aug 2011 09:15:06 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>,
        <refpolicy@oss1.tresys.com>
Subject: Re: checkpolicy is broken (which is not)
References: <4E3AEA75.3090602@redhat.com> <4E3B3D39.4020700@windriver.com>
In-Reply-To: <4E3B3D39.4020700@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Chris,

I think Dan's case below is a good example, that while
libsepol/checkpolicy/etc upgraded to 2011-07-27 release, people may have
not upgraded(or don't want/need to for the time being) the refpolicy to
the 2011-07-26 release accordingly, then people would run into this problem.

I am wondering if there is a need to add one note in selinux project
wiki page that once upgraded to 2011-07-27 release, at least the
3cbc9727 commit should be cherry-picked to refpolicy, if people still
prefer to older releases.

Thanks,
Harry

Harry Ciao 写道:
> Hi Dan,
>
> This "problem" had been fixed by Chris when the role attribute support
> is merged upstream, by adding one line of "role nx_server_r;" in nx.te.
> Other than that, one extra line of "role $_2;" would have to be added
> before the role-types rule used in the userdom_base_user_template().
>
> The commit id is 3cbc9727, I think you need to cherry-pick it.
>
> The reason is that the original role-type rule no longer used to declare
> a role, but solely focused on associating types with regular role or
> role attribute, whereas the newly added role-attr rule takes care of
> declaring regular role or role attribute, and optionally adding them
> into another role attribute.
>
> Thanks,
> Harry
>
> Daniel J Walsh 写道:
>   
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> This module used to compile and with the latest checkpolicy in upstream
>> it blows up on the role.
>>
>> # make -f /usr/share/selinux/devel/Makefile cat: /selinux/mls: No such
>> file or directory
>> Compiling targeted nx module
>> /usr/bin/checkmodule:  loading policy configuration from tmp/nx.tmp
>> nx.te":15:ERROR 'unknown role nx_server_r' at token ';' on line 3857:
>> role nx_server_r types nx_server_t;
>> # cjp: do we really need this?
>> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
>> make: *** [tmp/nx.mod] Error 1
>>
>>
>> Something to do with the role patch, I believe.
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.11 (GNU/Linux)
>> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>>
>> iEYEARECAAYFAk466m0ACgkQrlYvE4MpobOziACgsLrcXj4EHseXsRCf0fA98t+2
>> hx0An1TPUPcF+z4AAEso7dLgduVW4MNI
>> =xzsa
>> -----END PGP SIGNATURE-----
>>   
>>     
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
