Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9KHcjXZ002302
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 13:38:45 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9KHbQui025837
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 17:37:30 GMT
Date: Wed, 20 Oct 2004 18:49:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jaspreet Singh <jsingh@ensim.com>, sds@epoch.ncsc.mil,
   nsa <SELinux@tycho.nsa.gov>
Subject: Re: Virtualization and SELinux
Message-ID: <20041020174938.GL21185@lkcl.net>
References: <1098274225.12118.20.camel@jsingh.india.ensim.com> <20041020151031.GB21185@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041020151031.GB21185@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 20, 2004 at 04:10:31PM +0100, Luke Kenneth Casson Leighton wrote:

> the only thing that you _might_ have to do is add to the [non-chrooted!]
> selinux policy a .te and .fc for a shell program to be used in
> /etc/passwd which can chroot your users and drop them into the right
> user context: i don't know exactly what to suggest there.

 ... btw it would be helpful for you to describe exactly how
 and where you are doing the chrooting.

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
