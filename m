Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7P9h9rT004046
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 05:43:09 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7P9h6uQ002867
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 09:43:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: named policy
Date: Wed, 25 Aug 2004 19:42:59 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>, Jason Vas Dias <jvdias@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
References: <200408241840.58207.russell@coker.com.au> <200408250249.01418.russell@coker.com.au> <1093370858.1800.221.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1093370858.1800.221.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_j8FLB8VtvmBwDVB"
Message-Id: <200408251942.59393.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_j8FLB8VtvmBwDVB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 25 Aug 2004 04:07, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Tue, 2004-08-24 at 12:49, Russell Coker wrote:
> > > 3) /var/named/chroot labeling changes seem wrong to me; the current .fc
> > > file provides consistent labels with a normal filesystem layout.
> >
> > The .fc file in CVS does use more consistent labels with a normal file
> > system. However I don't think that this is a benefit.
>
> If you were to remove named_t's access to base system types (like
> root_t, etc_t, var_t, tmp_t, ...) entirely and only support chroot'd
> operation, then it would make sense to only use named-specific types for
> the chroot environment and use the policy to prohibit any access by
> named outside of the chroot.  Otherwise, I think you want consistency
> between the chroot and non-chroot environment labeling for policy
> consistency between the two setups and to avoid overly permissive access
> to named even within the chroot.

We don't need the same types to have consistent policy.  If we have a 
read-only type such as named_conf_t instead of another read-only type such as 
etc_t or locale_t it makes no difference to the policy.

> Do you really want named_conf_t assigned to the chroot's /, /dev, /etc,
> /var, /var/run and any otherwise unspecified files within them?  Audit
> messages will be rather interesting there.  Nits:  Your .fc file also
> has no entries for /dev/zero or /var/named within the chroot.

OK, I've added those.

> Finally, 
> I don't see why chroot'd named is redhat-specific.

Because no other distribution does it the same way (AFAIK).



I've attached a new named.fc, tell me what you think about it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_j8FLB8VtvmBwDVB
Content-Type: text/plain;
  charset="iso-8859-1";
  name="named.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="named.fc"

# named
/var/named(/.*)?		system_u:object_r:named_zone_t
/var/named/slaves(/.*)?		system_u:object_r:named_cache_t
/etc/named\.conf	--	system_u:object_r:named_conf_t
ifdef(`distro_debian', `
/etc/bind(/.*)?			system_u:object_r:named_zone_t
/etc/bind/named\.conf	--	system_u:object_r:named_conf_t
/etc/bind/rndc\.key	--	system_u:object_r:named_conf_t
/var/cache/bind(/.*)?		system_u:object_r:named_cache_t
')
/etc/rndc.*		--	system_u:object_r:named_conf_t
/usr/sbin/named.*      	--	system_u:object_r:named_exec_t
/usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
/var/run/ndc		-s	system_u:object_r:named_var_run_t
/var/run/bind(/.*)?		system_u:object_r:named_var_run_t
/var/run/named.*		system_u:object_r:named_var_run_t
/usr/sbin/lwresd	--	system_u:object_r:named_exec_t
ifdef(`distro_redhat', `
/var/named/chroot(/.*)?		system_u:object_r:named_conf_t
/var/named/chroot/dev	-d	system_u:object_r:device_t
/var/named/chroot/dev/null   -c	system_u:object_r:null_device_t
/var/named/chroot/dev/random -c	system_u:object_r:random_device_t
/var/named/chroot/dev/zero -c	system_u:object_r:zero_device_t
/var/named/chroot/etc	-d	system_u:object_r:etc_t
/var/named/chroot/etc/localtime -- system_u:object_r:locale_t
/var/named/chroot/etc/named\.conf -- system_u:object_r:named_conf_t
/var/named/chroot/etc/rndc.* -- system_u:object_r:named_conf_t
/var/named/chroot/var/run/named.* system_u:object_r:named_var_run_t
/var/named/chroot/var/tmp(/.*)? system_u:object_r:named_cache_t
/var/named/chroot/var/named(/.*)? system_u:object_r:named_zone_t
/var/named/chroot/var/named/slaves(/.*)? system_u:object_r:named_cache_t
')

--Boundary-00=_j8FLB8VtvmBwDVB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
