From: "Spector, Aaron" <Aaron_Spector@mcafee.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "SELinux (selinux@tycho.nsa.gov)"
 <selinux@tycho.nsa.gov>, "Paul Moore (paul@paul-moore.com)"
 <paul@paul-moore.com>
Subject: RE: Switching to enforcing mode introduces new policy issues?
Date: Fri, 24 Apr 2015 15:57:58 +0000
Message-ID: <73c3e069515544578eb3a2798436f272@MIVEXUSR1N01.corpzone.internalzone.com>
References: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A362B.7040500@tycho.nsa.gov>
 <0787916bff754fec87b219654e47b1e0@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A60D2.30105@tycho.nsa.gov>
In-Reply-To: <553A60D2.30105@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

That's what I thought with regards to the file opens. It seemed to work when I lacked the directory search permission, but once it came up and I thought about it, it made sense. I'm just not sure why I didn't see the deny in permissive mode.. All of the rules I have had to add have made sense in the grand scheme of things.

Is it possible to examine the cache for what lookups have happened, similar to how sesearch works? Perhaps my permissive mode is actually denying some operations, but not telling me for some reason.


If I was rolling over the kernel ring buffer, wouldn't I be missing the initial boot events? I've got the entire boot sequence in dmesg.


-Aaron

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Friday, April 24, 2015 10:27 AM
To: Spector, Aaron; SELinux (selinux@tycho.nsa.gov); Paul Moore (paul@paul-moore.com)
Subject: Re: Switching to enforcing mode introduces new policy issues?

On 04/24/2015 11:18 AM, Spector, Aaron wrote:
> I noticed the ratelimiting happening a while ago, but if it was happening here, I should get suppression logs correct? I've been checking my avc audits by examining dmesg / viewing that output via a serial console and nothing in there implies that I'm missing logs. When in permissive I can see the policy load audit (<time>:2) and if I break my policy on purpose, the next one is (<time>:3) as expected. When I reboot in enforcing (without the broken policy), I see the policy load (<time>:2) and then I see a new deny on (<time>:3) that doesn't appear in a permissive boot. I'm also not seeing any gaps in the audit sequence numbers.
> 
> It may be that you're right about using different code paths in enforcing, it just seems weird that if I didn't deny it in permissive, why would I deny it in enforcing? It seems logical that I'd see new permission checks if a new portion of code was taken.
> 
> What I've had to do to make a bit of progress is add new allow rules for the dir class. The only difference between boots is either I add 'enforcing=1' to the kernel boot params in the bootloader or I alter the /etc/config/selinux file to use enforcing mode. An example would be:
> 
> # This is all I needed in permissive mode Allow type_a_t type_b_t : 
> file { read open }; # In enforcing, I now get denies for this Allow 
> type_a_t type_b_t : dir { search };
> 
> I'm surprised that I've never seen denies that relate to that second rule while in permissive mode before. They're not the only new denies I've seen, but they are most frequent. I've been adding to the policy with the rules to allow the denies, rebuilding, reinstalling, rebooting and I get slightly farther each time due to the new rules.

Yes, you should see audit_lost= messages if you are losing audit records.

In order to open a file, you have to be able to search the parent directory, so both rules would always be necessary to open a file in a directory if they both have the same type.  So you should be getting the directory search denial even in permissive mode.

In addition to hitting the audit backlog or rate limits, you could be rolling over the kernel ring buffer and thus losing messages that way on boot.  Could increase its size by log_buf_len= kernel command line argument; must be a power of two.
