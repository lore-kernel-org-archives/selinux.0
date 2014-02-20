Date: Thu, 20 Feb 2014 18:17:14 +0000
From: Colin Walters <walters@verbum.org>
Subject: Re: [PATCH] selinux: Only attempt to load policy exactly once, in
 the real root
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <5306441F.8050207@tycho.nsa.gov>
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
 <5306441F.8050207@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-C+JYZ+3vaKy2ig4UK+N5"
Message-Id: <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>,
 SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-C+JYZ+3vaKy2ig4UK+N5
Content-Type: text/plain; charset=utf-8; format=flowed

On Thu, Feb 20, 2014 at 1:06 PM, Stephen Smalley <sds@tycho.nsa.gov> 
wrote:
> 
> Wouldn't it be better (and more correct) to probe both the initramfs 
> and
> the real root, and if neither one can load policy successfully and
> enforcing=1, then halt?
> 
So you're saying we should handle -ENOENT specially in the initramfs?  
Something like being sure we preserve errno and returning it to the 
caller of selinux_init_load_policy()?  That would introduce a subtle 
version dependency.

Or alternatively, just try in the initramfs, ignore any errors, and 
only abort if we also fail to load in the real root?

I think both of these (particularly the second) are worse than my patch 
- we don't (to my knowledge) support putting policy in the initramfs 
now with Fedora or Red Hat Enterprise Linux, so attempting to find it 
there by default on every bootup is wrong.  

To turn it around, what is the possible value in also probing the 
initramfs?  Does anyone out there load policy from it with systemd?

  

--=-C+JYZ+3vaKy2ig4UK+N5
Content-Type: text/html; charset=utf-8

On Thu, Feb 20, 2014 at 1:06 PM, Stephen Smalley &lt;sds@tycho.nsa.gov&gt; wrote:<br>
<blockquote type="cite"><div class="plaintext" style="white-space: pre-wrap;">
Wouldn't it be better (and more correct) to probe both the initramfs and
the real root, and if neither one can load policy successfully and
enforcing=1, then halt?</div></blockquote><br><div>So you're saying we should handle -ENOENT specially in the initramfs? &nbsp;Something like being sure we preserve errno and returning it to the caller of selinux_init_load_policy()? &nbsp;That would introduce a subtle version dependency.</div><div><br></div><div>Or alternatively, just try in the initramfs, ignore any errors, and only abort if we also fail to load in the real root?</div><div><br></div><div>I think both of these (particularly the second) are worse than my patch - we don't (to my knowledge) support putting policy in the initramfs now with Fedora or Red Hat Enterprise Linux, so attempting to find it there by default on every bootup is wrong. &nbsp;</div><div><br></div><div>To turn it around, what is the possible value in also probing the initramfs? &nbsp;Does anyone out there load policy from it with systemd?</div><div><br></div><div>&nbsp;&nbsp;</div>
--=-C+JYZ+3vaKy2ig4UK+N5--
