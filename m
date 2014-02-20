Message-ID: <53064E9A.2040008@tycho.nsa.gov>
Date: Thu, 20 Feb 2014 13:51:06 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
Subject: Re: [PATCH] selinux: Only attempt to load policy exactly once, in
 the real root
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>	<5306441F.8050207@tycho.nsa.gov>
 <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
In-Reply-To: <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
Content-Type: text/plain; charset=UTF-8
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>,
 SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/20/2014 01:17 PM, Colin Walters wrote:
> On Thu, Feb 20, 2014 at 1:06 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> Wouldn't it be better (and more correct) to probe both the initramfs and
>> the real root, and if neither one can load policy successfully and
>> enforcing=1, then halt?
>>
> So you're saying we should handle -ENOENT specially in the initramfs? 
> Something like being sure we preserve errno and returning it to the
> caller of selinux_init_load_policy()?  That would introduce a subtle
> version dependency.
> 
> Or alternatively, just try in the initramfs, ignore any errors, and only
> abort if we also fail to load in the real root?
> 
> I think both of these (particularly the second) are worse than my patch
> - we don't (to my knowledge) support putting policy in the initramfs now
> with Fedora or Red Hat Enterprise Linux, so attempting to find it there
> by default on every bootup is wrong. 
> To turn it around, what is the possible value in also probing the
> initramfs?  Does anyone out there load policy from it with systemd?

Ok, I guess when you put it that way...

The only cases I know of where policy is loaded from initramfs are
embedded Linux and Android, neither of which are using systemd to my
knowledge, and both of which have custom policy loading logic anyway.
