Message-ID: <1497450625.9239.6.camel@tycho.nsa.gov>
Subject: Re: Collecting ideas for audit2allow improvement
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jan Zarsky <jzarsky@redhat.com>, selinux@tycho.nsa.gov
Date: Wed, 14 Jun 2017 10:30:25 -0400
In-Reply-To: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
References: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-06-14 at 09:01 -0400, Jan Zarsky wrote:
> Hi,
> 
> I would like to improve SELinux audit2allow tool as my bachelor
> thesis.
> I collected ideas from my colleagues from RedHat SELinux team and I
> would also
> like to hear your ideas - what would you improve to make audit2allow
> smarter or
> easier to use.
> 
> Ideas collected so far:
> 
>   * offer dac_read_search when sufficient instead of dac_override
>     (see <https://github.com/SELinuxProject/selinux/issues/31>)

The hard part here is knowing when it is sufficient.  Might require
further kernel patches to get to the point where it is completely
unambiguous from the audit messages alone.  You could perhaps default
to only allowing dac_read_search and only allow dac_override if you see
that dac_read_search is already allowed and you are still getting a
dac_override denial.

>   * offer multiple solutions to a problem (example: 1) add allow rule
> for
>     execute + execute_no_trans or 2) add allow rule for execute
>     + type_transition rule)

Is this type_transition to an existing type that already exists, or
defining a new type and transitioning to it, or both?  Generating new
domains and types dynamically is one of the major gaps in current
audit2allow, and to date has only been supported in separate tools like
sepolicy generate.

>   * interactive mode: ask questions and choose best solution
>   * warn when solution touches trusted computing base (rules you
> should not be
>     adding)
>   * suggest alternate labels for content, example: httpd_t not
> allowed to write
>     to user_home_t, might suggest that changing the label to
>     httpd_user_content_t

This seems more along the lines of what setroubleshoot does, and tends
to be policy-specific. We need to preserve the usability of audit2allow
for other policies (e.g. Android, DSSP), so any policy-specific logic
needs to be encapsulated, configuration-driven, and optional.

>   * output to CIL (add option for this)

This would definitely be useful, as generating .te files just adds
overhead at this point and makes audit2allow depend on having
checkmodule and semodule_package installed.  In fact, I think we should
move to generating CIL by default and just provide an option for
generating .te files for backward compat.

>   * if the AVC talks about execute permission then offer also
> type_transition
>     rule
>   * idea for a tool for automatic policy generation: On a test system
> you
>     install application, turn the SELinux to permissive and run a
> full test
>     suit. You collect all the AVCs in say Elasticsearch (can use
> common logging
>     ViaQ project for that) and then there is a tool that searches the
> AVC,
>     groups them and creates a policy out of them.

This seems similar to sepolicy generate.  We don't want to bring in
many extra dependencies to audit2allow, but being able to dynamically
generate new domains and types would IMHO be useful.

>   * add option to open bugzilla

Need to be careful here since not all SELinux users are Red Hat users.

>   * output to Ansible playbook/role task (add option for this)

Another improvement:

* Add ability to generate ioctl whitelisting rules, see for example:
http://jeffvanderstoep.blogspot.com/2016/02/collecting-ioctl-command-denials-for.html
but note that the syntax has changed to e.g.
allowxperm <sourcedomain> <targetdomain>:<class> ioctl { <list of ioctl
command values> };

> I would also like to know which feature would you appreciate the
> most.

You should likely study the tooling and workflow used by other security
projects, e.g. AppArmor, TOMOYO, grsecurity, for policy learning and
generation.
