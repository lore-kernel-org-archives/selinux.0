Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8CAPPP5004605
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 06:25:25 -0400
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8CAPPHb020021
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 10:25:25 GMT
Date: Fri, 12 Sep 2008 12:25:12 +0200
From: =?iso-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Justin Mattock <justinmattock@gmail.com>,
        David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: SE Linux <selinux@tycho.nsa.gov>, Hong <kindloaf@gmail.com>,
        tresys <refpolicy@oss.tresys.com>
Subject: Re: [refpolicy] ssh issue with latest policy
Message-ID: <20080912102512.GA17901@bobek.pm.i.cz>
References: <dd18b0c30809101232la13c43mee3d9ab0bfe2f509@mail.gmail.com> <20080911125025.GA5448@bobek.pm.i.cz> <37499.145.64.134.222.1221206972.squirrel@www.hardeman.nu> <dd18b0c30809101232la13c43mee3d9ab0bfe2f509@mail.gmail.com> <20080911125025.GA5448@bobek.pm.i.cz> <dd18b0c30809111401h4575b1dcub226f6c4ab40a5bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <37499.145.64.134.222.1221206972.squirrel@www.hardeman.nu> <dd18b0c30809111401h4575b1dcub226f6c4ab40a5bc@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 11, 2008 at 02:01:08PM -0700, Justin Mattock wrote:
>...
> appologize for the latency with getting back to you;
> you might have the ssh version from sid, if so
> do /etc/init.d/ssh stop and start if you notice [fail] then thats the issue,
> esspecially if people are booting up and not even manually starting the daemon.
> As for the policy and ssh I'm in the process of
> having two machines in full enforcing mode, having the ability
> to do a ssh transaction(need to configure some things); As well
> as vncviewer, and shoutcast; all with ipsec. (AH and ESP)
> right now I've been able to run all three applications on the machine
> that is in full enforcement, but it seems im having issues with ipsec
> and shoutcast.
> on the server side.
> I'll get back to you on this.
> 
> -- 
> Justin P. Mattock

I just reported the bug in sshd
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=498684
This is upstream OpenSSH problem too.

On Fri, Sep 12, 2008 at 10:09:32AM +0200, David Härdeman wrote:
> On Thu, September 11, 2008 14:50, Václav Ovsík wrote:
> > Conclusion: Running SE Linux in permissive mode can't prevent you from
> > all SE Linux problems every time! (in most cases yes of course :)
> 
> Another example of that is that dbus seems to do SELinux permission checks
> even after permissive mode is enabled.
> 
> -- 
> David Härdeman

It should be reported if it is true, IMO.

Regards
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
