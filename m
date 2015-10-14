Date: Wed, 14 Oct 2015 17:48:29 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014154828.GA2909@x250>
References: <20151014133408.GA5222@x250> <561E5EF4.9080606@tycho.nsa.gov>
 <20151014141101.GB5222@x250> <561E63E0.1080609@tycho.nsa.gov>
 <20151014142952.GC5222@x250> <561E7840.50903@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <561E7840.50903@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Oct 14, 2015 at 11:44:00AM -0400, Stephen Smalley wrote:
> On 10/14/2015 10:29 AM, Dominick Grift wrote:
> >On Wed, Oct 14, 2015 at 10:17:04AM -0400, Stephen Smalley wrote:
> >>On 10/14/2015 10:11 AM, Dominick Grift wrote:
> >>>On Wed, Oct 14, 2015 at 09:56:04AM -0400, Stephen Smalley wrote:
> >>>>On 10/14/2015 09:34 AM, Dominick Grift wrote:
> >>>>>
> >>>>>I had some issue that just confused me (to say the least) It seems that
> >>>>>I have now solved this.
> >>>>>
> >>>>>There were two policy.X files in my /etc/selinux/SELINUXTYPE/policy dir,
> >>>>>on 29 an one 30. The 29 seemingly had a bug in it.
> >>>>>
> >>>>>It seems that load_policy (or its libselinux equivalent) defaults to
> >>>>>the lowest policy available (29 instead of 30 in this case)
> >>>>>
> >>>>>Why is that?
> >>>>>
> >>>>>I fixed the issue by removing the policy.29 file (i think at least)
> >>>
> >>>>What policy versions were supported by your kernel (cat
> >>>>/sys/fs/selinux/policyvers) and by your libsepol (checkpolicy -V)?
> >>>
> >>>/sys/fs/selinux/policyvers says: version 30, and checkpolicy says: 29 (compatibility range 29-15)
> >>>
> >>>That is weird because i have the latest libsepol installed (atleast
> >>>pretty recent):
> >>>
> >>># rpm -qa {libsepol*,libselinux*}
> >>>libselinux-utils-2.4-9999.git5aeb4c3.fc24.x86_64
> >>>libselinux-2.4-9999.git5aeb4c3.fc24.x86_64
> >>>libsepol-2.4-9999.git5aeb4c3.fc24.x86_64
> >
> >>Last release of libsepol predated policy 30 support.
> >
> >>However, if your kernel supports it, it should still be loaded.
> >>The logic is in selinux/libselinux/src/load_policy.c:
> >>selinux_mkload_policy().  With any modern kernel and configuration,
> >>libselinux should not need to patch in local definitions or booleans
> >>(already applied by libsemanage or preserved by the kernel), so maxvers
> >>should be set to the max of the kernel version (/sys/fs/selinux/policyvers)
> >>and the libsepol-supported version, and that should get loaded.
> >
> >>strace of load_policy might be interesting.
> >
> >That is the thing indeed. It works fine if i manually run
> >load_policy. But when i reboot it seemed to go back to the old one. (I am
> >not sure how fedora currently loads the policy)
> >
> >I removed the policy.29 now so i can't easily reproduce it now. and i do
> >not think an strace of a manual load_policy will reveal much as that
> >works fine and as expected. The problem only occurred when i rebooted
> >(when fedora load policy instead of me)
> >
> >Ohh , hmm maybe its a fedora initramfs issue... they probably have some
> >old stuff in there
> 
> AFAIK, systemd just calls selinux_init_load_policy() in libselinux (aka
> load_policy -i).  And the approach to selecting a policy version has been
> stable for quite a while, so I wouldn't expect the libselinux in the
> initramfs to differ in this respect.

Yes, its something else because in permissive mode it seemed to work. So
i suppose what ever it needed to do, it was denied somehow. ofcourse no
AVC denials or any other related messages in the logs. (i suppose
because it happens so early)

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

iQGcBAEBCgAGBQJWHnlIAAoJENAR6kfG5xmc3MoL/3WsZpohtTkTYDs09t1nl8Us
BSD3NZ+pSTFCb425vH/vBho0VAsLFVMyATnQiKjoJeiBaYiGo88qCy044UokUmOw
2hrp0PFUYPGAwdVaarT8ZVKuOxZ9nA4SdwJT+23KjjEK3Xd26gNlBUf/azhhvmWg
+Z4pAS9sUkmys3VKeqZV+ouEZqeHtusXWVz9p9coyURULODOVm2EPC3NrLt8wvRH
GM8nG4v1yT3oSnVNHACWCiENLeNWJ3GZ0RkhgXobAExKlYHgaNd3qTnVeOtpyffi
GqB4n4JBcNmOrr0i5UCk9GIaEVr5dUW8ddaos+8MY7L4ov4zQLc4QRR8Qt8DO1vk
1++jg2CipNbGPx7og5llMf6bsLXCdR0LcCXvoEy5euUwJNRwKecMo+Jwziig3/JJ
jpWrLLtbORKeP+7GY57q8Sr3jHKm8B8/xNIBQJ6Yu7IKBm/0eGm6egJuFg+Z5cwB
DPDx+JIEs3pp/7VRRDRwDUAqT9xcuFWHlFXSiKl97A==
=38wC
-----END PGP SIGNATURE-----
