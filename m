Subject: Re: mv and cp behavior.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>,
   RH SELinux list <rhselinux-list@redhat.com>
In-Reply-To: <41712EEF.9090402@redhat.com>
References: <41712EEF.9090402@redhat.com>
Content-Type: text/plain
Message-Id: <1098105487.27895.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 18 Oct 2004 09:18:07 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-10-16 at 10:23, Daniel J Walsh wrote:
> Seems we have unexpected results when doing the mv command in both 
> Strict and targeted policy.
> 
> A couple of examples where users are going to be confused (I was yesterday).
> 
> 1. Setting up dhcp
> 
>      I was setting up a test dhcp server yesterday in targeted policy so
>     I installed the machine,
>     copied the dhcpd.conf file from an existing server to the /tmp
>     directory.  Then I moved the file
>     to the /etc/ directory.

This is the same issue that came up on fedora-devel-list earlier.  mv
always preserves security context if possible (always for
intra-filesystem rename, and if the target filesystem supports it for
cross-filesystem rename).

> 2. Modifying files on a web server
> 
>     Collin has setup a web server and setup a directory underneath in
>     /var/www/myblog it owned by httpd_staff_content_t which he
>     can write files into and update his blog.  He edits files in his
>     home directory can them moves them to the httpd directory.
>     The problem is the apache server can't display them, because they
>     have a context of staff_home_t.  (This would happen in both
>     strict and targeted).    In this case he needs to use chcon to
>     relabel the file to httpd_staff_content_t since restorecon would change
>     the context to something else.

Only if he failed to update his file_contexts configuration to reflect
his setup for /var/www/myblog. 

> 3.  Mv/cp do not follow the DAC conventions in all cases.  If I have a 
> file marked as bin_t and executable and I move it to /tmp.
> It is still executable in DAC but the bin_t context gets removed and 
> replaced with some type of *_tmp_t context.

cp should only preserve security context when the --context/-c option is
used or when all attributes are supposed to be preserved, IIRC.  mv
should always preserve security context if possible (i.e. local
rename(2) or target filesystem supports the context).  If mv cannot
preserve security context, it should display a warning.  I think that
this behavior is consistent with DAC ownership/mode preservation.

> 1.  Implement a matchpathcon in mv so the context is setup correctly on 
> newly created files.

I had previously suggested changing mv to call matchpathcon on the new
path, compare with the existing context on the file, and _ask_ the user
if they want to relabel if they differ.  You don't want to do this
silently, as it subverts the protection.  Requires a user confirmation. 
Look at the existing mv code for dealing with overwriting an unwritable
file, where it also prompts the user for confirmation.

> 4.  In certain situations file context is manipulated by policy.  IE if 
> I move a file to /tmp, policy forces the file to be staff_tmp_t.

I don't follow; an explicit setfscreatecon() always overrides default
transitions.  But it may not be permitted by policy, in which case
you'll get a denial.

I don't recommend any change in behavior _other_ than having mv offer
the user the choice of relabeling.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
