Message-ID: <527AD1FE.9040200@gmail.com>
Date: Thu, 07 Nov 2013 00:34:22 +0100
From: =?UTF-8?B?VGltb3Row6llIFJhdmllcg==?= <siosm99@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Steve Lawrence <slawrence@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
References: <52715E75.5000005@redhat.com> <527168B1.4040905@tycho.nsa.gov> <52716DE6.8040401@redhat.com> <52716F8C.6060109@tycho.nsa.gov> <5271706B.2030201@tycho.nsa.gov> <52725064.4080508@tresys.com> <52725380.3050808@tycho.nsa.gov> <5272A6ED.1000504@redhat.com>
In-Reply-To: <5272A6ED.1000504@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 31/10/2013 19:52, Daniel J Walsh wrote:
> On 10/31/2013 08:56 AM, Stephen Smalley wrote:
>> I guess the question is what behavior is desired here.  If you remove the
>> type itself, then these days it will get treated as unlabeled (so it 
>> becomes inaccessible to anything that doesn't have permissions to 
>> unlabeled, but that shouldn't be an issue for unconfined users) and if 
>> someone later re-installs the package/policy, then it should get remapped
>> to its original context due to the deferred context mapping support.  Is
>> that sufficient?  If not, then my proposed approach above of pushing all of
>> the file type declarations into a single module (probably the base module)
>> and never removing them would allow the types to always remain valid but
>> they'd still be inaccessible except to domains that are allowed access to
>> file_type (e.g. unconfined) when you remove the modules defining the allow
>> rules.  Is that sufficient?  If not, then your approach of never removing
>> modules will work but seems the least optimal to me.
> 
> Well I like the idea of defining alias for modules when they are not
> installed.  The biggest problem I see is around executables and potentially
> readable content.  If I install a package that labels something as
> foobar_exec_t and leaves the content on uninstall, a confined domain that was
> able to execute foobar_exec_t will now not be able to execute unlabeled_t.
> 
> If we could alias foobar_exec_t to bin_t when foobar.pp is not installed, then
> we get a little closer to the default, and I don;t have restorecon -R -v
> fixing unlabeled_t files.
> 
> similarly  foobar_usr content to -> usr_t, and foobar_etc_t to etc_t
> foobar_var_t -> var_t ...

Hi,

I'm afraid this would cause undesired and unexpected "un-confining" of
programs / content that used to be confined which could lead to
information leaks for example.

Are programs needing access to data from an uninstalled packages
something that does effectively happen ? Requiring a custom policy to
allow such corner cases does not feel excessive here.

Moreover, changing the labels to some other valid ones may confuse the
admin/user more than if files were to be kept with their original labels
(if all the types are kept available at all times) or if the labels are
set to unlabeled_t which is explicitly telling what happened.

Cheers,

Tim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
