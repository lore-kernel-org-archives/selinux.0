Subject: Re: does it make sense that dac_override get's checked before
 dac_read_search?
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <56F2B5F7.9050406@gmail.com> <56F2C7A5.1090303@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56F2F756.6020401@gmail.com>
Date: Wed, 23 Mar 2016 21:06:46 +0100
MIME-Version: 1.0
In-Reply-To: <56F2C7A5.1090303@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/23/2016 05:43 PM, Stephen Smalley wrote:
> On 03/23/2016 11:27 AM, Dominick Grift wrote:
>> 
>> A long time ago Eric Paris hinted that the policy WRT
>> dac_override could probably be cleaned up.
>> 
>> I suspect that most of the the time dac_override is not needed
>> (too coarse). Instead dac_read_search would be sufficient for the
>> common scenario where root processes traverse locations where it
>> doesn't have DAC permissions to traverse.
>> 
>> The problem is that dac_override seems to be checked first. but 
>> dac_override , if i understand it, is broader than
>> dac_read_search
>> 
>> so why is dac_read_search not checked before dac_override?
> 
> I would be in favor of flipping the order of checks, but not sure
> how receptive upstream would be.  Outside of LSMs, the order
> doesn't matter since it isn't being audited, and checking
> CAP_DAC_OVERRIDE first does allow them to optimize for the case
> where the process has it.  In their world, the case where a process
> has CAP_DAC_READ_SEARCH but not CAP_DAC_OVERRIDE is rare.
> 
> A somewhat similar case was the order of checks in can_do_mlock,
> which did get reversed: commit
> a5a6579db33af91f4f5134e14be758dc71c1b694 Author: Jeff Vander Stoep
> <jeffv@google.com> Date:   Thu Mar 12 16:26:17 2015 -0700
> 
> mm: reorder can_do_mlock to fix audit denial
> 
> A userspace call to mmap(MAP_LOCKED) may result in the successful 
> locking of memory while also producing a confusing audit log
> denial. can_do_mlock checks capable and rlimit.  If either of these
> return positive can_do_mlock returns true.  The capable check leads
> to an LSM hook used by apparmour and selinux which produce the
> audit denial.  Reordering so rlimit is checked first eliminates the
> denial on success, only recording a denial when the lock is
> unsuccessful as a result of the denial.
> 
> However, in that case reordering the checks was more performant in
> the common case.
> 

After giving it some thought. I dont think it matters. dac_read_search
is useless. because it overlaps with dac_override. only one of the two
is meaningful and it can only be dac_override because that one is
comprehensive.

You see if dac_read_search would be checked first then dac_override
would be useless.


- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW8vdRAAoJECV0jlU3+Udp6aYMAIcMxZGHl6Zk6UP1VhzLeTUv
IKFYrfITr8vLu8Fxg6CHu+a6L32dZWE99zcRfZo95Ic8zY/9J+6O1QU0JHR8JdiQ
LxKmUVoXli2Cl7piTjDg3f2ZP0SXSae8c3aETh539jvsVI4/tt+HfIG1fqKj37ZK
BDDR8vqP5Pm1eqT1KnnKqQEBxOKOHa3xExV9zm3DCbn1FWfcDrOw//peNtB4kggm
OrNFsKk1LUsubnxQe+4b0fjORWYr6bNt6VLtvoN7Tn3WaiW9yz4MmhJKxjQAm4yK
QCPtcdUVsicsCd7ip6eGWVNbimrtVOuPskUu7gxxIz59hQwKM7T0rF4PQrZiG646
m+3RQzlxNQiNlLhzV30Ei8AFAc8qN3BU6qt5nMx0h741nz6klF5Bz9tkgHMdE0KX
1g2/a4XQu8MV8uVDFwSklq7scy9SuuvD9GWRFn30Xy8KB+LoXL3PrbUpCdHSBKo4
r6+gwH2Kat5sJPForkJcoPCjcbWdj7dhzCO+oRwfWg==
=rTfp
-----END PGP SIGNATURE-----
