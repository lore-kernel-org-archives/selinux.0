Message-ID: <006201c3f2a4$ad21fcf0$6401a8c0@williams>
Reply-To: "Douglas Williams" <douglaswilliams@sympatico.ca>
From: "Douglas Williams" <douglaswilliams@sympatico.ca>
To: <SELinux@tycho.nsa.gov>
Subject: Fw: Of applications and separating configuration systems
Date: Fri, 13 Feb 2004 21:45:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov




>
> ----- Original Message ----- 
> From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
> To: <SELinux@tycho.nsa.gov>
> Sent: Friday, February 13, 2004 7:09 PM
> Subject: Of applications and separating configuration systems
>
>
> > Hi,
> >   Having started looking at SELinux a thought struck me.
> > As a general matter of practice wouldn't it be better for desktop
> > like applications to have the preference editing done by a separate
> > program (binary) whose only job is to edit those preferences and
> > configurations.
> >
> > The thought is bought about by hearing of some of the viruses/worms that
> > have happened where a virus has disabled some of the other security
> > features in an app.    If the main app that was exposed to user
> > data couldn't alter its own preferences file then this risk
> > would be greatly reduced.
> >
>
> heavily encrypted key and a monitor that can lock down the system is a
> service is disabled
>
> > It strikes me that normal users of a system might want to have multiple
> > contexts to them within a windowing system; for example with seperate
> > permissions for normal stuff, a web browser, the web browser they use
> > for confidential stuff, and building things they downloaded.
> > Is it easy to set such a system up?  What about allowing normal users
> > to see the policy violations that are causing their individual programs
> > are making?
> >
>
> Like a Windows discretionary access control list  (DACL)
>
> > Dave
> >
> >  -----Open up your eyes, open up your mind, open up your code ------- 
> > / Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \
> > \ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> > the words "unsubscribe selinux" without quotes as the message.
> >
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
