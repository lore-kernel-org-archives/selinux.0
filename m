Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s68JVwNw029658
 for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2014 15:31:58 -0400
Received: by mail-wi0-f171.google.com with SMTP id f8so1091207wiw.16
 for <selinux@tycho.nsa.gov>; Tue, 08 Jul 2014 12:31:37 -0700 (PDT)
Message-ID: <1404847895.19090.9.camel@x220.localdomain>
Subject: Re: secilc: is anyone able to confirm that type_change ...
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Tue, 08 Jul 2014 21:31:35 +0200
In-Reply-To: <53BC44BB.6000708@tresys.com>
References: <1404563967.9852.42.camel@x220.localdomain>
 <1404652323.9852.49.camel@x220.localdomain> <53BAA801.8070308@tresys.com>
 <1404743060.9852.50.camel@x220.localdomain>
 <1404744312.9852.55.camel@x220.localdomain> <53BC44BB.6000708@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-07-08 at 15:21 -0400, Steve Lawrence wrote:
> On 07/07/2014 10:45 AM, Dominick Grift wrote:
> > On Mon, 2014-07-07 at 16:24 +0200, Dominick Grift wrote:
> >> On Mon, 2014-07-07 at 10:00 -0400, Steve Lawrence wrote:
> >>
> >>> I can't reproduce the problem with my test policies. The typechange
> >>> statements look like they are correctly inserted into the binary and I
> >>> am seeing the expected type changes at runtime.
> >>>
> >>> Is this with your monogam policy?
> >>>
> >>
> >> No, that one is no longer maintained.
> >>
> >> It is this very small base policy:
> >>
> >> https://github.com/doverride/e145
> >>
> > 
> > Note though, with that version, that there is no type_change rule from
> > devpts_t to device_session_pts_t currently (so if you were to test this
> > with sshd then it would be lacking the type change rule)
> > 
> > Either insert that type_change rule manually or test it with the (local)
> > login program since there is a type_change session_t
> > device_tty_t:chr_file device_session_tty_t rule present.
> > 
> > There is also a conditional type change rule for console_device_t to
> > device_session_tty_t.
> > 
> > I cannot imagine me having overlooked anything. Since there are only two
> > domains (system_t and session_t), and both are virtually unconfined.
> > 
> > 
> 
> Ok, finally managed to track down this issue. Turns out to be an
> ordering problem. You have your classes listed in alphabetical order.
> Order shouldn't matter with CIL and everything should work correctly,
> and in most cases is does. However, we assign integer values to each
> class based on the order we see them. So the first one we see gets value
> 1, second gets 2, etc. If these values don't match up with what
> userspace and the kernel expect them to be, things break.
> 
> So the temporary solution is to reorder your class statements so that
> they are in the order defined in flask.h [1] so they get the right values.
> 
> The long term solution is to add a new statement to CIL (classorder,
> similar to sidorder) that defines this order, allowing the class
> definitions to appear in any order.
> 
> Thanks,
> - Steve
> 
> [1]
> https://github.com/SELinuxProject/selinux/blob/master/libselinux/include/selinux/flask.h
> 
> 
> 

Awesome, thanks for tracking this down. I was starting to doubt myself.
