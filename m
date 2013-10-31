Message-ID: <5272A6ED.1000504@redhat.com>
Date: Thu, 31 Oct 2013 14:52:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Steve Lawrence <slawrence@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
References: <52715E75.5000005@redhat.com> <527168B1.4040905@tycho.nsa.gov> <52716DE6.8040401@redhat.com> <52716F8C.6060109@tycho.nsa.gov> <5271706B.2030201@tycho.nsa.gov> <52725064.4080508@tresys.com> <52725380.3050808@tycho.nsa.gov>
In-Reply-To: <52725380.3050808@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/31/2013 08:56 AM, Stephen Smalley wrote:
> On 10/31/2013 08:43 AM, Steve Lawrence wrote:
>> On 10/30/2013 04:47 PM, Stephen Smalley wrote:
>>> On 10/30/2013 04:43 PM, Stephen Smalley wrote:
>>>> On 10/30/2013 04:36 PM, Daniel J Walsh wrote:
>>>>> Well we have done some work on combining like domains, see
>>>>> antivirus and spamassassin, but this is a lot of work which no one
>>>>> has time for.
>>>>> 
>>>>> I would love to see the mailserver and mailclients domains
>>>>> combined.
>>>>> 
>>>>> If people want to suggest or more importantly submit patches to 
>>>>> combine other domains, I am all for it.
>>>>> 
>>>>> Problems with shipping policy within rpm still exists. although we 
>>>>> (Red Hat) are at least moving toward layered products shipping
>>>>> their own policy. openstack-selinux, openshift-selinux,
>>>>> gluster-selinux.  This is more for them updating quicker then
>>>>> RHEL.
>>>>> 
>>>>> 1. semanage is slowwwwwwwww.  If we ran all pp files without 
>>>>> combining them into a single transaction the installation  and yum
>>>>> updates would take a long time.
>>>> 
>>>> Yes, I have to wonder if we don't need a complete
>>>> overhaul/replacement of libsemanage (+ module portions of libsepol).
>>>> It seems like semodule/semanage transactions are far slower than
>>>> running the entire policy through checkpolicy again (i.e. just using
>>>> source modules and running them through m4 + checkpolicy on each
>>>> transaction, ala the source policy module work that sadly has yet to
>>>> reach maturity/completion).
>>> 
>>> However, on this note, I'm pretty sure that the rpm work allows you to 
>>> just collect up all of the policy modules and run semodule once at the 
>>> end (collections or whatever).  So that particular problem should be 
>>> solved already even for the binary modules.
>>> 
>> 
>> This is correct. the collection feature of RPM gathers up all selinux 
>> policies from all the rpms in the yum/rpm transaction and installs them 
>> all in a single semanage transaction. Note that although the work was 
>> upstreamed, last I checked, the building of the selinux plugin that 
>> performs the work to aggregate and install the policy modules is 
>> currently disabled on fedora.
> 
> That seems surprising given that it was developed for Fedora originally. 
> Can someone ping Panu or whoever is maintaining rpm these days and ask why
> it is disabled or whether it can be enabled?
> 
>>>>> 3. Uninstall of types leaves unlabeled_t content on disk.
>>>> 
>>>> That's the only one that seems fundamental.  What if we pushed all
>>>> file type declarations into their own module linked to the base
>>>> filesystem package and just always installed that?  That won't affect
>>>> policy size substantially; it is the allow rules that are the issue
>>>> IIUC, not just the type decls.
>>>> 
>> 
>> The way this is handled in the RPM collection feature is modules are 
>> never uninstalled, even if the package that installed that module is. Not
>> ideal, but it solves this problem.
> 
> I guess the question is what behavior is desired here.  If you remove the
> type itself, then these days it will get treated as unlabeled (so it 
> becomes inaccessible to anything that doesn't have permissions to 
> unlabeled, but that shouldn't be an issue for unconfined users) and if 
> someone later re-installs the package/policy, then it should get remapped
> to its original context due to the deferred context mapping support.  Is
> that sufficient?  If not, then my proposed approach above of pushing all of
> the file type declarations into a single module (probably the base module)
> and never removing them would allow the types to always remain valid but
> they'd still be inaccessible except to domains that are allowed access to
> file_type (e.g. unconfined) when you remove the modules defining the allow
> rules.  Is that sufficient?  If not, then your approach of never removing
> modules will work but seems the least optimal to me.
> 
Well I like the idea of defining alias for modules when they are not
installed.  The biggest problem I see is around executables and potentially
readable content.  If I install a package that labels something as
foobar_exec_t and leaves the content on uninstall, a confined domain that was
able to execute foobar_exec_t will now not be able to execute unlabeled_t.

If we could alias foobar_exec_t to bin_t when foobar.pp is not installed, then
we get a little closer to the default, and I don;t have restorecon -R -v
fixing unlabeled_t files.

similarly  foobar_usr content to -> usr_t, and foobar_etc_t to etc_t
foobar_var_t -> var_t ...


> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJypu0ACgkQrlYvE4MpobPR7QCfbNb+dv1mBHrBXsXNK/v97t36
7lMAoODN4Uk/JtjsEVw3ksDNF2u+HpvT
=YwCv
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
