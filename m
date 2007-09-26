Message-ID: <46FA7107.2000003@manicmethod.com>
Date: Wed, 26 Sep 2007 10:47:35 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I am concerned about putting genhomedircon changes in libsemanage
 into Fedora 8.
References: <46CED283.8060804@redhat.com> <46FA661F.1080703@redhat.com>
In-Reply-To: <46FA661F.1080703@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Daniel J Walsh wrote:
>   
>> I may hold off on this so we can get a full Rawhide cycle on it.
>> genhomedircon has many corner cases and do not want to risk blowing F-8
>> now that we are at Feature Freeze.
>> All the rest of the patches have been integrated.
>
>
>
> The genhomedircon replacement is broken in libsemanage.  It is
> generating invalid file context.  The python version verified the
> file context it was creating were valid before assiging them.  This is
> resulting in Fedora Core 8 not being able to autorelabel
>
>   

The python version did the wrong thing entirely. It validated the 
contexts against the running policy in the kernel, which breaks when you 
try to do an operation on another store. Also since we moved 
genhomedircon inside of libsemanage the new policy isn't even loaded yet 
so we can't validate against the kernel (or the new types added by the 
module being added would be 'invalid'). The only real way to validate 
the contexts now would be to load the newly generated policy into the 
libsepol security server and to the context validations on it.

This would work, it would just take extra time at module load time. It 
seems like the real problem is that the invalid contexts are being 
generated in the first place, relying on genhomedircon to sanity check 
your file contexts seems like you are punting the problem.

>  /sbin/fixfiles restore
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs:  line 26
> has invalid context user_u:object_r:user_gconf_home_t:s0
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs:  line 51
> has invalid context user_u:object_r:user_gconf_tmp_t:s0
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs:  line 60
> has invalid context mytuser_u:object_r:mytuser_gnome_home_t:s0
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs:  line 63
> has invalid context mytuser_u:object_r:httpd_mytuser_content_t:s0
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs:  line 64
> has invalid context mytuser_u:object_r:mytuser_home_ssh_t:s0
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs:  line 65
> has invalid context mytuser_u:object_r:mytuser_uml_rw_t:s0
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs:  line 66
> has invalid context mytuser_u:object_r:mytuser_mozilla_home_t:s0
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs:  line 67
> has invalid context mytuser_u:object_r:mytuser_xauth_home_t:s0
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs:  line 68
> has invalid context mytuser_u:object_r:mytuser_fonts_t:s0
> Exiting after 10 errors.
>
> mytuser does not execute the mozilla_per_role_template to these types
> are not valid.  genhomedircon is only supposed to generate valid context.
>
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
