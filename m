Message-ID: <44350058.7080505@seb.ee>
Date: Thu, 06 Apr 2006 14:49:44 +0300
From: Tanel Kokk <tanel.kokk@seb.ee>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: Sendmail & SELinux policies
References: <4434DAC4.6090006@seb.ee> <1144323640.6176.5.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1144323640.6176.5.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-04-06 at 12:09 +0300, Tanel Kokk wrote:

> This looks suspect, as the null device should be labeled null_device_t,
> not just device_t.  ls -Z /dev/null

Ouch! I have to note, that I have chrooted sendmail environment and 
/sm_chroot/dev/null really has a label device_t. Now fixed to null_device_t.

> 
>> audit2allow get:
>> allow sendmail_t device_t:chr_file { getattr ioctl };
>>
>> However I have this line in ./src/policy/domains/program/local.te:
>> allow sendmail_t device_t:chr_file { read write getattr ioctl };
>>
>> As I understand I already have allowing policy record for this 
>> situation. Why I still got this denied messages for sendmail_t?
> 
> First, I don't think you want to allow it (potential access to device
> nodes that don't have a specific type).  You want to fix the label
> on /dev/null instead.

OK. I'll check my dev files and fix them to appropriate label.

> Not sure why your local rule isn't applied though, unless you just
> didn't do a make load after adding it.  You can try doing a make clean
> load to be sure it was rebuilt.
> 

I allways did 'make relabel' and 'make reload'.

Thanks! I'll look things over.


-- 
Tanel Kokk


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
