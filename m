Message-ID: <424C56C9.60603@redhat.com>
Date: Thu, 31 Mar 2005 15:00:09 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
Subject: Re: Logrotate, ssh_agent - read selinux_config_t
References: <1112295975.12948.72.camel@cobra.ivg2.net>	 <1112295549.11216.162.camel@moss-spartans.epoch.ncsc.mil>	 <1112298109.12948.80.camel@cobra.ivg2.net> <1112297844.11216.178.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1112297844.11216.178.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2005-03-31 at 14:41 -0500, Ivan Gyurdiev wrote:
>  
>
>>[phantom@cobra ~]$ SYMBOLS=`cat /usr/include/selinux/*|grep extern|sed
>>-e s/\(.*//|sed -e s/.*" "//|grep ^[a-zA-Z]`
>>[phantom@cobra ~]$ for SYMBOL in $SYMBOLS; do if [ ! -z "`grep
>>$SYMBOL /usr/sbin/logrotate`" ]; then echo $SYMBOL; fi; done;
>>is_selinux_enabled
>>freecon
>>getfscreatecon
>>setfscreatecon
>>getfilecon
>>fgetfilecon
>>selinux_getenforcemode
>>[phantom@cobra ~]$ for SYMBOL in $SYMBOLS; do if [ ! -z "`grep
>>$SYMBOL /usr/bin/ssh-agent`" ]; then echo $SYMBOL; fi; done; 
>>
>>What does that mean - should they both be blocked, or only ssh-agent?
>>    
>>
>
>Of those functions, only selinux_getenforcemode() would need to
>read /etc/selinux/config, and I'm not sure why logrotate is using it
>instead of security_getenforce(), i.e. checking the current
>enforcing/permissive status rather than the one specified for boot-time
>in /etc/selinux/config.
>
>  
>
logrotate patch is fixed, will be in tomorrow's build.  I believe 
logrotate will need to read these files,
not sshd. 

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
