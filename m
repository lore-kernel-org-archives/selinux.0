Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m910JNDi027170
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 20:19:23 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m910JMY0028987
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 00:19:23 GMT
Message-ID: <48E2C203.6020603@redhat.com>
Date: Wed, 01 Oct 2008 10:19:15 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: "Working with SELinux" sections
References: <48D889A0.1010604@redhat.com> <9405.1222399818@turing-police.cc.vt.edu>
In-Reply-To: <9405.1222399818@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 23 Sep 2008 16:16:00 +1000, Murray McAllister said:
> 
>> * selinux-policy-[policy]: provides SELinux policies. For targeted 
>> policy, install selinux-policy-targeted. For MLS, install 
>> selinux-policy-mls. The strict policy was merged in Fedora 9, allowing 
>> confined and unconfined users to co-exist on the same system.
> 
> Strict was merged with what, exactly? (This threw me for a loop when
> strict evaporated out of rawhide, before I figured out that MLS was what
> I needed as the replacement - for most of my boxes, I don't actually *need*
> the MLS/MCS stuff, I just need to not have an 'unconfined' on the box.  For
> a *few* others, the MCS stuff is handy.  And actual MLS is barely on the
> radar here...)
Stephen answered this. I will try to cover it later.
> 
>> denied if running in enforcing mode. When using disabled mode, SELinux 
>> is disabled (the SELinux module is not registered with the Linux 
>> kernel), and only DAC rules are used.
> 
> Might want to note that operating in disabled mode probably means you want
> to do a relabel if you re-enable SELinux, because any files created/modified
> while running disabled are probably unlabeled.
I added a note. How about:

When systems run with SELinux in permissive or disabled mode, users have 
permission to label files incorrectly. Also, files created while SELinux 
is disabled are not labeled. This causes problems when changing to 
enforcing mode. To prevent incorrectly labeled and unlabeled files from 
causing problems, relabel the entire file system before enabling SELinux 
in enforcing mode.
> 
>> SELINUXTYPE=targeted: The SELINUXTYPE option sets the SELinux policy to 
>> use. Targeted policy is the default policy used. Only change this option 
>> if you want to use the MLS policy. To use the MLS policy, install the 
>> selinux-policy-mls package; configure SELINUXTYPE=mls in 
>> /etc/selinux/config; and reboot your system.
> 
> Someplace, you want to discuss why one might want to use MLS (whether as the
> replacement for the old 'strict' policy where everything ran confined as
> opposed to 'targeted', or if you have an actual use case for the MLS/MCS
> features).
I will try to cover this later, thanks.
> 
>> 4. In permissive mode, SELinux policy is not enforced, but denials are 
>> still logged for actions that would have been denied if running in 
>> enforcing mode. Before changing to enforcing mode, as the Linux root 
>> user, run the grep "SELinux is preventing" /var/log/messages command to 
> 
> Erm. What *exactly* produces that entry in /var/log/messages?
Are you referring to SELinux denying access or setroubelshoot-server?
   All my
> AVC stuff ends up in auditd.  Or is this just because the setroubleshoot
> RPMs aren't *quite* as mandatory as you noted above, and I don't see those
> messages because I don't have them installed *and enabled*? (Gotta watch
> out for those pesky 'chkconfig off' ;)
I thought I tried this before writing (thinking it only went into 
audit.log if setroubleshoot-server was installed, otherwise it would go 
to /var/log/messages). I will fix the text up to reflect this...

I will put a note about starting setroubleshoot after installing 
setroublehsoot-server (and checking chkconfig). I wanted them installed 
(not mandatory as you pointed out), because I thought, to start with, that:

Oct  1 20:04:57 localhost setroubleshoot: SELinux is preventing httpd 
(httpd_t) "getattr" to /var/www/html/file1 (samba_share_t). For complete 
SELinux messages. run sealert -l de7e30d6-5488-466d-a606-92c9f40d316d

Would be less intimidating than:

type=AVC msg=audit(1222855496.948:70): avc:  denied  { getattr } for 
pid=2120 comm="httpd" path="/var/www/html/file1" dev=dm-0 ino=399185 
scontext=unconfined_u:system_r:httpd_t:s0 
tcontext=system_u:object_r:samba_share_t:s0 tclass=file

> 
>> # should users run something like "> /var/log/messages" before rebooting?
> 
> This is a good way to lose potentially important log entries.  
Would running "ausearch -m avc -ts today" after relabeling be better?
Also,
> note that if the box is running syslog-ng, the file might be called
> /var/log/messages.YYMMDD or similar (very handy, that - no need to worry
> about cronjobs rolling the files).
I have not used that. Cheers for the tip :)
> 
>> 5. If there were no denial messages in /var/log/messages, configure 
>> SELINUX=enforcing in /etc/selinux/config:
> 
> You need to discuss the very possible case that there *were* denial messages.
> How do you fix them?  audit2allow is *one* option, as is correctly labelling
> files (if you have them in a non-standard place, you probably want to be doing
> an 'semanage fcontext -a').  But blindly doing either of those is a good way to
> hose yourself gloriously.
There is going to be a troubleshooting section that can be cross 
referenced here.

I do not know what sort of denials are common after relabeling, or how 
they can be fixed if the relabel process does not fix them. Does anyone 
know if it is common to have problems after relabeling?
> 
>> 7. As the Linux root user, run the semanage login -l command to confirm 
>> that the mapping between SELinux and Linux users is correct. The output 
>> should be as follows:
> 
> Also handy at this point - explain how to add additional SELinux userids
> and map login IDs to them (you can't really do anything with the MLS/MCS
> support if everybody is either user_u or staff_u).
This is coming next in a separate chapter. Why can't you do much with 
MCS if everyone is user_u? Doesn't it use the level, not the user/role/type?

Thanks for your help.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
