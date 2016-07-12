Subject: Re: Inconsistent RSS on Red Hat 7 but not 6.
To: Todd Rinaldo <toddr@cpanel.net>, selinux@tycho.nsa.gov
References: <D13ED7AE-0CB2-4D6B-8BB2-6C78F16FB46B@cpanel.net>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <035700d1-4630-cd1a-5e8b-d4b9d1a3f5be@tycho.nsa.gov>
Date: Tue, 12 Jul 2016 15:44:36 -0400
MIME-Version: 1.0
In-Reply-To: <D13ED7AE-0CB2-4D6B-8BB2-6C78F16FB46B@cpanel.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On 07/12/2016 11:58 AM, Todd Rinaldo wrote:
> We keep metrics on our binaries with respect to how much memory
> they take up at startup time. So for instance if you run ./a.pl
> --basemem, it grabs the VmRSS value out of /proc/$$/status and
> exits.
> 
> When we added Red Hat 7 support to our product, we noticed that
> this value was VERY unstable. After much poking, I accidentally
> discovered that this was a side effect of having selinux enabled
> when doing the check.
> 
> When I disable selinux in /etc/selinux/config and reboot, I found
> that ./a.pl --basemem became much more stable.
> 
> I am guessing something changed between Red Hat 6 and 7 which
> caused libselinux to map differently into the address space. I'm
> however not ruling out a libc change. Can anyone shed light on this
> or point me to something that would indicate why? For reference,
> this is libselinux 2.2.2 vs 2.0.94.

Can you provide more details, e.g a reproducer without needing your
particular binaries or a.pl?
