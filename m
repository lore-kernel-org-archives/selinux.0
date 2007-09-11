Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8BKVaN8026427
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 16:31:36 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8BKVYbi000739
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 20:31:35 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8BKVY0Z030497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 16:31:34 -0400
Message-ID: <46E6FB25.5070507@redhat.com>
Date: Tue, 11 Sep 2007 16:31:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: concept of a permissive domain
References: <1189537981.3407.51.camel@localhost.localdomain>
In-Reply-To: <1189537981.3407.51.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eric Paris wrote:
> So there was a brief conversation between dan, karl, and myself today
> about implementing a permissive subject domain.  Basically there would
> be some new language construct possibly "permissive httpd_t true;" which
> would then set a flag.  If this flag was set, all denials would be
> logged but the operation would be permitted.  This would make it
> possible to create a type_exec_t and type_t for your new domain, mark it
> as permissive/unconfined and run it as long as you like.  Once you get
> all your new allow rules you just remove the permissive bit.  You didn't
> have to setenforce the whole system.
> 
> First thought from Karl was to use the 'char primary' field of the
> struct type_datum.  Seems reasonable enough, after we have that
> information in kernel it shouldn't take me too much playing around in
> avc_has_perm_noaudit to check if this flag is set on a denial.  I don't
> think slowing down the denial path a little by having to call back in to
> see if this flag was set for a given source sid is that big of deal.
> Maybe I could keep it just about as fast by adding more flags
> audit_allow_once (can't really reuse audit_allow) to the avd or
> something like that, but it seems like a large waste of space to carry
> another set of audit flags that won't be used much.
> 
> Thoughts?  Other ways to implement this?  Problems with the basic premis
> of an unconfined domain?
> 
> -Eric
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

Lets not call it an unconfined domain.   This is a permissive domain.
The idea is to collect avc messages as if it was confined, and allow me
to write policy based on this.

This would solve several problems.

1. Customers want to be able to write policy and distribute it within
their environments and let it run for a couple of months in permissive
mode,  Continuously gathering AVC messages and updating policy.  When
they are satisfied that the policy works as defined.  They can turn off
the permissive mode and have a feeling of confidence that the policy
will not break their application.  They fear that putting  out too
restrictive of a policy will cause them to loose money.
2. Customers are upset that they lost disable_trans, because they
sometimes want to say just let a domain run and don't care about it.
So if they could turn that domain to permissive they could maintain
their security on other domains.  Currently they have to put the machine
in permissive mode or become policy writers.  (chcon -t bin_t works but
does not survive a relabel)

3 When writing policy we currently tell people to turn their machine to
permissive, which is a security risk.  If we could just run the domain
in permissive mode, we would not decrease the overall security of the
system.

4 Finally as we introduce the concept of confined user domains, it would
be interesting to apply a confined admin domain to a admin user and then
record the avc's he generates while in permissive mode.  It would allow
us to better understand the needs of a admin user.

One other feature/requirement would be to not override dontaudit rules.
So if I have a domain in permissive mode and I have a dontaudit rule  on
reading /etc/shadow.  The app should still be denied reading
/etc/shadow.  (This is not a show stopper, but would allow us to force
apps to take the code paths they will take in enforcing mode.)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG5vslrlYvE4MpobMRAphWAKDrykJk05Y3gUT+8zB9ZLJGtp8c/QCfXRoh
pzE/k8a/YDqE/FIKadMDxy0=
=GtJx
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
