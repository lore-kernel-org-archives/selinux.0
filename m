Message-ID: <491BB6EE.9010909@redhat.com>
Date: Thu, 13 Nov 2008 15:11:10 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Dominick Grift <domg472@gmail.com>
Subject: Re: user guide drafts: "Linux Permissions" and "Manual Pages for
 Services"
References: <491A3631.8080806@redhat.com> <1226503901.21407.19.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1226503901.21407.19.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2008-11-12 at 11:49 +1000, Murray McAllister wrote:
>> Hi,
>>
>> The following are drafts for the "Fixing Problems"[1] section. Any 
>> comments and corrections are appreciated.
>>
>> Linux Permissions
>>
>> When access is denied, check standard Linux permissions. As mentioned in 
>> Chapter 2, Introduction, most operating systems use a Discretionary 
>> Access Control (DAC) system to control access, allowing users to control 
>> the permissions of files that they own. SELinux policy rules are checked 
>> after DAC rules. SELinux policy rules are not used if DAC rules deny 
>> access first.
>>
>> If access is denied and no SELinux denials are logged,
> 
> Logically you would also mention the dontaudit case here, and how to
> check for denials hidden by dontaudit rules.
> 
How about (keeping in mind I have not really heard of this before):

dontaudit Rules and Linux Permissions

Bugs in applications may cause a lot of SELinux denials, but such 
denials may not prevent the application from running correctly. For 
these situations, dontaudit rules can be added to policy to prevent log 
files being filled with denial messages. The downside of this is that, 
although SELinux denies access, denial messages are not logged, making 
troubleshooting hard.

To temporarily disable dontaudit rules, allowing all denials to be 
logged, run the following command as the Linux root user:

/usr/sbin/semodule -DB

The -D option disables dontaudit rules; the -B option rebuilds policy. 
The dontaudit rules are disabled until policy is rebuilt. To rebuild 
policy and enable dontaudit rules, run the following command as the 
Linux root user:

/usr/sbin/semodule -B
For a full list of dontaudit rules, run the sesearch --dontaudit 
command. Narrow down searches using the -s domain option and the grep 
command. For example:

[output from "sesearch --dontaudit -s smbd_t | grep squid
"]

Refer to Section 7.3.5, “Raw Audit Messages” and Section 7.3.6, “sealert 
Messages” for information about analyzing denials.

After resolving any issues found by removing dontaudit rules, or if 
disabling these rules did not produce denials for your situation, check 
standard Linux permissions. [rest of Linux Permissions content].

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
