Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82DXqrT028939
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 09:33:52 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82DX23w001193
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 13:33:02 GMT
Date: Thu, 2 Sep 2004 14:44:54 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: what to do with matchpathcon on S_IFCHR, S_IFBLK, hard links and fifos
Message-ID: <20040902134454.GC5745@lkcl.net>
References: <20040901174909.GF4400@lkcl.net> <1094126565.17265.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094126565.17265.9.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 08:02:45AM -0400, Stephen Smalley wrote:

> On Wed, 2004-09-01 at 13:49, Luke Kenneth Casson Leighton wrote:
> > when using matchpathcon(), is there anything special that should
> > be done for the above filetypes, or should the mode_t argument
> > just be passed through and let libselinux worry about it?
> 
> Pass the mode; matchpathcon will take (mode & S_IFMT) and compare it
> with the file type specified in file_contexts (-b, -c, -d, -p, -l, -s,
> --, or nothing to match any file type).

 ta stephen.

 okay, second question, if i may.

 if i have set up file contexts on some files in a temporary
 directory (of course, using matchpathcon to set the context
 of where the file is _going_ to be not where it _is_), then
 will the "/bin/mv" command preserve those file contexts
 even across filesystem boundaries - without any extra arguments?

 if so i don't have to patch dpkg's use of mv, which would be good.

 ta,

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
