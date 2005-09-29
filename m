Message-ID: <433C3DE7.2010208@redhat.com>
Date: Thu, 29 Sep 2005 15:17:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: apmd policy
References: <1127933375.32172.79.camel@sgc.columbia.tresys.com> <1128018969.27495.127.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128018969.27495.127.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Wed, 2005-09-28 at 14:49 -0400, Christopher J. PeBenito wrote:
>  
>
>>In the apmd.te, what is the difference between the apm_t and apmd_t
>>domains?  The naming make it very confusing.  By looking at the TE rules
>>and file contexts, I'm guessing that apm_t is an interactive program.
>>    
>>
>
>Yes, looks that way.  /usr/bin/apm is the client program, /usr/sbin/apmd
>is the daemon, and they each have their own domain.  man 1 apm describes
>the user command on Fedora.
>
>  
>
Hopefully apmd will be going away and replaced with gnome_power_manager.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
