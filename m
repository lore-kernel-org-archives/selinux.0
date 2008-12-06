Message-ID: <4939D171.5090705@tycho.nsa.gov>
Date: Fri, 05 Dec 2008 20:12:17 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: Joe Nall <joe@nall.com>, SELinux List <selinux@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] Add color translation support to mcstransd
References: <4927839F.4070805@tycho.nsa.gov>	 <AD1BDA2B-D7CF-48AC-846E-54DC795B3C08@nall.com>	 <492AFFAD.5070805@tycho.nsa.gov> <cadfc0e40812051416v15070ddag132ff548d535052c@mail.gmail.com> <4939C7D8.7020000@tycho.nsa.gov>
In-Reply-To: <4939C7D8.7020000@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> I have placed the code into a git repository which can be checked out with:
> git-clone git://people.freedesktop.org/~ewalsh/mcstrans
>
> The "master" branch contains the code that was in the SRPM file that Joe
> posted to this list in June.  If you have more recent changes send them
> my way and I will update the repo to include them.
>
> The "color-ewalsh" branch contains the color code for the proposal
> above.  There have been some changes, namely:
>
> The format of the returned string is now hex digits with hash marks,
> e.g.  "#000000 #ffffff #000000 #ffffff..."
> The separate "level" and "category" rules have been dropped and replaced
> by a single "range" rule.  The SELinux interface does not expose the
> details of the MLS component of the security context.  The only function
> offered is a "dominance" check implemented as a permission bit on the
> "context" security class (and even this doesn't currently work
> correctly, because it only accepts domains as the subject context, more
> on this in another post).  Whether the details, which would include the
> ebitmaps for categories and level numbers, should be exposed is up for
> debate.  Because of this only eight colors are now returned

A screen shot of a sample application that uses the color translations
can be seen at:
http://people.freedesktop.org/~ewalsh/mcscolor_screenshot.png


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
