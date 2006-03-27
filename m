Message-ID: <dbf07f2b0603262130l4900214fgec6cc64b1ca73933@mail.gmail.com>
Date: Mon, 27 Mar 2006 16:30:15 +1100
From: "Mark Ennis" <mark.ennis@acm.org>
To: "Gaurav Poothia" <gpoothia@cs.sunysb.edu>
Subject: Re: Query about desktop apps.
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.53.0603262138250.5076@compserv1>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.GSO.4.53.0603252027240.10215@compserv1>
	 <200603260351.k2Q3paAS022578@turing-police.cc.vt.edu>
	 <Pine.GSO.4.53.0603262138250.5076@compserv1>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The default "targeted" policy only provides specific MAC restrictions
for a defined set of daemons which usually run with root privilege and
for which it is desirable to provide greater restriction. The user is
not restricted (or only minimally restricted in Fedora Core 5) by the
targeted policy and, therefore, any application run by the user is not
restricted. This includes desktop applications such as vi, KDE, GNOME,
Firefox, etc.

Under the other policies provided in the SELinux reference policy,
such as strict and MLS, the intent is to restrict everything unless
explicit policy is defined to permit it. This requires users of this
policy to define their own policy extensions to meet the requirements
of their systems. How you choose to handle desktop applications
becomes a local security policy issue. My impression is that generally
the intent is not to attempt to define policy related to each
individual application run in user space. Instead, roles are defined
with desired privileges, users are assigned to these roles and
applications run in user space are confined by the roles of the user
running the application.

So the answer to your question of "what is the mandatory policy for
desktop applications?" is "the mandatory policy which applies to the
user of the applications". Under targeted policy, that means minimal
policy restrictions.

Disclaimer: the above is just the impression formed by a lurker. I
don't claim to be an expert in SELinux. More informed opinions are
surely available, e.g.
http://www.fedoraproject.org/wiki/SELinux/Policies.

- Mark.

On 3/27/06, Gaurav Poothia <gpoothia@cs.sunysb.edu> wrote:
>
>
> On Sat, 25 Mar 2006 Valdis.Kletnieks@vt.edu wrote:
>
> > On Sat, 25 Mar 2006 21:29:11 EST, Gaurav Poothia said:
> >
> > > Q1. Is the there a need for 2 different policies for an app like vi or is
> > > there something I am missing?
> >
> > You're missing something.
> >
> > > Additionally it seems to me that we need a way for the regular users vi
> > > policy to prevent him from overwriting other user's data (that probably
> > > a solvable problem given the constructs,)
> >
> > The sysadmin invokes vi while already in a sysadm_t or similar context that
> > is allowed to poke at the files in question.  The user is invoking it
> > in user_t or similar..
>
> I still dont see it. I assume that there is a vi specific domain to which
> both both sys admin and regular user will have to transition. In which
> case there should be 2 vi domains one for admin and other for regular
> users and thus 2 policies. Please remember my question is about ANY
> desktop app and vi is just an example.
>
> >
> > And remember - if the *regular* file permissions don't allow it, the SELinux
> > ones won't matter.  So as long as userA doesn't chmod 777 the file, userB
> > still can't get at it..
>
> > > Q2. How do you make an app like vi when invoked by a regular user stick to
> > > that particualar user's data?
> >
> > File permissions still work.
> >
> > And if you're *really* paranoid, you can always define separate SELinux
> > identities  usera:user_r:user_t and userb:user_r:user_t and add rules that
> > prohibit a usera process from using userb files and vice versa.
>
> Yes I dont want the regular permission model, I wanted MAC.
> I do agree that solution will work.Although it seems to me that the
> policy needs to be aware of the users. Thats not very scalable.
>
> > Or use the MCS stuff to add categories, and define userA and userB with
> > separate default categories that each other can't read (this doesn't scale
> > well past 256 users, however).
> >
> > > Q3More importantly how do you prevent a malicious vi binary from modifying
> > > any of the users own file on the sly (afterall the user can use vi to
> > > modify ANY of his files, so no
> > > policy should really stop vi from doing so)
> >
> > Fix the system so a malicious vi binary can't be installed in the first place.
>
> Again (and this is the crux) please consider ANY desktop app. How can we
> enforce MAC on any app?
>
>
>
>
> I am trying to solve the general problem of WHAT IS the Mandatory policy
> for desktop apps. Any comments will be appreciated.Thanks!
> -Gaurav
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
