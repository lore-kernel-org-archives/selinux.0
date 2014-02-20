Date: Thu, 20 Feb 2014 20:52:08 +0000
From: Colin Walters <walters@verbum.org>
Subject: Re: [systemd-devel] [PATCH] selinux: Only attempt to load policy
 exactly once, in the real root
To: systemd Mailing List <systemd-devel@lists.freedesktop.org>, SELinux-NSA
 <SELinux@tycho.nsa.gov>
In-Reply-To: <53065B50.1030004@redhat.com>
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
 <5306441F.8050207@tycho.nsa.gov>
 <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
 <20140220183643.GB24876@tango.0pointer.de>
 <CACLa4ps3J9i8sSqxgrn6X=X08__rv4DWUPwYpeTPC-VcYBpjAQ@mail.gmail.com>
 <20140220192644.GA28064@tango.0pointer.de>
 <CACLa4puwTAN5Qjkp1AW__v9w2vyupG-BxmtfBsZ8cyXNWD-Ppg@mail.gmail.com>
 <53065B50.1030004@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-02kMe4CUPNJZY2n7APVc"
Message-Id: <20140220205709.BFC67C00005@frontend1.nyi.mail.srv.osa>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-02kMe4CUPNJZY2n7APVc
Content-Type: text/plain; charset=utf-8; format=flowed

On Thu, Feb 20, 2014 at 2:45 PM, Daniel J Walsh <dwalsh@redhat.com> 
wrote:
>> 
>> 
> You mean
> 
> "!in_initrd() || access(selinux_path(), F_OK) >= 0"?
> 

I don't think so - that would mean we would silently continue if 
enforcing=1, but we happen to not find a policy on disk.  Right?

I think my patch is better than this - systemd will attempt to load 
policy from *only* the real root (not the initramfs), using the exact 
same logic as is in libselinux currently.

For example, it would allow explicitly specifying enforcing=1 on the 
kernel command line, and that would continue to cause an explicit 
failure if policy is not found.




--=-02kMe4CUPNJZY2n7APVc
Content-Type: text/html; charset=utf-8

On Thu, Feb 20, 2014 at 2:45 PM, Daniel J Walsh &lt;dwalsh@redhat.com&gt; wrote:<br>
<blockquote type="cite"><div class="plaintext" style="white-space: pre-wrap;"><blockquote>
</blockquote>You mean

"!in_initrd() || access(selinux_path(), F_OK) &gt;= 0"?</div></blockquote><div><br></div><div>I don't think so - that would mean we would silently continue if enforcing=1, but we happen to not find a policy on disk. &nbsp;Right?</div><div><br></div><div>I think my patch is better than this - systemd will attempt to load policy from *only* the real root (not the initramfs), using the exact same logic as is in libselinux currently.</div><div><br></div><div>For example, it would allow explicitly specifying enforcing=1 on the kernel command line, and that would continue to cause an explicit failure if policy is not found.</div><div><br></div><div><br></div>
--=-02kMe4CUPNJZY2n7APVc--
