Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9QHrlXZ014519
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 13:53:48 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9QHqTC0010698
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 17:52:30 GMT
Date: Tue, 26 Oct 2004 19:04:37 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] devpts xattr support
Message-ID: <20041026180437.GD8652@lkcl.net>
References: <417E5BB5.1010300@trustedcs.com> <1098801765.27060.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098801765.27060.39.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 26, 2004 at 10:42:46AM -0400, Stephen Smalley wrote:

> extended attributes (e.g. singe-level filesystems).  So now would be a
> good time to confirm that we want to proceed down this path of adding
> more fake xattr handlers wherever the filesystem does not natively
> support xattrs so that userspace can have a single consistent interface
> for getting file contexts.
 
 especially as the author of squashfs is adding xattrs to
 his code [yes, i want to make a live-cd selinux system]

 especially as i have had to do some horrible things to fuse
 (userspace filesystem) to get it to cooperate with selinux.

 l.
-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
