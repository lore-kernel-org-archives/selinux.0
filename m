Subject: Re: what is the purpose of security initial sid?
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <61dffb53-5ce0-bde4-9c3e-d40f8eda5efb@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20968774-8d14-0843-c3ce-f7658864404b@tycho.nsa.gov>
Date: Wed, 16 Nov 2016 13:10:52 -0500
MIME-Version: 1.0
In-Reply-To: <61dffb53-5ce0-bde4-9c3e-d40f8eda5efb@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/16/2016 12:59 PM, Dominick Grift wrote:
> 
> I forgot that add the genfscon's for selinuxfs and securityfs and
> the selinux filesystem ended up associated with the context
> associated with the unlabeled initial sid.
> 
> Why did the security initial sid not kick in instead of unlabeled?
> 
> If the security isid is not there to ensure selinuxfs is labeled 
> appropriately then what is it there for?

$ grep -r SECINITSID_SECURITY security/selinux
security/selinux/selinuxfs.c:	return avc_has_perm(sid,
SECINITSID_SECURITY,

It is used as the target/object SID for the permission checks on the
"security" class performed upon operations on selinuxfs (and
pre-selinuxfs, it was likewise used for the corresponding permission
checks on the added SELinux system calls).

Could probably make it used as the default for selinuxfs nodes as
well, but not presently done.
