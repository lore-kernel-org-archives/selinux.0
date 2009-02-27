Subject: Re: refpolicy compilation issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Kirill \"REDbyte\" Novikov" <redbyte.labs@gmail.com>
Cc: SELinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <e768086c0902270357w2b34b11rebd3e8a98c58877a@mail.gmail.com>
References: <e768086c0902270357w2b34b11rebd3e8a98c58877a@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 27 Feb 2009 09:14:41 -0500
Message-Id: <1235744081.26843.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-02-27 at 16:57 +0500, Kirill "REDbyte" Novikov wrote:
> Hi there everyone!
> 
> I'm got a strange problem compiling latest refpolicy (as well as all
> other versions), found nothing alike on the mailing lists, so maybe
> someone from here would help me.
> 
> Policy compilation fails like this:
> 
> Creating refpolicy policy.conf
> cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
> tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf >
> policy.conf
> Compiling refpolicy policy.23
> 
> WARNING: Policy version mismatch!  Is your OUTPUT_POLICY set
> correctly?
> 
> /usr/bin/checkpolicy policy.conf -o policy.23
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> policy/modules/services/amavis.te":11:ERROR 'syntax error' at token
> ':' on line 7140:
>         allow amavis_t init_t:process sigchld;
> #line 11
> checkpolicy:  error(s) encountered while parsing configuration
> make: *** [policy.23] Error 1
> 
> I'm using latest development versions of SELinux stuff, available from
> Tresys' trac. I have checked /selinux/policyvers and it contains 24 -
> but latest policy version supported by checkpolicy 2.0.16 is 23. Have
> any ideas?

The policy version mismatch warning is just a warning, not a fatal
error.  The later compilation error in amavis.te looks unrelated and is
presumably due to something wrong in the lines preceding that statement
in policy.conf.

Are you trying to build the last release of refpolicy
(refpolicy-2.20081210) or the svn trunk?  What are your build.conf
settings or command-line overrides to make?

To generate policy.24, you'd need to build checkpolicy from the git
development repository rather than using the last released version.
But that shouldn't be necessary to build refpolicy, and although your
kernel supports policy.24, it will accept policy.23 as well.  So I
wouldn't bother changing your version of checkpolicy - I don't think it
is related to the error.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
