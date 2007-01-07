Subject: Re: cron on strict policy
From: Shintaro Fujiwara <shin216@xf7.so-net.ne.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1168011505.18961.155.camel@moss-spartans.epoch.ncsc.mil>
References: <f71a82820701031536j26d9d4epb84e3fe7ed95feb6@mail.gmail.com>
	 <1168011505.18961.155.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=EUC-JP
Date: Sun, 07 Jan 2007 19:24:05 +0900
Message-Id: <1168165445.2638.8.camel@mama.intrajp-yokosuka.co.jp>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>File a bug report against the FC6 cron - it is broken.

Thank you very much Mr.Smalley.

I cautiously changed my cron.pp to strict-policy's original one.

IT WORKED FINE !

I'm sorry, I've been writing bad .te .fc files and messed up.

I used selinux-policy-strict-2.4.6-13.fc6-noarch.rpm.

I understand my problem was that I try to install refpolicy's cron
to strict policy...

All I need to do is to write policy of my own.

Thank you !




2007-01-05 (金) の 10:38 -0500 に Stephen Smalley さんは書きました:
> On Thu, 2007-01-04 at 08:36 +0900, Shintaro Fujiwara wrote:
> > Hi
> > ,
> > I'm in trouble on cron, again.
> > I've installed strict policy 21 on FC6 to my internet server.
> > I found cron does not run at all.
> > I imagine it's a role problem perhaps ?
> > Should I write role statement in cron.te ?
> 
> File a bug report against the FC6 cron - it is broken.
> 
> > 
> > I semodule -r cron ed, and using
> > refpolicy's cron.te I used to use on FC5.
> > 
> > I edited /etc/crontab and
> > #crontab /etc/crontab
> > on permissive mode.
> > 
> > When permissive mode, it runs leaving messages something like
> > "Unauthorized SELinux context but persissive mode continuing"
> > Of course I'm now running my server on strict mode, so the cron
> > goes like this...
> > This is the cron log.
> > ---------------------------------------
> > #less /var/log/cron
> > 
> > STARTUP (V5.0)
> > Dec 30 07:17:20 intrajp crond[1637]: (system_u) Unauthorized SELinux
> > context (/etc/crontab)
> > Dec 30 07:17:20 intrajp crond[1637]: (root) Unauthorized SELinux
> > context (cron/root)
> > 
> > Unauthorized SELinux context
> > ---------------------------------------
> > This is the security context.
> > [root@intrajp ~]# ls -laZ /etc/crontab
> > -rw-r--r-- root root system_u:object_r:system_cron_spool_t:s0 /etc/crontab
> > 
> > Thanks in advance.
> > 
> > 
> > My homepage
> > http://intrajp.no-ip.com/
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
