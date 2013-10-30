Message-ID: <52716DE6.8040401@redhat.com>
Date: Wed, 30 Oct 2013 16:36:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
References: <52715E75.5000005@redhat.com> <527168B1.4040905@tycho.nsa.gov>
In-Reply-To: <527168B1.4040905@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/30/2013 04:14 PM, Stephen Smalley wrote:
> On 10/30/2013 03:31 PM, Daniel J Walsh wrote:
>> We are trying to shrink out cloud image as small as possible.  One idea
>> was to shrink SELinux Policy footprint by adding compression to it.
>> 
>> Here is a patch I have been fooling around with which would read a
>> policy.29 file if it was compressed with xz.
>> 
>> xz compression does around a 90% compression on the policy file,  and
>> does not slow the load in any meaningfull way.
>> 
>> I also have done a patch to try out gzip.
>> 
>> gzip and xz are already used in systemd, which means we would not need to
>> add a new requirement to the minimal system.
>> 
>> xz seems quicker and smaller then gzip.
>> 
>> Have not started playing with libsemanage yet.
>> 
>> What do you think?  Is xz availabel on Android?
> 
> Personally, I'd much rather see work done on shrinking the actual policy 
> size in Fedora rather than just compressing it.  Both by reducing the 
> overall size of refpolicy through coalescing similar domains/types and by
> making better use of the work that has already been done to support putting
> policy modules into rpms and only installing what actually get used.
> 
> On the former, I wrote a little tool for Android called sepolicy-analyze 
> that identifies all equivalent types in the policy.  It works nicely on the
> Android policy but unfortunately I gave up waiting on it running on Fedora
> policy because it is so large.  We're also looking at extending that tool
> to identify isomorphic types, not just equivalent ones.  I know apol has a
> similar feature under the Analysis tab (Types relationship summary) but it
> only does it on a pairwise basis; there doesn't seem to be any way to apply
> it systematically.
> 
> Anyway, with regard to impact on Android of your patch, it won't affect it
> as libselinux is forked (and significantly modified) there as Joshua noted
> and we don't bring over any of libsemanage or policycoreutils either (we
> reimplemented the pieces of policycoreutils that we wanted in the Android
> init and toolbox programs, just as people previously did in busybox).  And
> we only build/use libsepol and checkpolicy on the build host, not the
> device.  So I think the only real concern is whether this is an acceptable
> dependency on conventional Linux distros.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
Well we have done some work on combining like domains, see antivirus and
spamassassin, but this is a lot of work which no one has time for.

I would love to see the mailserver and mailclients domains combined.

If people want to suggest or more importantly submit patches to combine other
domains, I am all for it.

Problems with shipping policy within rpm still exists. although we (Red Hat)
are at least moving toward layered products shipping their own policy.
openstack-selinux, openshift-selinux, gluster-selinux.  This is more for them
updating quicker then RHEL.

1. semanage is slowwwwwwwww.  If we ran all pp files without combining them
into a single transaction the installation  and yum updates would take a long
time.
2.  Cordination between domains, we put a fix into an interface and we need to
trigger 10 packages to update.

For every apache bug in policy, do we want to wait for an update apache
package, or do we ship lots more packages.

3. Uninstall of types leaves unlabeled_t content on disk.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJxbeYACgkQrlYvE4MpobOrgwCgqurQA/VYLedbOs4nKzysnsIy
Q8AAoOd7jQXImOyRbhDDoMHWhzZ1d/h4
=V0Rp
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
