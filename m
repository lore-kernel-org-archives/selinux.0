Date: Wed, 14 Oct 2015 18:26:03 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014162601.GB2909@x250>
References: <20151014133408.GA5222@x250> <561E5EF4.9080606@tycho.nsa.gov>
 <20151014141101.GB5222@x250> <561E63E0.1080609@tycho.nsa.gov>
 <20151014142952.GC5222@x250> <561E7840.50903@tycho.nsa.gov>
 <20151014154828.GA2909@x250> <561E7D47.7090306@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <561E7D47.7090306@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Oct 14, 2015 at 12:05:27PM -0400, Stephen Smalley wrote:
> On 10/14/2015 11:48 AM, Dominick Grift wrote:
> >On Wed, Oct 14, 2015 at 11:44:00AM -0400, Stephen Smalley wrote:
> >>On 10/14/2015 10:29 AM, Dominick Grift wrote:
> >>>On Wed, Oct 14, 2015 at 10:17:04AM -0400, Stephen Smalley wrote:
> >>>>On 10/14/2015 10:11 AM, Dominick Grift wrote:
> >>>>>On Wed, Oct 14, 2015 at 09:56:04AM -0400, Stephen Smalley wrote:
> >>>>>>On 10/14/2015 09:34 AM, Dominick Grift wrote:
> >>>>>>>
> >>>>>>>I had some issue that just confused me (to say the least) It seems that
> >>>>>>>I have now solved this.
> >>>>>>>
> >>>>>>>There were two policy.X files in my /etc/selinux/SELINUXTYPE/policy dir,
> >>>>>>>on 29 an one 30. The 29 seemingly had a bug in it.
> >>>>>>>
> >>>>>>>It seems that load_policy (or its libselinux equivalent) defaults to
> >>>>>>>the lowest policy available (29 instead of 30 in this case)
> >>>>>>>
> >>>>>>>Why is that?
> >>>>>>>
> >>>>>>>I fixed the issue by removing the policy.29 file (i think at least)
> >>>>>
> >>>>>>What policy versions were supported by your kernel (cat
> >>>>>>/sys/fs/selinux/policyvers) and by your libsepol (checkpolicy -V)?
> >>>>>
> >>>>>/sys/fs/selinux/policyvers says: version 30, and checkpolicy says: 29 (compatibility range 29-15)
> >>>>>
> >>>>>That is weird because i have the latest libsepol installed (atleast
> >>>>>pretty recent):
> >>>>>
> >>>>># rpm -qa {libsepol*,libselinux*}
> >>>>>libselinux-utils-2.4-9999.git5aeb4c3.fc24.x86_64
> >>>>>libselinux-2.4-9999.git5aeb4c3.fc24.x86_64
> >>>>>libsepol-2.4-9999.git5aeb4c3.fc24.x86_64
> >>>
> >>>>Last release of libsepol predated policy 30 support.
> >>>
> >>>>However, if your kernel supports it, it should still be loaded.
> >>>>The logic is in selinux/libselinux/src/load_policy.c:
> >>>>selinux_mkload_policy().  With any modern kernel and configuration,
> >>>>libselinux should not need to patch in local definitions or booleans
> >>>>(already applied by libsemanage or preserved by the kernel), so maxvers
> >>>>should be set to the max of the kernel version (/sys/fs/selinux/policyvers)
> >>>>and the libsepol-supported version, and that should get loaded.
> >>>
> >>>>strace of load_policy might be interesting.
> >>>
> >>>That is the thing indeed. It works fine if i manually run
> >>>load_policy. But when i reboot it seemed to go back to the old one. (I am
> >>>not sure how fedora currently loads the policy)
> >>>
> >>>I removed the policy.29 now so i can't easily reproduce it now. and i do
> >>>not think an strace of a manual load_policy will reveal much as that
> >>>works fine and as expected. The problem only occurred when i rebooted
> >>>(when fedora load policy instead of me)
> >>>
> >>>Ohh , hmm maybe its a fedora initramfs issue... they probably have some
> >>>old stuff in there
> >
> >>AFAIK, systemd just calls selinux_init_load_policy() in libselinux (aka
> >>load_policy -i).  And the approach to selecting a policy version has been
> >>stable for quite a while, so I wouldn't expect the libselinux in the
> >>initramfs to differ in this respect.
> >
> >Yes, its something else because in permissive mode it seemed to work. So
> >i suppose what ever it needed to do, it was denied somehow. ofcourse no
> >AVC denials or any other related messages in the logs. (i suppose
> >because it happens so early)
> 
> Prior to initial policy load, everything is allowed (even if enforcing), so
> it can't be a SELinux permission denial.

I know that , but it seems to work in permissive mode but not in
enforcing mode.., and I think it only happens if there are both 29 and
30 policy files (i use this policy on several systems and the issue only
happened on one the system that had the dangling 29 file)

Anyhow too much speculation. I just do not know what is
going on. However I think I seem to have solved the immediate issue so I
am good with that. I will keep my eyes open for related issues.

It is a very strange issue because it also did not happen
consistently. First I thought it was a policy issue, but I have this
policy on various identical systems and it only happened on one
particular system (the system that had the dangling 29 file it turns
out), then I thought it was hardware specific issue because It worked
fine on all my other systems (same policy just different hardware).

Heck , I may turn out to be wrong, and the issue may happen again after
all since I can't reproduce it very consistently, it happens almost
always (every boot) but not quite.

Thanks for the information. Please consider the issue resolved and if it
happens again or if I find out what caused it then I will let the list
know.

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

iQGcBAEBCgAGBQJWHoIUAAoJENAR6kfG5xmcSWoL/1aXu3uWykJOZ/vxeuMRXKEE
p1pr1wEU1Q54Zam+OcRfBdgf4ZILbo04NBXUgnpawT0SY54Kv8RkZDzCjRonu5Gb
/82a09WE9VARHfWQIdqEPH1p3a3Ukv1ZgyHkyNi5YwsVoxU0jpNgyoD8P0AOL/MZ
hNZlg/57wjtT80RnpOdplhQAbJSzyolzSto+Muxa1WX7Scy5i84J8penRF4i/yWz
A91MnNksPnQo305W3XresO1NGditFH6eWa1nocGWvlboFprGQm6IhZJmY1bxU+QD
Z2lBJDdKXyzIKb415rHNp6n8ySK/t5PDOFT/1Pvvb+itI2FGd8hS82uPZKR/MP65
ggkFasMMbSQXO/a//zJuCgaYbJifNcexsOrQDjAsSQO7xyCJHnQrFXImI6UtA0Xs
B49w3ELHjfTxqlkcRGXgBmVnr7nZfWnyHtpoSjB+Oz0ZZIl+fU7s43LpWv7O4Ywv
nBVd8RWpuL7wqLef81AsiLo6DqI6riELX2AALA+Qsg==
=Pftr
-----END PGP SIGNATURE-----
