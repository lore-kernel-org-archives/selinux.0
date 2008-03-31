Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2V92VmH007672
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 05:02:32 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2V92Tqk029833
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 09:02:30 GMT
From: Jim Meyering <jim@meyering.net>
To: russell@coker.com.au
Cc: bug-coreutils@gnu.org
Cc: Michael Stone <mstone@debian.org>, 472590@bugs.debian.org,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#472590: ls in Debian/Unstable
In-Reply-To: <200803260824.17731.russell@coker.com.au> (Russell Coker's
	message of "Wed, 26 Mar 2008 08:24:15 +1100")
References: <200803251523.34329.russell@coker.com.au>
	<87tziu96yz.fsf@rho.meyering.net> <20080325173116.GQ2626@mathom.us>
	<200803260824.17731.russell@coker.com.au>
Date: Mon, 31 Mar 2008 11:02:27 +0200
Message-ID: <877ifj9sgs.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[ I'm Cc'ing bug-coreutils@gnu.org.
  FYI, this is a continuation of discussion from the SELinux list:
  http://marc.info/?t=120645074000003&r=1&w=2
  and the debian bug tracking system: http://bugs.debian.org/472590

  The problem is that on an SELinux-enabled system, 'ls -l's "+",
  the "alternate access method" indicator, is useless, because it
  appears on every file:

      $ ls -glo /var
      total 164
      drwxr-xr-x+  3 4096 2008-03-29 08:43 kerberos
      drwxr-xr-x+ 39 4096 2008-03-29 08:43 lib
      drwxr-xr-x+  2 4096 2008-03-27 17:33 local
      drwxrwxr-x+  8 4096 2008-03-31 04:15 lock
      drwxr-xr-x+ 20 4096 2008-03-31 09:55 log
      lrwxrwxrwx+  1   10 2008-03-28 23:33 mail -> spool/mail
      ...

  Newer POSIX allows any non-space character as the indicator, and
  that's what we're discussing now.
  ]

Russell Coker <russell@coker.com.au> wrote:
> On Wednesday 26 March 2008 04:31, Michael Stone <mstone@debian.org> wrote:
>> if (acl) then '+'
>> else if (selinux) then '.'
>
> Should there be some special marking of files with both a SE Linux context and
> an ACL?
>
> Pity that they didn't choose an "a" to mark an ACL which would then permit
> using "A" for ACL + MAC.

This is probably as good a time as any to make such a change, though
I doubt it will make the cut for the upcoming release.  I'd like to keep
it simple (i.e., not try to encode all possible combinations).  If you
want to get full details, stat(1) is probably the program to change.

I like Michael's suggestion.  Rephrasing it,

    if (SELinux, with no other MAC or ACL)
      use '.'
    else if (any other combination of alternate access methods)
      use '+'

If someone who already has a copyright assignment on file for coreutils
wants to write the patch (including doc update, tests, NEWS, ChangeLog,
etc.), please speak up ASAP.  Otherwise I'll do it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
