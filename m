Subject: Re: MLS and default file contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted X Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4767F243.3090509@gmail.com>
References: <4767F243.3090509@gmail.com>
Content-Type: text/plain
Date: Tue, 18 Dec 2007 11:36:05 -0500
Message-Id: <1197995765.7967.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-18 at 10:16 -0600, Ted X Toth wrote:
> As best I can tell the current implementation requires a context to have 
> a level or range to be valid in an fc file. However there a cases where 
> I'd prefer that files be created with a given context but at the level 
> of the creating process. Is there a way to do specify this behavior in 
> an fc file?

The fc files are just to provide install-time defaults for file labels.
Runtime creation of files is governed by policy; in the case of MLS,
this is inherit-from-creator unless a range transition rule is
specified.

So the only real issue is exempting runtime files from a relabel, which
can be done by specifying a <<none>> entry in a fc file, or putting a
"customizable file context" on the file, or excluding that tree from
relabels.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
