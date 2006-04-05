Subject: Re: End User Mailing List / Group / Policy Made Easy
From: Erich Schubert <erich@debian.org>
To: "Randal T. Rioux" <randy@procyonlabs.com>
Cc: sds@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44333C9E.4050508@procyonlabs.com>
References: <442B182D.9060104@redhat.com> <442B7848.8060406@hotmail.com>
	 <4430AABF.5000301@procyonlabs.com>
	 <1144067579.22768.3.camel@wintermute.xmldesign.de>
	 <1144072348.9028.47.camel@moss-spartans.epoch.ncsc.mil>
	 <44333C9E.4050508@procyonlabs.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 05 Apr 2006 13:57:29 +0200
Message-Id: <1144238249.19128.7.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Randy,
> In reference to user interfacing, I was considering developing an
> ncurses based editor. I generally don't install X libraries on servers

I definitely do agree here, I don't have X on any of my SELinux boxes
either.
You can do certain things remotely by copying files around (but that,
too, can be a PITA if you e.g. don't have ssh_sysadm logins), so I'd
like to see a ncurses frontent e.g. for picking the modules to link.

When you are tackling the module selection, please try to come up with
an interface that handles
- dependencies - users selecting "postfix" need "mta", too.
- suggestions - if postfix is installed, "postfix.pp" should be
preselected; however the "rsync.pp" module is only needed for running an
rsync server IIRC, not for running rsync manually over SSH which is
probably more common.

I wouldn't do this just by "preseeding", but I would display all modules
that the distribution magic spits out specially.
You can run the magic in the inital run, analyze the installed software,
then preselect the relevant modules. However, people may install
additional software later, or deinstall some. Therefore it would be nice
if the user could fire up the module picker and see the relevant entries
highlighted.

Aptitude has a pretty nice text UI for such things, albeit pretty
complex by now. But it can handle all kinds of dependencies,
suggestions, automatically installed packages and so on.

Some things I'd like to see discussed on the mailing list here:
1. How to extract dependency information from modules?
2. Where to store package -> module mappings for module autoselection?

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     You know we all became mathematicians for the same reason:     //\
                  we were lazy. --- Max Rosenlicht                  V_/_
          Ein schöner Moment leuchtet das Leben hindurch.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
