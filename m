Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s67EpLCI028862
 for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2014 10:51:21 -0400
Received: by mail-we0-f174.google.com with SMTP id u57so4543447wes.33
 for <selinux@tycho.nsa.gov>; Mon, 07 Jul 2014 07:51:24 -0700 (PDT)
Message-ID: <1404744312.9852.55.camel@x220.localdomain>
Subject: Re: secilc: is anyone able to confirm that type_change ...
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Mon, 07 Jul 2014 16:45:12 +0200
In-Reply-To: <1404743060.9852.50.camel@x220.localdomain>
References: <1404563967.9852.42.camel@x220.localdomain>
 <1404652323.9852.49.camel@x220.localdomain> <53BAA801.8070308@tresys.com>
 <1404743060.9852.50.camel@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2014-07-07 at 16:24 +0200, Dominick Grift wrote:
> On Mon, 2014-07-07 at 10:00 -0400, Steve Lawrence wrote:
> 
> > I can't reproduce the problem with my test policies. The typechange
> > statements look like they are correctly inserted into the binary and I
> > am seeing the expected type changes at runtime.
> > 
> > Is this with your monogam policy?
> > 
> 
> No, that one is no longer maintained.
> 
> It is this very small base policy:
> 
> https://github.com/doverride/e145
> 

Note though, with that version, that there is no type_change rule from
devpts_t to device_session_pts_t currently (so if you were to test this
with sshd then it would be lacking the type change rule)

Either insert that type_change rule manually or test it with the (local)
login program since there is a type_change session_t
device_tty_t:chr_file device_session_tty_t rule present.

There is also a conditional type change rule for console_device_t to
device_session_tty_t.

I cannot imagine me having overlooked anything. Since there are only two
domains (system_t and session_t), and both are virtually unconfined.
