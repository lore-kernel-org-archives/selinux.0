Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA04450
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 13:40:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA19619
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 17:38:44 GMT
Received: from smails.tresys.com ([66.200.42.5])
        by jazzband.ncsc.mil  with ESMTP id RAA19615 for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 17:38:44 GMT
From: "david caplan" <dac@tresys.com>
To: "Russell Coker" <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: checkpolicy and login names
Date: Tue, 24 Sep 2002 13:40:50 -0400
Message-ID: <GBEAJBKHFOBIBBJBCGAGIEKJCFAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200209241900.20427.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

chown will accept ':' or '.' as a separator when you want to specify a
group.  In the case where there is a conflict between username and group
name, it will defer to the username.  For example, if I have users foo and
foo.bar and a group bar:

chown foo.bar file

will only change the owner on file to foo.bar.  If I wanted to change it to
foo with group bar I have to use:

chown foo:bar file

It accepts foo.bar.bar to change the ownership to foo.bar and the group to
bar.  If one had a bar.bar group as well, then you'd have to enter

chown foo:bar.bar

[I think I got that right :-)]

I admit it's confusing, but it (chown) seems to be built to handle this.  It
appears, though I can find no documentation on this, that the "standard" for
a username is that it starts with a letter (upper or lower) and can be
followed by [a-zA-Z0-9._-]*

david

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Russell Coker
> Sent: Tuesday, September 24, 2002 1:00 PM
> To: david caplan; selinux@tycho.nsa.gov
> Subject: Re: checkpolicy and login names
>
>
> On Tue, 24 Sep 2002 16:32, david caplan wrote:
> > We just ran across the case where we were trying to add a login
> name with a
> > '.' in it.  When we tried to add the user to the policy,
> checkpolicy choked
> > on the '.' in the id.  The parser expects an Identifier, which
> is defined
> > to be a letter followed by a combination of letter|digit|_ of
> any length.
>
> What about "chown user.group file"?  I think that alone is a good enough
> reason not to want to have a '.' in a user-name.
>
> Of course there does not have to be any mapping between user-names and SE
> identities, and the SE identities should not be limited in the
> same way as
> Unix account names for this reason.
>
> I could imagine a model where you might have Unixname.something as the SE
> identity...
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
