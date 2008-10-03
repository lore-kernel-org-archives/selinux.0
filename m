Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9308ppA016570
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2008 20:08:51 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9308oLW015849
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2008 00:08:51 GMT
Message-ID: <48E5628C.1070008@redhat.com>
Date: Fri, 03 Oct 2008 10:08:44 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: "Working with SELinux" sections
References: <48D889A0.1010604@redhat.com> <9405.1222399818@turing-police.cc.vt.edu>            <48E2C203.6020603@redhat.com> <60227.1222833628@turing-police.cc.vt.edu>
In-Reply-To: <60227.1222833628@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 01 Oct 2008 10:19:15 +1000, Murray McAllister said:
> 
>>> Erm. What *exactly* produces that entry in /var/log/messages?
>> Are you referring to SELinux denying access or setroubelshoot-server?
>>> AVC stuff ends up in auditd.  Or is this just because the setroubleshoot
>>> RPMs aren't *quite* as mandatory as you noted above, and I don't see those
>>> messages because I don't have them installed *and enabled*? (Gotta watch
>>> out for those pesky 'chkconfig off' ;)
>> I thought I tried this before writing (thinking it only went into 
>> audit.log if setroubleshoot-server was installed, otherwise it would go 
>> to /var/log/messages). I will fix the text up to reflect this...
> 
> AVC's go into dmesg (and wherever your syslog dumps that) if auditd isn't running.
> 
> AVC's goes into audit.log if auditd *is* running.
> 
> If setroubleshoot is running, it reads audit.log and pretty-prints them
> into the syslog.
I added a small section:

Which Log File is Used

In Fedora 10, the setroubleshoot-server and audit packages are installed 
by default. These packages include the setroubleshootd and auditd 
daemons respectively. These daemons run by default.

SELinux denial messages, such as the following, are written to 
/var/log/audit/audit.log by default:

[example message]

Also, if setroubleshootd is running, which is it by default, denial 
messages from /var/log/audit/audit.log are translated to an 
easier-to-read form and sent to /var/log/messages:

[example message]

Denial messages are sent to a different location, depending on which 
daemons are running:

[segmented list]
Daemon		Log Location

auditd running		/var/log/audit/audit.log
auditd off; rsyslogd running	/var/log/messages
setroubleshootd		/var/log/audit/audit.log. Easier-to-read denial 
messages also sent to /var/log/messages

Sorry for how the table looks :(
> 
>> This is coming next in a separate chapter. Why can't you do much with 
>> MCS if everyone is user_u? Doesn't it use the level, not the user/role/type?
> 
> Whether you're using either the level or the classification, you need to be
> able to run users at different levels/classes for it to do any real good:
> 
> Consider:
> 
> User1 can read classes A, B, C.
> User2 can read classes B, D, E.
> User3 can read classes A, B, and E.
> 
> Wow.  That works pretty nice.
> 
> Now consider if you only have 1 defined user for people to run as:
> 
> User_u can read classes A, B, C.
> User_u can read classes B, D, E.
> User_u can read.. oh nevermind. ;)
> 
> So you need to be able to say "userid fred runs as user1, userid joe runs
> as user2, userid dept-paperwork runs as user3/levelA, userid dept-admin runs
> as user3/levelB", and so on....
> 
> The stock MCS policy provides enough user classes and levels to protect the
> *system* from users - but you need to roll-your-own to protect user data to
> a similar level.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
