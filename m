Message-ID: <4C1BB77D.7040100@bian-fu.net>
Date: Fri, 18 Jun 2010 20:14:21 +0200
From: Alice Mynona <alice_mynona@bian-fu.net>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: Developing a SELinux policy for antivirus - How to access /home?
References: <4C1B9CDC.2000802@bian-fu.net> <4C1BA490.5030807@redhat.com>
In-Reply-To: <4C1BA490.5030807@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh schrieb am 18.06.2010 18:53 Uhr:
> On 06/18/2010 12:20 PM, Alice Mynona wrote:
>> Hello,
>>
>> I'm planning to develop a SELinux module for an antivirus software.
>> This software should protect the system from beeing infected by
>> malicious files in /home. Of course, the software will be executed in
>> a separate domain i. e. antivirus_t.
>>
>> What do you recommend to allow the antivirus software to access (and
>> manage) files und directories under /home?
>>
>> My first thought was to allow the antivirus software to manage files
>> of the type "user_home_dir_t" and directories of the type
>> "user_home_dir_t" by using the corresponding interfaces in the
>> reference policy (i. e. "userdom_manage_user_home_dirs"). But what's
>> about other filetypes like "gnome_home_t", "irc_home_t",
>> "screen_tmp_t" and so on? Is there a general method to manage files
>> under "/home" or do you have an another idea? Am I missing something?
>>
>> Thanks in advance.
>>
>> Best regards,
>> Alice
>>
> All files types stored in the home dir have an attribute of user_home_type.
> 

Okay, on my system there are other file types unter "/home" i. e.:

$ ls -Z /home/alice/.ssh/

-rw-r--r--. alice alice unconfined_u:object_r:home_ssh_t:SystemLow authorized_keys2
-rw-r--r--. alice alice unconfined_u:object_r:home_ssh_t:SystemLow known_hosts

What do mean by "have an attribute of user_home_type"? How can I use this attribute instead of a file type when writing rules?

> What is your goal of this antivirus tools?  Scan all files in the
> homedir for bad content?

The antivir software offers two functions:

a) On demand scanning 

b) On access scanning (real time)

On demand scanning may be done periodically under the root account or via crond. At the moment I doesn't care about this ;-). The on access scanning, which uses a DazukoFS implementation (http://dazuko.dnsalias.org/wiki/index.php/Main_Page), should work in the first version of the selinux module. This function scans a file when a program tries to open it.

Many thanks for your help.

Best regards 

Alice

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
