Message-ID: <4C1BA490.5030807@redhat.com>
Date: Fri, 18 Jun 2010 12:53:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Alice Mynona <alice_mynona@bian-fu.net>
CC: SELinux@tycho.nsa.gov
Subject: Re: Developing a SELinux policy for antivirus - How to access /home?
References: <4C1B9CDC.2000802@bian-fu.net>
In-Reply-To: <4C1B9CDC.2000802@bian-fu.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/18/2010 12:20 PM, Alice Mynona wrote:
> Hello,
>
> I'm planning to develop a SELinux module for an antivirus software. This software should protect the system from beeing infected by
> malicious files in /home. Of course, the software will be executed in a separate domain i. e. antivirus_t.
>
> What do you recommend to allow the antivirus software to access (and manage) files und directories under /home?
>
> My first thought was to allow the antivirus software to manage files of the type "user_home_dir_t" and directories of the type "user_home_dir_t" by using the corresponding interfaces in the reference policy (i. e. "userdom_manage_user_home_dirs"). But what's about other filetypes like "gnome_home_t", "irc_home_t", "screen_tmp_t" and so on? Is there a general method to manage files under "/home" or do you have an another idea? Am I missing something?
>
> Thanks in advance.
>
> Best regards,
> Alice
>
All files types stored in the home dir have an attribute of user_home_type.

What is your goal of this antivirus tools?  Scan all files in the 
homedir for bad content?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
