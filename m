MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: Re: Developing a SELinux policy for antivirus - How to access /home?
From: Jeff Johnson <n3npq@mac.com>
In-reply-to: <4C1B9CDC.2000802@bian-fu.net>
Date: Fri, 18 Jun 2010 12:52:24 -0400
Cc: SELinux@tycho.nsa.gov
Message-id: <D87D2AC9-6331-44DC-B5CB-7AAE0A90EDCE@mac.com>
References: <4C1B9CDC.2000802@bian-fu.net>
To: Alice Mynona <alice_mynona@bian-fu.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jun 18, 2010, at 12:20 PM, Alice Mynona wrote:

> Hello,
> 
> I'm planning to develop a SELinux module for an antivirus software. This software should protect the system from beeing infected by 
> malicious files in /home. Of course, the software will be executed in a separate domain i. e. antivirus_t.
> 
> What do you recommend to allow the antivirus software to access (and manage) files und directories under /home?
> 
> My first thought was to allow the antivirus software to manage files of the type "user_home_dir_t" and directories of the type "user_home_dir_t" by using the corresponding interfaces in the reference policy (i. e. "userdom_manage_user_home_dirs"). But what's about other filetypes like "gnome_home_t", "irc_home_t", "screen_tmp_t" and so on? Is there a general method to manage files under "/home" or do you have an another idea? Am I missing something?

Well for starters, most anti-virus software depends on detecting
fingerprints in content. That's semantically different (and dynamic)
than apply security tags everywhere.

You might look at how SE Linux is tied to ELF TEXTREL's (text relocations
are potentially eplotable).

That's the closest that SE Linux comes to file content based tagging (off the top of my head)
which might be usefully tied to virus detection mechanisms typically implemented.

hth

73 de Jeff

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
