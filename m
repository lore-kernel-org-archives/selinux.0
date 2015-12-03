Date: Thu, 3 Dec 2015 17:30:50 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Miroslav Grepl <mgrepl@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: continuation of systemd/SELinux discussion from Github
Message-ID: <20151203163049.GA29999@x250>
References: <20151202101801.GA1028@x250> <565F366E.3030403@tycho.nsa.gov>
 <20151202194715.GC1028@x250> <565F6167.5090507@tycho.nsa.gov>
 <56606797.1070609@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <56606797.1070609@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, Dec 03, 2015 at 05:02:31PM +0100, Miroslav Grepl wrote:

> 
> First I would like to talk about non-working "systemd --user" because we
> lack a support of pam_selinux in F23. So if you allow confined users to
> start user services you will end up with unconfined_service_t. Which is
> wrong because of systemd --user is running as init_t. The object manager
> helps here indeed.
> 
> We have pam_selinux support in F24 and theoretically you will end up
> with a correct user context. But without missing object manager you will
> be able to start user services under SELinux user context and under a
> user Linux identity.
> 
> This is a reason why I told this is broken now. We have more regressions
> here. And I believe that first we would have systemd --user running with
> correct labeling. We have it working for unconfined users on the latest
> rawhide because we removed unconfined_domain attribute for init_t and
> added needed fixes.
> 
> The second issue is missing object manager. It is strongly related to
> confined SELinux users who are defined by own restricted SELinux
> policies and still restricted by own Linux identity.
> 
> If we have running 'systemd --user' with the correct user type
> pam_selinux support then we can experiment and make working SELinux
> object manager in systemd --user at all if it is used and requested widely.
> 

Common, who are we kidding here? We hardly get any feedback on confined
users. Very little Fedora users use it. how long since the inception for
systemd did it take Fedora to get to this point?

I already did what you intent to do. I think i kind of know what is in
store for you. I predict that it is going to take a loooong time before
Fedora gets it into any semi serious state. I am not trying to be pessimistic
here.

Also this requires a bit of vision, anticipation if you will. If you can
see where systemd is going, and if you see what is already happening on
the system side with services running systemctl --system all over the
place controlling units, then you can easily determine the use case (or
at least some of the more easier ones)

I have been relying on the functionality for I can't remember how
long. I am going to have to live with a certain amount uncertainty for a long time
now. Where will this go?

Also, again let us be frank here. Confined users in Fedora is not what it
should be. Pretty much everything runs in a the "confined" user
domain, and that domain has all kinds of permissions a shell does not
need.

The level of confinement is determined by the boundaries. theres almost
no boundaries because there is no least privilege. E.g. most is just
allowed to run in the user domain. It just not unconfined (but it kind
of might as well be)

The proof is in the bugzilla:

https://bugzilla.redhat.com/show_bug.cgi?id=1269072

SSH was running a lot of stuff in the wrong domain. but Fedora never
noticed it. Why? because the confined domain are so broad. (theres
little boundaries)

Even guest_t was allowed to "setexec"....

Sorry, but I have no faith in this couse of action. I am just
disappointed by the lack of vision.

> -- 
> Miroslav Grepl
> Senior Software Engineer, SELinux Solutions
> Red Hat, Inc.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWYG41AAoJENAR6kfG5xmcrg0L/1zBmT9dwuVElvDbdFKlsqQ0
L3uhDKNWJwX/sHvmGKYI/fplzxP5kT+ME4/wmaeKnzNRszKpFkJkPeba2W6lxtYU
aPsKMxU48HpvEpKzMjr1Kb2eGaoQza955cn4Erppx7EHwLUzVXXR6rRyPIkLWfKI
gMwumRneWL72StzcX+lnANaoxwH6F+73OPbq2SmpKfwkkBJNENBbDzK+w1ZjNIpy
E18V0L2t2krwevn6Z0/p/idjnqoRukTLPAm/Zs1wLwQts0Cxcx0zKy7VoDXeozlo
GcMsL3IW6pyHDtJOvQ9gp1kRHx64B/6vdsgI2A994MEklWp7zPI6Fjxh3Vv9v/41
YGNOK8BvIdxgglcviFAu1b9Yp7hnatlRKdJM46eWovTQKmDk6IbwcafRMQw2wjyD
yr1mFap6I/5SzMfLBj1lcVSGIKvjM6gc5QAJh4YWSWQb5jq6MHlc0kdzXyj/EF/1
kusj4aIxy8k5FlmDzFJl6rQli+Hjf7B/JR4C5Yj4UQ==
=Fkf6
-----END PGP SIGNATURE-----
