Subject: Re: Developing a SELinux policy for antivirus - How to access
 /home?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alice Mynona <alice_mynona@bian-fu.net>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <4C1BB77D.7040100@bian-fu.net>
References: <4C1B9CDC.2000802@bian-fu.net> <4C1BA490.5030807@redhat.com>
	 <4C1BB77D.7040100@bian-fu.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Jun 2010 14:55:18 -0400
Message-ID: <1276887318.22449.132.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-06-18 at 20:14 +0200, Alice Mynona wrote:
> Daniel J Walsh schrieb am 18.06.2010 18:53 Uhr:
> > On 06/18/2010 12:20 PM, Alice Mynona wrote:
> >> Hello,
> >>
> >> I'm planning to develop a SELinux module for an antivirus software.
> >> This software should protect the system from beeing infected by
> >> malicious files in /home. Of course, the software will be executed in
> >> a separate domain i. e. antivirus_t.
> >>
> >> What do you recommend to allow the antivirus software to access (and
> >> manage) files und directories under /home?
> >>
> >> My first thought was to allow the antivirus software to manage files
> >> of the type "user_home_dir_t" and directories of the type
> >> "user_home_dir_t" by using the corresponding interfaces in the
> >> reference policy (i. e. "userdom_manage_user_home_dirs"). But what's
> >> about other filetypes like "gnome_home_t", "irc_home_t",
> >> "screen_tmp_t" and so on? Is there a general method to manage files
> >> under "/home" or do you have an another idea? Am I missing something?
> >>
> >> Thanks in advance.
> >>
> >> Best regards,
> >> Alice
> >>
> > All files types stored in the home dir have an attribute of user_home_type.
> > 
> 
> Okay, on my system there are other file types unter "/home" i. e.:
> 
> $ ls -Z /home/alice/.ssh/
> 
> -rw-r--r--. alice alice unconfined_u:object_r:home_ssh_t:SystemLow authorized_keys2
> -rw-r--r--. alice alice unconfined_u:object_r:home_ssh_t:SystemLow known_hosts
> 
> What do mean by "have an attribute of user_home_type"? How can I use this attribute instead of a file type when writing rules?

Each type can have a set of attributes associated with it in the policy
(via typeattribute statements or as part of the type declaration).
You can then use the attribute names in allow rules to express the set
of types that have that attribute.

seinfo -auser_home_type -x

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
