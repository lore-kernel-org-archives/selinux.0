Subject: Re: Bug in restorecon for symlinks in root dir
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1156944181.18406.19.camel@wintermute.xmldesign.de>
References: <1156205841.22905.33.camel@wintermute.xmldesign.de>
	 <1156346855.8506.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1156354840.2883.4.camel@wintermute.xmldesign.de>
	 <1156433253.8506.175.camel@moss-spartans.epoch.ncsc.mil>
	 <1156446186.13088.45.camel@wintermute.xmldesign.de>
	 <1156944181.18406.19.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 09:51:03 -0400
Message-Id: <1156945863.22210.308.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-30 at 15:23 +0200, Erich Schubert wrote:
> Hello Stephen,
> I've seen you've commited the fix for restorecon on the /lib64 symlink.
> 
> How about this fix for correct handling of //lib64 etc.?
> In contrast to my previous mail, the "len == 0" part in the if statement
> should be necessary (for the /lib64 case; since path="" in that
> situation)
> The "len == 0" test is only unneeded if we used my initial patch (with
> strcpy("/", path)); since the len == 0 case should then never occur.
> 
> The patch is straightforward - it only adds / to the path if it doesn't
> end in a slash yet. Since this will result in path names at most 1 char
> shorter than before, the buffer size check doesn't need to be modified
> (though it wastes one character then)
> 
> > --- restorecon.c        2006-08-24 20:57:56.000000000 +0200
> > +++ restorecon.c        2006-08-24 21:01:44.000000000 +0200
> > @@ -197,8 +197,11 @@
> >                         return 1;
> >                 }
> >                 p += len;
> > -               *p = '/';
> > -               p++;
> > +               /* ensure trailing slash of directory name */
> > +               if (len == 0 || *(p-1) != '/') {
> > +                       *p = '/';
> > +                       p++;
> > +               }
> >                 strcpy(p, file_sep);
> >                 filename = path;
> >         } else {

Looks fine to me.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
