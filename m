Subject: Re: Sendmail & SELinux policies
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Tanel Kokk <tanel.kokk@seb.ee>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <4434DAC4.6090006@seb.ee>
References: <4434DAC4.6090006@seb.ee>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 07:40:40 -0400
Message-Id: <1144323640.6176.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-04-06 at 12:09 +0300, Tanel Kokk wrote:
> Hello
> 
> I made SELinux policies for sendmail on CentOS (seemed, that 
> target-policy contains somekind of incomplete policy for sendmail)

The upstream example policy has a sendmail policy, but targeted policy
doesn't include it.

> Mostly it seems work fine. however some times I find selinux audit-logs 
> from dmesg:
> 
> audit(1144310301.564:2): avc:  denied  { getattr } for  pid=11789 
> comm="sendmail" name="null" dev=sda2 ino=293212 
> scontext=user_u:system_r:sendmail_t tcontext=system_u:object_r:device_t 
> tclass=chr_file
> audit(1144310301.564:3): avc:  denied  { ioctl } for  pid=11789 
> comm="sendmail" name="null" dev=sda2 ino=293212 
> scontext=user_u:system_r:sendmail_t tcontext=system_u:object_r:device_t 
> tclass=chr_file

This looks suspect, as the null device should be labeled null_device_t,
not just device_t.  ls -Z /dev/null

> audit2allow get:
> allow sendmail_t device_t:chr_file { getattr ioctl };
> 
> However I have this line in ./src/policy/domains/program/local.te:
> allow sendmail_t device_t:chr_file { read write getattr ioctl };
> 
> As I understand I already have allowing policy record for this 
> situation. Why I still got this denied messages for sendmail_t?

First, I don't think you want to allow it (potential access to device
nodes that don't have a specific type).  You want to fix the label
on /dev/null instead.

Not sure why your local rule isn't applied though, unless you just
didn't do a make load after adding it.  You can try doing a make clean
load to be sure it was rebuilt.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
