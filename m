Date: Sun, 26 Mar 2006 22:14:59 -0500 (EST)
From: Gaurav Poothia <gpoothia@cs.sunysb.edu>
To: Valdis.Kletnieks@vt.edu
cc: SELinux@tycho.nsa.gov
Subject: Re: Query about desktop apps. 
In-Reply-To: <200603260351.k2Q3paAS022578@turing-police.cc.vt.edu>
Message-ID: <Pine.GSO.4.53.0603262138250.5076@compserv1>
References: <Pine.GSO.4.53.0603252027240.10215@compserv1>
 <200603260351.k2Q3paAS022578@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Sat, 25 Mar 2006 Valdis.Kletnieks@vt.edu wrote:

> On Sat, 25 Mar 2006 21:29:11 EST, Gaurav Poothia said:
>
> > Q1. Is the there a need for 2 different policies for an app like vi or is
> > there something I am missing?
>
> You're missing something.
>
> > Additionally it seems to me that we need a way for the regular users vi
> > policy to prevent him from overwriting other user's data (that probably
> > a solvable problem given the constructs,)
>
> The sysadmin invokes vi while already in a sysadm_t or similar context that
> is allowed to poke at the files in question.  The user is invoking it
> in user_t or similar..

I still dont see it. I assume that there is a vi specific domain to which
both both sys admin and regular user will have to transition. In which
case there should be 2 vi domains one for admin and other for regular
users and thus 2 policies. Please remember my question is about ANY
desktop app and vi is just an example.

>
> And remember - if the *regular* file permissions don't allow it, the SELinux
> ones won't matter.  So as long as userA doesn't chmod 777 the file, userB
> still can't get at it..

> > Q2. How do you make an app like vi when invoked by a regular user stick to
> > that particualar user's data?
>
> File permissions still work.
>
> And if you're *really* paranoid, you can always define separate SELinux
> identities  usera:user_r:user_t and userb:user_r:user_t and add rules that
> prohibit a usera process from using userb files and vice versa.

Yes I dont want the regular permission model, I wanted MAC.
I do agree that solution will work.Although it seems to me that the
policy needs to be aware of the users. Thats not very scalable.

> Or use the MCS stuff to add categories, and define userA and userB with
> separate default categories that each other can't read (this doesn't scale
> well past 256 users, however).
>
> > Q3More importantly how do you prevent a malicious vi binary from modifying
> > any of the users own file on the sly (afterall the user can use vi to
> > modify ANY of his files, so no
> > policy should really stop vi from doing so)
>
> Fix the system so a malicious vi binary can't be installed in the first place.

Again (and this is the crux) please consider ANY desktop app. How can we
enforce MAC on any app?




I am trying to solve the general problem of WHAT IS the Mandatory policy
for desktop apps. Any comments will be appreciated.Thanks!
-Gaurav

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
