Subject: Re: selinux-query
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Naina Emmanuel <nemmanuel1992@gmail.com>, selinux@tycho.nsa.gov
References: <CAN=9EoR_QojJRY6egdWUQQHemEwxBKNdQE+6Lc7TdHboPeKDEQ@mail.gmail.com>
 <CAN=9EoQn6o+YY=jfxQJ_HOQbxv1=7a_brQkEyQ-+YpBOBv=VZA@mail.gmail.com>
 <56F1A180.8080104@tycho.nsa.gov>
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <56F24A34.6060404@redhat.com>
Date: Wed, 23 Mar 2016 08:48:04 +0100
MIME-Version: 1.0
In-Reply-To: <56F1A180.8080104@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/22/2016 08:48 PM, Stephen Smalley wrote:
> On 03/22/2016 01:51 PM, Naina Emmanuel wrote:
>> Good evening!
>> i am working on selinux, centos 7... i have downloaded some .te files
>> from the internet (squid.te, ftp.te, rpc.te, samba.te .. etc)
>> but when i compile these .te file through #make -f
>> /usr/share/selinux/devel/include/MakeFile but shows error in all
>> mentioned .te files
>> not even getting installed through #semodule -i ftp.pp   (for all
>> mentioned .te files) plz help me regarding this..
>> thanks in advanced
> 
> Please show the actual commands that you ran, and the actual error
> output from those commands.
> 
> However, downloading random .te files from the Internet and expecting
> them to build or install on your system is probably not a good strategy.
>  On CentOS, you should be able to download the .src.rpm file for
> selinux-policy-targeted and work with the files it contains in order to
> ensure that they match your base policy.

Even more if you want to replace a module shipped by a distribution
policy and you will miss some definitions which are used in other
modules, you will also fail.

So I would go with .src.rpm how Stephen wrote above. You can ask on
selinux@lists.fedoraproject.org for more details.

Thanks.

> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
