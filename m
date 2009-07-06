Subject: Re: [PATCH 1/4] Namespacing of security/selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
In-Reply-To: <1246885996.28321.2.camel@moss-pluto.epoch.ncsc.mil>
References: <1246568103.2480.27.camel@Ares>
	 <1246885996.28321.2.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 09:27:05 -0400
Message-Id: <1246886826.28321.5.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-06 at 09:13 -0400, Stephen Smalley wrote:
> On Thu, 2009-07-02 at 16:55 -0400, Thomas Liu wrote:
> > This patch namespaces the functions in security/selinux, prefixing 
> > with selinux_ and prefixing items in security/selinux/ss with
> > selinux_ss.
> 
> Hmm...my original suggestion here (from:
> http://selinuxproject.org/page/Kernel_Development) was as follows:
> 
> We have a lot of global functions and variables, some with no prefix at
> all, some with prefixes that are not clearly scoped to selinux.
> 
> I'd at least:
> - rename the security server functions from security_ to selinux_ to
> avoid confusion/conflicts with LSM.
> - rename ss_initialized to selinux_ss_initialized.
> - rename the policydb and sidtab variables to selinux_policydb and
> selinux_sidtab (and/or wrap them in a single container structure with a
> single active policy pointer to it, with the intent of ultimately
> refcounting it and introducing _get and _put functions).
> 
> Then you've got the generic data structures and their functions, like
> hashtab_, symtab_, etc, which could either be taken to lib/ or given
> selinux_ prefixes.
> 
> But I wouldn't blindly rename everything under ss/ with selinux_ss - if
> possible I'd just use selinux_ everywhere unless there is an actual
> conflict.  And I wouldn't rename the avc_ functions unless there is
> truly a conflict - they already have a perfectly good prefix (avc_) and
> one that has to date been unique.
> 
> checkpatch.pl complains that a lot of lines end up over 80 chars from
> the patches, which would be reduced if you omitted the _ss_ part and
> didn't rename the avc_ functions.

Also, after all 4 patches, it doesn't build:
security/built-in.o: In function `selinux_set_bools':
/home/sds/security-testing-2.6/security/selinux/ss/services.c:2300: undefined reference to `selinux_ss_evaluate_cond_node'
security/built-in.o: In function `security_preserve_bools':
/home/sds/security-testing-2.6/security/selinux/ss/services.c:2352: undefined reference to `selinux_ss_evaluate_cond_node'

It appears that patch 2/4 did rename the function correctly, but patch 3/4 renames it again with a double underscore.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
