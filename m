Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01423
	for <selinux@tycho.nsa.gov>; Thu, 6 Feb 2003 12:00:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA20287
	for <selinux@tycho.nsa.gov>; Thu, 6 Feb 2003 16:57:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA20283
	for <selinux@tycho.nsa.gov>; Thu, 6 Feb 2003 16:57:27 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 29FC8924E5
	for <selinux@tycho.nsa.gov>; Fri,  7 Feb 2003 04:00:09 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 186342DEC
	for <selinux@tycho.nsa.gov>; Thu,  6 Feb 2003 18:00:00 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: The patent problem rears it's ugly head again
Date: Thu, 6 Feb 2003 18:00:00 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QSpQ+U4Rn21uNO/"
Message-Id: <200302061800.00297.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_QSpQ+U4Rn21uNO/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It seems that SE Linux isn't going into the main kernel until the patent 
issues are resolved.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_QSpQ+U4Rn21uNO/
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 8bit
Content-Description: Alan Cox <alan@lxorguk.ukuu.org.uk>: Re: [BK PATCH] LSM changes for 2.5.59

Return-Path: <linux-security-module-admin@wirex.com>
Delivered-To: bofh@sws.net.au
Received: (qmail 26573 invoked by uid 501); 6 Feb 2003 16:54:41 -0000
Delivered-To: rjc-bofh@coker.com.au
Received: (qmail 26570 invoked from network); 6 Feb 2003 16:54:41 -0000
Received: from unknown (HELO sat.sws.net.au) (postfix@10.10.10.30)
  by 10.10.10.8 with SMTP; 6 Feb 2003 16:54:41 -0000
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 4F20BBF5C
	for <bofh@coker.com.au>; Fri,  7 Feb 2003 03:54:41 +1100 (EST)
Received: from mail.wirex.com (mithra.wirex.com [65.102.14.2])
	by sat.sws.net.au (Postfix) with ESMTP id 2FFE2BF58
	for <bofh@coker.com.au>; Fri,  7 Feb 2003 03:54:37 +1100 (EST)
Received: from mithra.wirex.com (mithra.wirex.com [127.0.0.1])
	by mail.wirex.com (Postfix) with ESMTP
	id 34EBE2F071; Thu,  6 Feb 2003 08:54:01 -0800 (PST)
Delivered-To: linux-security-module@wirex.com
Received: from irongate.swansea.linux.org.uk (pc2-cwma1-4-cust86.swan.cable.ntl.com [213.105.254.86])
	by mail.wirex.com (Postfix) with ESMTP id 4E03E2EFF1
	for <linux-security-module@wirex.com>; Thu,  6 Feb 2003 08:53:41 -0800 (PST)
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.6/8.12.6) with ESMTP id h16Hp6YU010969;
	Thu, 6 Feb 2003 17:51:07 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.6/8.12.6/Submit) id h16Hp3Wx010967;
	Thu, 6 Feb 2003 17:51:03 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [BK PATCH] LSM changes for 2.5.59
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Stephen D. Smalley" <sds@epoch.ncsc.mil>,
 greg@kroah.com,
 Linus Torvalds <torvalds@transmeta.com>,
 linux-security-module@wirex.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030206151820.A11019@infradead.org>
References: <200302061502.KAA06538@moss-shockers.ncsc.mil>
	 <20030206151820.A11019@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044553862.10374.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
X-Spam-Status: No, hits=-3.8 required=5.0
	tests=IN_REP_TO,X_AUTH_WARNING,AWL
	version=2.31
X-Spam-Level: 
Sender: linux-security-module-admin@wirex.com
Errors-To: linux-security-module-admin@wirex.com
X-BeenThere: linux-security-module@wirex.com
X-Mailman-Version: 2.0.11
Precedence: bulk
List-Help: <mailto:linux-security-module-request@wirex.com?subject=help>
List-Post: <mailto:linux-security-module@wirex.com>
List-Subscribe: <http://mail.wirex.com/mailman/listinfo/linux-security-module>,
	<mailto:linux-security-module-request@wirex.com?subject=subscribe>
List-Id: Pluggable linux security module framework <linux-security-module.wirex.com>
List-Unsubscribe: <http://mail.wirex.com/mailman/listinfo/linux-security-module>,
	<mailto:linux-security-module-request@wirex.com?subject=unsubscribe>
List-Archive: <http://mail.wirex.com/pipermail/linux-security-module/>
Date: 06 Feb 2003 17:51:02 +0000
X-Virus-Scanned: by AMaViS new-20020517
X-Razor-id: aa75f87a1d76983976b4c188d3d34261f555c7a9
X-Spam-Status: No, hits=-4.4 tests=IN_REP_TO
Status: R 
X-Status: N
X-KMail-EncryptionState: 
X-KMail-SignatureState: 

On Thu, 2003-02-06 at 15:18, Christoph Hellwig wrote:
> Life would be a lot simpler if you got the core flask engine in a mergeable
> shapre earlier and we could have merged the hooks for actually using it
> incrementally during 2.5, discussing the pros and contras for each hook

I'm not sure we can until the flask engine patent problems with secure
computing are completely resolved and understood. 

Getting it all resolved and in the base 2.7 early, with any cleanup, fixing
needed would be a good step forward


_______________________________________________
linux-security-module mailing list
linux-security-module@wirex.com
http://mail.wirex.com/mailman/listinfo/linux-security-module

--Boundary-00=_QSpQ+U4Rn21uNO/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
