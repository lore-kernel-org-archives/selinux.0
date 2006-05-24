Date: Wed, 24 May 2006 10:06:42 -0700
Subject: Re: Fedora Core 5 Tomcat 4 problems
From: "Michael K. Smith" <mksmith@adhost.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <SELinux@tycho.nsa.gov>
Message-ID: <C099E0B2.24D7E%mksmith@adhost.com>
In-Reply-To: <1148490176.24463.454.camel@moss-spartans.epoch.ncsc.mil>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen:


On 5/24/06 10:02 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On Wed, 2006-05-24 at 09:20 -0700, Michael K. Smith wrote:
>> Hello All:
>> 
>> I am attempting to start Tomcat 4 using an rc script that uses the
>> unprivileged user "tomcat" to run the application.  The relevant line is:
>> 
>> su -l tomcat -p -s /bin/bash -c /usr/local/tomcat/bin/startup.sh
>> 
>> In addition, the tomcat user has /sbin/nologin in the password file.
>> 
>> Steps to make it work:
>> 
>> 1) Set SELinux to permissive and reboot
>> 2) Take resultant AVC messages and create local policy
>> 3) Load policy, set SELinux to enforcing and reboot
> 
> Rebooting shouldn't be strictly necessary in the above sequence.
> 

Sadly, it's necessary to confirm whether or not the rc script will fire at
boot.  If I run the script after the system has booted everything works just
fine.

<snip>
>> 
>> Below is a copy of the local.te file that was generated from the AVC
>> messages in /var/log/messages after setting to permissive.  The Tomcat
>> directory is /usr/local/tomcat and shows as:
>> 
>> drwxr-xr-x  tomcat   tomcat   user_u:object_r:usr_t
>> jakarta-tomcat-4.1.31
>> 
>> lrwxrwxrwx  root     root     user_u:object_r:usr_t            tomcat ->
>> /usr/local/jakarta-tomcat-4.1.31
> 
> This should really be in a different type than just usr_t.
> 
I set it to system_u:object_r:user_home_t to match the HTTP directory but
that didn't change the initial behavior.

<snip>
> 
> Can we see the full avc message for the execmod denial?

Absolutely.

May 27 08:03:57 bmedia kernel: audit(1117206233.280:4): avc:  denied  { read
} for  pid=1813 comm="su" name="tomcat" dev=sda6 ino=98262
scontext=system_u:system_r:initrc_su_t:s0 tcontext=user_u:object_r:usr_t:s0
tclass=lnk_file


Thanks again,

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
