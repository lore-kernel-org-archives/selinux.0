Message-ID: <1400857321.20666.1.camel@x220.localdomain>
Subject: Re: secilc: in statement ordering limitations
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Date: Fri, 23 May 2014 17:02:01 +0200
In-Reply-To: <1400855557.10370.4.camel@x220.localdomain>
References: <1400689802.5957.5.camel@x220.localdomain>
 <537F4A07.70403@tycho.nsa.gov> <1400855557.10370.4.camel@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2014-05-23 at 16:32 +0200, Dominick Grift wrote:
> On Fri, 2014-05-23 at 09:15 -0400, James Carter wrote:
> 
> > Could you give me a little bit more information on what you are doing?
> 
> Strange.. It is kind of hard for me to put it any other way.

The core, i suspect, is that in my case systemd depends on a namespace
in dbus ( file.etc.dbusd.systemd.obj ) and dbus depends on a namespace
in systemd (file.unit.systemd.dbusd.obj)
