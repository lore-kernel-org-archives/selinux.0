Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA19861
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 17:19:37 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA06525
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 22:16:24 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id WAA06521
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 22:16:23 GMT
Date: Mon, 24 Feb 2003 22:19:16 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Clem Skorupka <ragnor@mitre.org>, Wayne Salamon <wsalamon@tislabs.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Core policy
Message-ID: <20030224221916.GB24006@vnl.com>
References: <Pine.LNX.4.33.0302241349350.1479-100000@vox.gw.tislabs.com> <3E5A7BBC.63AF1F96@mitre.org> <200302242212.20796.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200302242212.20796.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Feb 24, 2003 at 10:12:20PM +0100, Russell Coker wrote:
> On Mon, 24 Feb 2003 21:08, Clem Skorupka wrote:
> > Basically think of core as the minimum services/policy that any
> > stripped-down "specialty" server would want.
> > So if I was building a hardened dns server, I would have no need of
> > printing, or an apache web server.  Or inetd/xinetd.
> > I wouldn't need sound.  Or dhcp client.

This sort of thing crossed my mind as well. More applicable
to Russell than others because of the Debian Way... but
perhaps map policy sets so they work nicely with
Debian tasksel, particularly for the default dselect
categories when you boot up a newly installed system for
the first time.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
