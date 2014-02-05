Message-ID: <52F28549.1030305@tycho.nsa.gov>
Date: Wed, 05 Feb 2014 13:39:05 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: leo kirotawa <kirotawa@gmail.com>,
 Fedora SELinux Users <selinux@lists.fedoraproject.org>,
 SELinux <selinux@tycho.nsa.gov>
Subject: Re: audit2allow: invalid binary policy
References: <CA+KS1kaJu1RarB3X60NZFsoJduYrP4ZD+UnzppeHH9-x+jPYiw@mail.gmail.com>
In-Reply-To: <CA+KS1kaJu1RarB3X60NZFsoJduYrP4ZD+UnzppeHH9-x+jPYiw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/05/2014 01:07 PM, leo kirotawa wrote:
> Hi,
> 
> I'm having issues when use audit2allow in a Z machine with Fedora 19.
> This is the output message it raises:
> 
> audit2allow -a
> security: ebitmap: map size 1064 does not match my size 64 (high bit was
> 595)
> invalid binary policy

That's a kernel bug.  Should be fixed by commit b13800.
I think you can workaround by pointing audit2allow at the policy file
rather than having it read from the kernel,
audit2allow -p /etc/selinux/targeted/policy/policy.29 -a

> As a solution I thought in recompile my whole policy and generate a new
> /policy/binary, but this time I grabbed a ERROR: (serefpolicy-3.12.1)
> 
> /usr/bin/checkmodule base.conf -o tmp/base.mod
> /usr/bin/checkmodule:  loading policy configuration from base.conf
> policy/modules/kernel/domain.te":256:ERROR 'unknown type tape_device_t used
> in transition definition' at token ';' on line 22729:
> #line 256
>     type_transition unconfined_domain_type device_t:chr_file tape_device_t
> "ht00";
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> make: *** [tmp/base.mod] Error 1
> 
> Looking in my /dev/ I did not find any 'ht00' device, what makes me suppose
> maybe it is the problem. Also looking in .te files I saw tape_device_t is
> defined into storage.te, and in this point I have no idea what is cause of
> this problem or how to fix it.
> 
> Have you ever seen it before?

That's unrelated and has nothing to do with what devices you have on the
system.  Just some problem in the policy sources you are building or
perhaps the set of policy modules you have enabled.
