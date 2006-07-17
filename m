Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6HImbWm027066
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 14:48:37 -0400
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6HImZ53011181
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 18:48:35 GMT
Message-Id: <200607171848.k6HImHUG020102@turing-police.cc.vt.edu>
To: paul.moore@hp.com
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [PATCH 0/7] Updated patchset w/James' comments
In-Reply-To: Your message of "Mon, 17 Jul 2006 11:52:24 EDT."
             <20060717155224.060020000@hp.com>
From: Valdis.Kletnieks@vt.edu
References: <20060717155224.060020000@hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153162097_13479P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 17 Jul 2006 14:48:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1153162097_13479P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 Jul 2006 11:52:24 EDT, paul.moore@hp.com said:
> Some changes in the patchset based on James Morris' comments over the weekend, in
> addition I rebased the patchset against 2.6.18-rc2.

Minor comment - can you start posting these with Subject: lines that
say something like:

Subject: [Patch X/Y] NetLabel-VNN:

Where 'NN' gets incremented each time you post?  I almost got myself a
patch set in my "to look at" queue that was half Friday's and half today's,
and no good could have come from that. And yes, it's *ok* if Friday's was
-v14 and today is -v15, if we're making progress towards merge-able code.. ;)

(Venkat - I'm cc'ing you as I've seen the same thing with MLSXFRM patchsets)...


--==_Exmh_1153162097_13479P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEu9twcC3lWbTT17ARAgKnAKC4oRhPvFuagMv4Va+JY90L4Al46gCg6u6A
XuLtekHuyI/VaQLGCEf3i6w=
=1U6o
-----END PGP SIGNATURE-----

--==_Exmh_1153162097_13479P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
