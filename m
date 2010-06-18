Message-ID: <4C1B9CDC.2000802@bian-fu.net>
Date: Fri, 18 Jun 2010 18:20:44 +0200
From: Alice Mynona <alice_mynona@bian-fu.net>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Developing a SELinux policy for antivirus - How to access /home?
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I'm planning to develop a SELinux module for an antivirus software. This software should protect the system from beeing infected by 
malicious files in /home. Of course, the software will be executed in a separate domain i. e. antivirus_t.

What do you recommend to allow the antivirus software to access (and manage) files und directories under /home?

My first thought was to allow the antivirus software to manage files of the type "user_home_dir_t" and directories of the type "user_home_dir_t" by using the corresponding interfaces in the reference policy (i. e. "userdom_manage_user_home_dirs"). But what's about other filetypes like "gnome_home_t", "irc_home_t", "screen_tmp_t" and so on? Is there a general method to manage files under "/home" or do you have an another idea? Am I missing something?

Thanks in advance.

Best regards,
Alice

-- 
+ Alice Mynona
+ Email: Alice_Mynona@bian-fu.net



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
