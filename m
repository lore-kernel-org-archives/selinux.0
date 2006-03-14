Subject: Re: w3c.te module policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ville =?ISO-8859-1?Q?Skytt=E4?= <ville.skytta@iki.fi>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4412C1CD.6080808@redhat.com>
References: <1140879631.15616.46.camel@bobcat.mine.nu>
	 <4411F026.4070508@redhat.com> <1142072726.19009.30.camel@bobcat.mine.nu>
	 <4412C1CD.6080808@redhat.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 10:39:02 -0500
Message-Id: <1142350742.4683.6.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-03-11 at 07:25 -0500, Daniel J Walsh wrote:
> Ville has been trying to build a modular policy package for w3c.  He 
> created te,fc,if files similar to the ones I have attached.  The problem 
> is that when he compiles them he ends up with avc messages suggesting he 
> needs these additional rules:
> 
> allow httpd_t httpd_w3c_script_exec_t:file { execute execute_no_trans 
> getattr ioctl read };
> 
> I have duplicated this on my machine.
> 
>  From my reading of the generated policy these should already exist.  
> Examining the tmp/w3c.tmp file it looks like they are there (except for 
> the execute_no_trans).  They are wrapped in a boolean though.  Is there 
> something wrong in policy modules handling of booleans?

The transition from httpd_t to httpd_*_script_t is inside
httpd_enable_cgi; if that is not enabled, then it makes sense that the
perms listed above would be denied.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
