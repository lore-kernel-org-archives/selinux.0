Subject: Re: root login with enforcing on
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "James R. Kratzer" <JamesK@xetron.com>
Cc: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>,
   Russell Coker <russell@coker.com.au>, Howard Holm <hdholm@epoch.ncsc.mil>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A55@s3cin>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A55@s3cin>
Content-Type: text/plain
Message-Id: <1067027557.6209.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 24 Oct 2003 16:32:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-24 at 15:55, Kratzer, James R. wrote:
> When I login as root with enforce set to 1, root does not have permission to
> access the "/root/.bash_profile" file.  What rule should I add to allow root
> access to that file?  Thanks.
> 
> login: root
> Password:
> Last Login: Fri Oct 24 on tty1
> You have new mail.
> -bash: /root/.bash_profile: Permisson denied
> -bash-2.05b#

You can determine this yourself by looking at the dmesg output or
/var/log/messages file to see exactly what was denied.  The
policy/newrules.pl script (=>policycoreutils/audit2allow in the next
release, see the prior discussion on the list) can be used to
automatically generate allow rules from those audit messages, although
such rules shouldn't be blindly added, as noted in the README and the
Configuring the SELinux Policy report.

In your case, you are likely looking for something like:
file_type_auto_trans(staff_t, sysadm_home_dir_t, sysadm_home_t)
to allow staff_t to fully access /root and make sure that any newly
created files in /root are placed into sysadm_home_t.

But in this case, rather than adding rules, I suspect that the right
solution is changing the types on /root.  With the introduction of the
staff_r role as the default role for administrators (and the only one
in which they can directly login via ssh), you likely want to just
change the /root entries in your policy/file_contexts/types.fc file
to use staff_home_t and staff_home_dir_t instead of sysadm_home*t
and relabel (or relabel the directory and files via chcon).  This
requires some other changes to make sure that staff_home*t is properly
protected against tampering, but this should be done anyway, e.g. the
conditional in user_macros.te for privhome should also be applied to
staff, and it isn't clear to me why so many program domains need
write access to staff_home_dir_t.  But once this has been done,
staff_home*t should be useable for /root, and sysadm_home*t serves no
purpose at all.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
